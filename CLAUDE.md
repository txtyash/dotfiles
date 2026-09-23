## Hosts

Shared config in `configuration.nix`; per-host in `hosts/<name>/default.nix`. A
`configuration.nix` change hits **both** hosts.

| Flake attr | What it is |
|------------|------------|
| `vivobook` | ASUS Vivobook 14 Flip (TP3407), bare metal |
| `p14s` | VMware guest VM on a ThinkPad P14s host |

`networking.hostName` matches the flake attr on both — keep that invariant. There is no `#nix` attr.

## Hardware — Vivobook 14 Flip (TP3407)

Copilot+ convertible 2-in-1, touch + stylus.

| Component | Detail |
|-----------|--------|
| **CPU / NPU / GPU** | Core Ultra 5 226V (8c/8t, 2.1→4.5 GHz) · AI Boost 40 TOPS · Arc Graphics |
| **RAM / Storage** | 16GB LPDDR5X (soldered) · 512GB NVMe PCIe 4.0 |
| **Display** | 14" 1920×1200 OLED 16:10, 60Hz, 500nit HDR, 100% DCI-P3, touch + stylus |
| **Wireless** | Wi-Fi 7 tri-band 2×2 · BT 5.4 |
| **Power** | 70Wh · USB-C 65W |
| **Ports** | USB-A 3.2g1 · USB-C 3.2g2 · TB4 · HDMI 2.1 · 3.5mm · microSD |
| **Camera** | FHD + IR, privacy shutter |

Audio amp TAS2781. Vivobook-only: `fix-vivobook-speakers` oneshot runs `hosts/vivobook/fix-speakers.sh`
(i2cset) on boot **and resume** — read the unit-ordering comments before touching it. Also Ollama
(`ollama-vulkan`, iGPU), Proton VPN, qBittorrent, Bluetooth, Quad9 DNS, MAC randomization.

**p14s**: VM only — ~10GB RAM, ext4, zramSwap, `vscode`. No Bluetooth/speaker fix/Ollama.

## System Overview

- NixOS unstable, flake-based. User `yash`, stateVersion `26.05` (DO NOT CHANGE)
- WM: niri (`programs.niri.enable`). No display manager or greeter
- Login: password-protected TTY. `programs.bash.loginShellInit` `exec`s `niri-session` on `/dev/tty1`
  when `WAYLAND_DISPLAY` is unset; tty2–6 stay plain shells. Autologin deliberately **not** enabled
- Shell: login shell is **bash**; fish is enabled for interactive use only — login-time setup goes in
  bash options
- DankMaterialShell (`programs.dms-shell.enable`) generates themes consumed elsewhere: `niri/dms/*.kdl`,
  `ghostty/themes/dankcolors`, `zed/themes/dank-zed-theme.json`, `DankMaterialShell/firefox.css`
- Pipewire (+pulse/alsa). Emacs `emacs31-pgtk` as a service
- Kanata remap, per-host config `kanata/{vivobook,thinkpad-p14s}.kbd`, both on device
  `/dev/input/by-path/platform-i8042-serio-0-event-kbd`
- Single flake input: `nixpkgs` (`nixos-unstable`). No third-party flakes
- `~/.config` *is* the git repo (`github.com/txtyash/dotfiles`); `.gitignore` excludes app-generated
  cruft so only intentional dotfiles are tracked

## Rebuild

```bash
sudo nixos-rebuild switch --flake ~/.config#$(hostname)
sudo nixos-rebuild test  --flake ~/.config#$(hostname)   # no persist across reboot
nixos-rebuild dry-build  --flake ~/.config#$(hostname)   # eval+build, no sudo
nix flake update [<input>] --flake ~/.config
nix flake check ~/.config
```

## Editing config

- No home-manager — config is raw files under `~/.config/`
- Packages: `environment.systemPackages` in `configuration.nix` (shared) or the host file (host-only)
- `dry-build` catches eval errors without sudo; `test` before `switch` for anything risky
