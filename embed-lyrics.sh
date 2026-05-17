#!/usr/bin/env bash
# embed-lyrics.sh — Fetch and embed lyrics for downloaded songs
# Usage: embed-lyrics.sh <audio-file>
# Deps: ffmpeg, ffprobe, curl, jq

set -uo pipefail

# Re-exec inside nix shell if deps missing
if ! command -v jq &>/dev/null || ! command -v ffprobe &>/dev/null; then
    exec nix shell nixpkgs#jq nixpkgs#ffmpeg-full --command bash "$0" "$@"
fi

FILE="${1:-}"
[[ -z "$FILE" || ! -f "$FILE" ]] && { printf 'Usage: embed-lyrics.sh <audio-file>\n' >&2; exit 1; }

BASENAME="${FILE%.*}"
LRC_FILE="${BASENAME}.lrc"
EXT="${FILE##*.}"

log()       { printf '[lyrics] %s\n' "$*" >&2; }
urlencode() { printf '%s' "$1" | jq -sRr @uri; }

normalize_title() {
    printf '%s' "$1" \
        | sed -E 's/^[^-]+ - //' \
        | sed -E 's/ \(feat\.[^)]*\)//gI' \
        | sed -E 's/ \[feat\.[^]]*\]//gI' \
        | sed -E 's/ \((Official|Audio|Video|Lyric|Music Video|HD|HQ|4K|Remaster(ed)?)[^)]*\)//gI' \
        | sed -E 's/ \[(Official|Audio|Video|Lyric|Music Video|HD|HQ|4K|Remaster(ed)?)[^]]*\]//gI' \
        | sed -E 's/ - [0-9]{4} Remaster(ed)?( Version)?//gI' \
        | sed -E 's/[[:space:]]+/ /g; s/^[[:space:]]+|[[:space:]]+$//'
}

# Strip LRC timestamps → plain text; handle both synced and plain .lrc
lrc_to_plain() {
    local c="$1"
    if printf '%s' "$c" | grep -qE '^\[[0-9]+:[0-9]+\.[0-9]+\]'; then
        printf '%s' "$c" \
            | sed -E 's/^\[[0-9]+:[0-9]+\.[0-9]+\] ?//' \
            | grep -v '^\[' \
            | grep -v '^[[:space:]]*$' \
            || true
    else
        printf '%s' "$c"
    fi
}

get_meta() {
    local tags
    tags=$(ffprobe -v quiet -print_format json -show_format "$FILE" 2>/dev/null \
           | jq -r '.format.tags // {}')
    TITLE=$(printf '%s'  "$tags" | jq -r '.title  // .TITLE  // ""')
    ARTIST=$(printf '%s' "$tags" | jq -r '.artist // .ARTIST // .album_artist // .ALBUM_ARTIST // ""')
    DURATION=$(ffprobe -v quiet -print_format json -show_entries format=duration "$FILE" 2>/dev/null \
               | jq -r '.format.duration // "0"' | cut -d. -f1)
    if [[ -z "$TITLE" || -z "$ARTIST" ]]; then
        local bn; bn=$(basename "$BASENAME")
        # Filename convention: "Title - Artist"
        TITLE="${bn% - *}"
        ARTIST="${bn##* - }"
    fi
}

get_embedded() {
    local tags
    tags=$(ffprobe -v quiet -print_format json -show_format "$FILE" 2>/dev/null \
           | jq -r '.format.tags // {}')
    # Check dedicated lyrics tag first
    local lyr
    lyr=$(printf '%s' "$tags" | jq -r '.lyrics // .LYRICS // .["©lyr"] // ""')
    if [[ -n "$lyr" ]]; then printf '%s' "$lyr"; return; fi
    # Fallback: extract "Lyrics:\n\n..." section from description (common in yt-dlp downloads)
    local desc
    desc=$(printf '%s' "$tags" | jq -r '.description // .synopsis // ""')
    if printf '%s' "$desc" | grep -qi 'lyrics:'; then
        printf '%s' "$desc" | sed -n '/[Ll]yrics:/,$ { /[Ll]yrics:/d; p }' | sed '/^$/{ N; /^\n$/d }' | head -200
    fi
}

embed_lyrics() {
    local lyrics="$1"
    local tmp="${BASENAME}.lyrics_tmp.${EXT}"
    if ffmpeg -v quiet -i "$FILE" -metadata lyrics="$lyrics" -c copy "$tmp" 2>/dev/null; then
        mv "$tmp" "$FILE"
        log "Embedded lyrics into tags"
    else
        rm -f "$tmp"
        log "WARN: Failed to embed lyrics"
        return 1
    fi
}

# Output: "SYNCED:<content>" | "PLAIN:<content>" | empty
fetch_lrclib() {
    local title="$1" artist="$2" duration="${3:-0}"
    local te ae r
    te=$(urlencode "$title"); ae=$(urlencode "$artist")

    # 1. Direct get with duration hint
    r=$(curl -sf --max-time 5 \
        "https://lrclib.net/api/get?track_name=${te}&artist_name=${ae}&duration=${duration}" \
        2>/dev/null) || r=""

    # 2. Direct get without duration
    if [[ -z "$r" ]]; then
        r=$(curl -sf --max-time 5 \
            "https://lrclib.net/api/get?track_name=${te}&artist_name=${ae}" \
            2>/dev/null) || r=""
    fi

    # 3. Structured search
    if [[ -z "$r" ]]; then
        r=$(curl -sf --max-time 5 \
            "https://lrclib.net/api/search?track_name=${te}&artist_name=${ae}" \
            2>/dev/null \
            | jq -c 'if type=="array" and length>0 then .[0] else empty end' 2>/dev/null) || r=""
    fi

    # 4. Free-text search
    if [[ -z "$r" ]]; then
        local qe; qe=$(urlencode "$title $artist")
        r=$(curl -sf --max-time 5 "https://lrclib.net/api/search?q=${qe}" \
            2>/dev/null \
            | jq -c 'if type=="array" and length>0 then .[0] else empty end' 2>/dev/null) || r=""
    fi

    [[ -z "$r" ]] && return

    local synced plain
    synced=$(printf '%s' "$r" | jq -r '.syncedLyrics // ""')
    plain=$(printf '%s'  "$r" | jq -r '.plainLyrics  // ""')
    if   [[ -n "$synced" ]]; then printf 'SYNCED:%s' "$synced"
    elif [[ -n "$plain"  ]]; then printf 'PLAIN:%s'  "$plain"
    fi
}

# Output: "PLAIN:<content>" | empty
fetch_lyricsovh() {
    local title="$1" artist="$2"
    local r
    r=$(curl -sf --max-time 5 \
        "https://api.lyrics.ovh/v1/$(urlencode "$artist")/$(urlencode "$title")" \
        2>/dev/null) || r=""
    [[ -z "$r" ]] && return
    local lyrics
    lyrics=$(printf '%s' "$r" | jq -r '.lyrics // ""')
    [[ -n "$lyrics" ]] && printf 'PLAIN:%s' "$lyrics"
}

# Fetch from all sources in parallel, return best (synced > plain, lrclib > ovh)
fetch_all() {
    local title="$1" artist="$2" duration="${3:-0}"
    local ntitle; ntitle=$(normalize_title "$title")
    local tmpd; tmpd=$(mktemp -d)

    fetch_lrclib    "$title"  "$artist" "$duration" > "$tmpd/lrclib"   2>/dev/null &
    fetch_lyricsovh "$title"  "$artist"             > "$tmpd/ovh"      2>/dev/null &
    if [[ "$ntitle" != "$title" ]]; then
        fetch_lrclib    "$ntitle" "$artist" "$duration" > "$tmpd/lrclib_n" 2>/dev/null &
        fetch_lyricsovh "$ntitle" "$artist"             > "$tmpd/ovh_n"    2>/dev/null &
    fi
    wait

    local result=""
    for f in lrclib lrclib_n ovh ovh_n; do
        [[ -f "$tmpd/$f" ]] || continue
        local c; c=$(cat "$tmpd/$f")
        if [[ "$c" == SYNCED:* ]]; then
            log "Got synced lyrics ($f)"; result="$c"; break
        fi
    done

    if [[ -z "$result" ]]; then
        for f in lrclib lrclib_n ovh ovh_n; do
            [[ -f "$tmpd/$f" ]] || continue
            local c; c=$(cat "$tmpd/$f")
            if [[ "$c" == PLAIN:* ]]; then
                log "Got plain lyrics ($f)"; result="$c"; break
            fi
        done
    fi

    rm -rf "$tmpd"
    [[ -n "$result" ]] && printf '%s' "$result"
}

# ── Main ────────────────────────────────────────────────────────────────────

TITLE="" ARTIST="" DURATION=0
get_meta

log "$(basename "$FILE") | $ARTIST — $TITLE"

embedded=$(get_embedded)
has_tags=false;  [[ -n "$embedded" ]] && has_tags=true
has_lrc=false;   [[ -f "$LRC_FILE" && -s "$LRC_FILE" ]] && has_lrc=true

if $has_tags && $has_lrc; then
    log "Both tags and .lrc present — skipping"
    exit 0
fi

if $has_tags && ! $has_lrc; then
    log "Tags have lyrics → writing .lrc"
    printf '%s\n' "$embedded" > "$LRC_FILE"
    exit 0
fi

if ! $has_tags && $has_lrc; then
    log ".lrc exists → embedding into tags"
    plain=$(lrc_to_plain "$(cat "$LRC_FILE")")
    [[ -n "$plain" ]] && embed_lyrics "$plain"
    exit 0
fi

# Neither — fetch
log "Fetching..."
result=$(fetch_all "$TITLE" "$ARTIST" "$DURATION")

if [[ -z "$result" ]]; then
    log "Not found — skipping"
    exit 0
fi

content="${result#*:}"
printf '%s\n' "$content" > "$LRC_FILE"

if [[ "$result" == SYNCED:* ]]; then
    log "Synced .lrc written"
    plain=$(lrc_to_plain "$content")
else
    log "Plain .lrc written"
    plain="$content"
fi

[[ -n "$plain" ]] && embed_lyrics "$plain"
log "Done"
