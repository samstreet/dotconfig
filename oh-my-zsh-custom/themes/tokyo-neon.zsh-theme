# Tokyo Neon - matches the i3/polybar/rofi/dunst/alacritty rice
# palette: bg #0d0e1a, surface #1a1b26, fg #c0caf5,
#          pink #ff2ec4 (primary), cyan #2ee6ff (secondary), red #ff5566 (alert)

icon_folder=""
icon_branch=""
icon_dirty=""

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#565f89}${icon_branch} %F{#2ee6ff}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#ff5566}${icon_dirty}%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%F{#565f89}╭─%f %F{#ff2ec4}%B'"${icon_folder}"' %~%b%f$(git_prompt_info)
%F{#565f89}╰─%f%(?.%F{#2ee6ff}.%F{#ff5566})❯%f '

RPROMPT='%(?..%F{#ff5566}✗ %?%f)'
