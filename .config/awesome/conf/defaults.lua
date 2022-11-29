Terminal = "alacritty"
Browser = "brave"
Editor = os.getenv("EDITOR") or "lvim"
Editor_cmd = Terminal .. " -e " .. Editor
Modkey = "Mod4"
Compositor = "picom --experimental-backend -b --config ~/.config/picom/picom.conf"
Networking = "nm-applet"
ScreenCapture = "flameshot"
