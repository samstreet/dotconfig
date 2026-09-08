#!/usr/bin/env bash
# Bootstraps this dotfiles repo onto a fresh Arch/CachyOS machine.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages"
sudo pacman -S --needed - < "$REPO_DIR/packages.txt"

link() {
    local src="$1" target="$2"
    if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$src")" ]; then
        echo "  $(basename "$target") already linked"
        return
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup="${target}.bak.$(date +%s)"
        echo "  backing up existing $target -> $backup"
        mv "$target" "$backup"
    fi
    ln -s "$src" "$target"
    echo "  linked $(basename "$target")"
}

echo "==> Linking configs into ~/.config"
mkdir -p "$HOME/.config"
for app_dir in "$REPO_DIR"/.config/*/; do
    app="$(basename "$app_dir")"
    link "$app_dir" "$HOME/.config/$app"
done

echo "==> Linking root dotfiles into \$HOME"
for f in "$REPO_DIR"/.[!.]*; do
    name="$(basename "$f")"
    [ "$name" = ".git" ] && continue
    [ -f "$f" ] || continue
    link "$f" "$HOME/$name"
done

echo "==> Swapping left Alt / left Ctrl (left Alt becomes Ctrl)"
read -rp "    Apply this keyboard change now? [y/N] " reply
if [[ "$reply" =~ ^[Yy]$ ]]; then
    current_layout="$(localectl status | awk -F': ' '/X11 Layout/ {print $2}')"
    current_model="$(localectl status | awk -F': ' '/X11 Model/ {print $2}')"
    sudo localectl set-x11-keymap "${current_layout:-us}" "${current_model:-pc105}" "" ctrl:swap_lalt_lctl
    echo "    Applied. Takes effect on next login (or run: setxkbmap -option ctrl:swap_lalt_lctl)"
else
    echo "    Skipped."
fi

echo "==> Done. Log out and pick i3 from your display manager (or run 'startx')."
echo "    Known machine-specific bits to check afterwards:"
echo "      - .config/i3/config: the 'exec xrandr --output eDP-1 --scale 1.25x1.25' line assumes this laptop's panel name/scale preference"
echo "      - .config/i3/config: keyboard layout assumed 'gb'"
echo "      - .config/i3/config binds \$mod+Shift+p to gnome-calculator (not in packages.txt - install if you want it)"
echo "      - autostart 'exec --no-startup-id redshift' needs the 'redshift' package if you want it"
