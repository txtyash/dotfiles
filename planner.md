# Dotfiles

- Swayidle/Swaylock or gtklock for noctalia
- Configure zoxide for bash for claude
- nix shell should use fish
- Setup iio on niri https://github.com/Zhaith-Izaliel/iio-niri?tab=readme-ov-file#usage
- In neovim if there are no suggestions then <C-n> & <C-p> can be used for line up/down.
- 3 finger tap and keyboard shortcut to pause media
- How do I convert my dotfiles also to a devshell so that I have lua lsp in the .config directory
- Customize vimiumc heads up and hints
- `installerIso` flake output parameter for NixOS
- Nvim bind ctrl+g to replace space+p
- Sync music.md to YouTube Music playlist via ytmusicapi — add/remove tracks in music.md reflect in YT playlist
- TuneMyMusic can bulk import text/CSV file → YouTube Music playlist (no scripting). Strip markdown from music.md → one "Artist - Title" per line → upload. Free tier limit ~500 songs/transfer.
- Build `keywave`: Go daemon, audio-reactive keyboard backlight via sysfs. Auto-discovers `/sys/class/leds/*::kbd_backlight`, scales audio amplitude to 0–max_brightness. Audio via `parec`/`pw-cat` pipe or `jfreymuth/pulse` pure Go PA client. Pre-flight checks (sysfs, write perm, audio backend, daemon running) + test-blink on init (write 0→max→restore, user sees flash = hardware confirmed, ~99% compat detection). Toggle via Unix socket IPC. Trigger modes: MPD state, MPRIS DBus, manual. NixOS: udev rule for write access, systemd user service.
