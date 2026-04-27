# Yash's NixOS Dotfiles — Agent Instructions

**Last Updated**: 2026-04-28 00:49

## Self-Maintenance Instructions

### Timestamp rule
Every time this file is edited for any reason, update the **Last Updated** date and time at the top using `date "+%Y-%m-%d %H:%M"`. No exceptions.

### On session start (passive check)
Check git log for commits after the Last Updated date:

```bash
git -C ~/.config log --oneline --since="2026-04-25"
```

If commits touch system config (`configuration.nix`, `flake.nix`, `flake.lock`, hardware files, etc.), check whether those changes should be reflected in this file and update accordingly.

### On active changes
When asked to make changes to the system — packages, services, keybinds, flake inputs, hardware config, or anything else documented here — update the relevant section(s) of this file as part of the same task. Do not wait to be reminded. Then bump the timestamp.

---

## Hardware — ASUS Vivobook 14 Flip (TP3407)

Copilot+ PC / convertible 2-in-1 with touchscreen and stylus support.

| Component | Detail |
|-----------|--------|
| **CPU** | Intel Core Ultra 5 226V, 8 cores/8 threads, 2.1 GHz base / 4.5 GHz boost, 8MB cache |
| **NPU** | Intel AI Boost, up to 40 TOPS |
| **GPU** | Intel Arc Graphics |
| **RAM** | 16GB LPDDR5X (on-package, not upgradeable) |
| **Storage** | 512GB M.2 NVMe PCIe 4.0 SSD |
| **Display** | 14" WUXGA (1920×1200) OLED, 16:10, 60Hz, 500nits HDR peak, 100% DCI-P3, 1B colors, touch, stylus, anti-glare, TÜV certified |
| **Camera** | FHD + IR (Windows Hello-capable), privacy shutter |
| **Wi-Fi** | Wi-Fi 7 (802.11be), tri-band, 2×2 |
| **Bluetooth** | 5.4 |
| **Battery** | 70Wh, 4-cell Li-ion |
| **Charger** | USB-C 65W (20V/3.25A) |
| **Ports** | 1× USB-A 3.2 Gen1, 1× USB-C 3.2 Gen2 (DP+PD), 1× Thunderbolt 4 (DP+PD), 1× HDMI 2.1, 1× 3.5mm combo audio, microSD |
| **Hostname** | `vivobook` |

Audio amp: TAS2781 (requires i2c fix on boot — see Audio section).  
Keyboard device: `/dev/input/by-path/platform-i8042-serio-0-event-kbd`

---

## System Overview

- **OS**: NixOS unstable with flakes
- **WM**: niri (Wayland, niri-unstable via niri-flake)
- **Shell UI**: Noctalia Shell (noctalia-dev/noctalia-shell)
- **Terminal**: Ghostty
- **Shell**: Fish (vi keybindings, starship, zoxide, direnv)
- **Editor**: Neovim
- **User**: yash

## Dotfiles Location

All config tracked as a git repo at `~/.config/`. Key files:

| File/Dir | Purpose |
|----------|---------|
| `AGENTS.md` | This file — agent instructions, update when system changes |
| `~/.config/flake.nix` | Flake inputs & system definition |
| `~/.config/configuration.nix` | Main NixOS config (packages, services, users) |
| `~/.config/hardware/vivobook.nix` | Hardware-specific config |
| `~/.config/niri/config.kdl` | niri WM config (keybinds, layout, rules) |
| `~/.config/noctalia/` | Noctalia shell config & themes |
| `~/.config/kanata/vivobook.kbd` | Keyboard remapping (Caps→Ctrl, key chords) |
| `~/.config/nvim/` | Neovim config (lazy.nvim) |
| `~/.config/fish/config.fish` | Fish shell init |
| `~/.config/fix-speakers.sh` | TAS2781 speaker fix (i2c, runs via systemd) |

## Rebuild Commands

```bash
# Apply NixOS config changes
sudo nixos-rebuild switch --flake ~/.config#vivobook

# Test without committing to boot
sudo nixos-rebuild test --flake ~/.config#vivobook

# Update flake inputs
nix flake update --flake ~/.config

# Update single input
nix flake update noctalia --flake ~/.config

# Check flake
nix flake check ~/.config
```

Always use `--flake ~/.config#vivobook` — the target is always `vivobook`.

## Flake Inputs

| Input | Source | Purpose |
|-------|--------|---------|
| `nixpkgs` | nixos/nixpkgs#nixos-unstable | Base packages |
| `niri-flake` | sodiboo/niri-flake | niri WM (niri-unstable overlay) |
| `noctalia` | noctalia-dev/noctalia-shell | Wayland shell/bar |
| `quickshell` | outfoxxed/quickshell | QML shell toolkit (dep of noctalia) |
| `lanzaboote` | nix-community/lanzaboote v1.0.0 | Secure boot |
| `helium` | schembriaiden/helium-browser-nix-flake | Helium browser |

Cachix binary cache for noctalia: `https://noctalia.cachix.org`

## Noctalia Shell

Wayland shell (bar, launcher, lock screen, control center). Communicate via IPC:

```bash
noctalia-shell ipc call <service> <method>
```

Config: `~/.config/noctalia/`. Themes: `~/.config/noctalia/colorschemes/`.

## niri WM

Config: `~/.config/niri/config.kdl`

After editing `config.kdl`, niri reloads on `nixos-rebuild switch`.

## Audio

Hardware: TAS2781 amplifier. Stack: Pipewire + WirePlumber + PulseAudio compat.

Speaker fix runs as systemd service `fix-vivobook-speakers` on boot and resume. If speakers break:

```bash
sudo systemctl restart fix-vivobook-speakers
# or manually:
sudo bash ~/.config/fix-speakers.sh
```

## Boot & Security

- Secure boot via Lanzaboote (`/var/lib/sbctl`)
- `systemd-boot` disabled (`lib.mkForce false`) — Lanzaboote manages EFI
- Do NOT re-enable systemd-boot without migrating secure boot keys

## GPU

- Intel Arc integrated (iHD driver)
- `LIBVA_DRIVER_NAME=iHD` set in `sessionVariables`
- VA-API packages: `intel-media-driver`, `vpl-gpu-rt`, `intel-compute-runtime`

## Keyboard Remapping (Kanata)

Config: `~/.config/kanata/vivobook.kbd`

Active remaps:
- `Caps Lock` → `Ctrl`
- `LMeta` → `LAlt`
- `LAlt` → `LMeta`
- Chord `LShift+LMeta` → `Ctrl`

Kanata runs as NixOS service (enabled in `configuration.nix`).

## Networking

- NetworkManager with randomized MAC (wifi: `02:01:02:03:04:09`, eth: `02:01:02:03:04:08`)
- DNS: Quad9 (`9.9.9.9`, `149.112.112.112`), NetworkManager `dns = "none"`
- Timezone: `Asia/Kolkata`

## Common Tools

| Tool | Use |
|------|-----|
| `fd` | Fast file find |
| `fzf` | Fuzzy finder |
| `ripgrep` (rg) | Fast grep |
| `gh` | GitHub CLI |
| `lazygit` | TUI git |
| `yazi` | TUI file manager |
| `btop` | System monitor |
| `zoxide` | Smart cd |
| `direnv` | Per-dir env vars |
| `claude` | Claude Code CLI |
| `gemini` | Gemini CLI |

## Docs Quick Links

- niri config: https://niri-wm.github.io/niri/Configuration:-Introduction.html
- niri-flake: https://github.com/sodiboo/niri-flake
- Noctalia shell: https://docs.noctalia.dev
- NixOS options: https://search.nixos.org/options
- nixpkgs search: https://search.nixos.org/packages
- Kanata config: https://github.com/jtroo/kanata/blob/main/docs/config.adoc
- Lanzaboote: https://github.com/nix-community/lanzaboote

## Local Planning

TODOs, issues, and plans are manually added to `planner.md`. A place to dump things to avoid forgetting them later.

---

## Conventions

### Git

- **No `Co-Authored-By` trailer** in commit messages. Do not append `Co-Authored-By: Claude ...` or similar lines.

- All system packages declared in `configuration.nix` under `environment.systemPackages`
- Flake-based packages use `inputs.<name>.packages.${pkgs.stdenv.hostPlatform.system}.default`
- No home-manager — all config is raw files in `~/.config/`
- Commit dotfile changes to `~/.config/` git repo after testing
- Test with `nixos-rebuild test` before `switch` for risky changes
- Update this file and bump **Last Updated** when changing system config
