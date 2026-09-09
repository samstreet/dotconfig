# dotfiles

i3 rice — Tokyo Neon theme. i3 + polybar + rofi + dunst + picom + alacritty.

## Fresh machine setup

```
git clone <this-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` installs the required packages (`packages.txt`), symlinks each
`.config/<app>` directory into `~/.config/<app>` (backing up anything already
there), and offers to swap left Alt/Ctrl at the XKB level (left Alt acts as
Ctrl).

## Layout

Each directory under `.config/` is the *real* config — `~/.config/<app>` on
this machine is a symlink into this repo, so editing the live config and
editing the repo are the same thing. `git status`/`git add`/`git commit` from
inside `~/.config/i3` (etc.) works fine since it's just a symlinked path into
this working tree.

- `.config/i3` — window manager config + `wallpaper.jpg`. Autotiling
  (dwindle/spiral tiling) is started from here via `exec autotiling`.
- `.config/polybar` — bar config + `scripts/` (pending updates, combined
  dual-battery reader)
- `.config/rofi` — `tokyo-neon.rasi` theme, used as the launcher (`$mod+space`)
- `.config/dunst` — notifications
- `.config/picom` — compositor (blur, rounded corners, neon glow shadow)
- `.config/alacritty` — terminal, Tokyo Night–based colors
- `.config/fish` — shell config; overrides `fish_greeting` (from the
  system-wide `cachyos-fish-config`) to a no-op so new terminals don't run
  fastfetch. `fish_variables` (local shell state) is gitignored.
- `.Xresources` — pins `Xft.dpi` to 96 (apps that auto-detect DPI from the
  monitor's physical size otherwise render oversized) and sets explicit
  hinting/antialiasing (`hintfull`, grayscale AA — subpixel would fringe
  under picom's transparency); loaded on i3 startup via `exec xrdb -merge`
- `.zshrc` — oh-my-zsh config, `ZSH_THEME="tokyo-neon"`
- `oh-my-zsh-custom/themes/tokyo-neon.zsh-theme` — custom prompt matching
  the rest of the rice (pink path, cyan git branch); symlinked into
  `~/.oh-my-zsh/custom/themes/`, not `.config`, since that's where oh-my-zsh
  expects it. `install.sh` installs oh-my-zsh itself if it's missing.
  Alacritty's `[terminal] shell` is pinned to `/usr/bin/zsh` since this
  session's `$SHELL` resolves to fish (via the ly-dm login chain) rather
  than the passwd entry alacritty would otherwise fall back to.

## Known machine-specific bits

These aren't generalized — check them after cloning onto a new machine:

- `.config/i3/config` has `exec xrandr --output eDP-1 --scale 1.25x1.25`
  — output name and scale factor are specific to this laptop's panel;
  adjust or remove for a different monitor setup. Note xrandr's scale is
  inverted from intuition: >1 shrinks UI (more desktop space), <1 enlarges it.
- Keyboard layout is hardcoded to `gb` in the Alt/Ctrl swap step.
- `$mod+Shift+p` runs `gnome-calculator`, `$mod+Shift+f` opens `thunar` —
  install anything you want that isn't already in `packages.txt`.
- `redshift` is referenced in the i3 autostart but not installed by default.

## Theme

Palette: background `#0d0e1a`, surface `#1a1b26`, foreground `#c0caf5`,
pink `#ff2ec4` (primary accent), cyan `#2ee6ff` (secondary), red `#ff5566`
(alerts). Same palette across i3 borders, polybar, rofi, dunst, alacritty,
the zsh prompt, and the i3lock ring colors.

Font: JetBrains Mono Nerd Font everywhere (bar/rofi/dunst text and
alacritty), verified to cover the icon glyph ranges used (`e0a0-e0d7`,
`f000-f385`, `f400-f533`) before switching off Hack/MesloLGS.
