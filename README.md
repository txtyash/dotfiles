# Yash's NixOS configuration

I use home-manager as a standalone module. All of my configuration files reside in the `.config` folder in their respective configuration languages. I use the `home.file` attribute to recursively link those configuration files and thus it saves me from having to nixify my dotfiles.
