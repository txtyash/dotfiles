# VimiumC

## Keybindings

```
map s LinkHints.activate
map S LinkHints.activateOpenInNewTab
map f LinkHints.activateFocus
map F LinkHints.activateHover
map K previousTab
map J nextTab
map ys LinkHints.activateCopyLinkUrl
unmap yf
unmap <a-f>
```

## Default Search Engine

```
https://www.google.com/search?q=%s Google
```

## Search engines

```
;m:  https://www.merriam-webster.com/dictionary/%s Merriam
;ho: https://home-manager-options.extranix.com/?query=%s&release=master
;no: https://search.nixos.org/options?channel=%s&query=dank
;np: https://search.nixos.org/packages?channel=unstable&query=%s
;g: https://www.google.com/search?q=%s \
  www.google.com re=/^(?:\.[a-z]{2,4})?\/search\b.*?[#&?]q=([^#&]*)/i \
  blank=https://www.google.com/ Google
;b: https://search.brave.com/search?q=%s Brave
;d: https://duckduckgo.com/?q=%s DuckDuckGo

;gm: https://www.google.com/maps?q=%s \
  blank=https://www.google.com/maps Google Maps
;y: https://www.youtube.com/results?search_query=%s \
  blank=https://www.youtube.com/ YouTube
;w: https://www.wikipedia.org/w/index.php?search=%s Wikipedia

;a: https://www.amazon.in/s?k=%s \
  blank=https://www.amazon.com/ Amazon

;;: vimium://math\ $S re= Calculate
;gh: https://github.com/search?q=$s \
  blank=https://github.com/ GitHub Repo
```
