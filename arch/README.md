# Arch dotfiles

Machine-specific Linux desktop configuration for this laptop.

This folder intentionally tracks reproducible user config and skips generated state, caches, browser profiles, secrets, cookies, databases, private keys, VM state, and app session data.

Shared configs such as Kitty and Neovim live in `../common` and can be copied or symlinked into `~/.config` on any machine.

## Included

- Hyprland compositor config and helper scripts.
- Waybar layout, modules, and styling.
- Rofi, Wofi, and Fuzzel launchers.
- Alacritty, Cava, Waypaper, fontconfig, xsettingsd, Zed, and GTK theme settings.

## Apply locally

From the repository root, copy or symlink the selected files into `$HOME` while preserving paths, for example:

```sh
cp -r common/.config/kitty ~/.config/
cp -r common/.config/nvim ~/.config/
cp -r common/.config/zed ~/.config/
cp -r arch/.config/hypr ~/.config/
cp -r arch/.config/waybar ~/.config/
```
