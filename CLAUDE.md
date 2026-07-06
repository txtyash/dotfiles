## Hardware — ASUS Vivobook 14 Flip (TP3407)

Copilot+ PC / convertible 2-in-1, touchscreen + stylus.

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
| **Hostname** | `nix` |

Audio amp: TAS2781.
Keyboard device: `/dev/input/by-path/platform-i8042-serio-0-event-kbd`

---

## System Overview

- NixOS unstable, flake-based (`~/.config/flake.nix` + `~/.config/configuration.nix`)
- User: `yash`. State version: `26.05`.
- WM: niri (nixpkgs module, `programs.niri.enable`). No display manager, no GNOME.
- Desktop shell/bar: DankMaterialShell (`programs.dms-shell.enable`). DMS generates theme files
  consumed by other apps: `niri/dms/*.kdl`, `ghostty/themes/dankcolors`, `zed/themes/dank-zed-theme.json`,
  `DankMaterialShell/firefox.css`
- Shell: Fish. Audio: Pipewire (+ pulse/alsa compat). Editor: Emacs (`emacs31-pgtk`, as a service)
- Keyboard remap: Kanata service, config `./kanata/vivobook.kbd`
- Speaker fix: `fix-vivobook-speakers` systemd oneshot runs `./fix-speakers.sh` (TAS2781 via i2cset)

## Repo Layout

`~/.config` itself is the git repo (remote: `codeberg.org/textyash/dotfiles`). `.gitignore` excludes
app-generated cruft under `~/.config/*` (browsers, dconf, pulse, etc.) — only intentional dotfiles are
tracked.

## Rebuild Commands

```bash
# Apply config changes
sudo nixos-rebuild switch --flake ~/.config#nix

# Test without persisting across reboot
sudo nixos-rebuild test --flake ~/.config#nix

# Update all flake inputs
nix flake update --flake ~/.config

# Update a single input
nix flake update <input> --flake ~/.config

# Validate flake
nix flake check ~/.config
```

## Flake Inputs

Single input: `nixpkgs` (nixos/nixpkgs, `nixos-unstable`). Everything (niri, DMS, etc.) comes
from nixpkgs modules — no third-party flakes.

## Editing `configuration.nix`

- All packages go in `environment.systemPackages`
- No home-manager — all config is raw files under `~/.config/`
- After editing, `nixos-rebuild test` before `switch` for anything risky
