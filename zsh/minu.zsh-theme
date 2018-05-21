# sorin.zsh-theme
# screenshot: http://i.imgur.com/aipDQ.png

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"

  local colour_blood='F{124}'
  local colour_brick='F{130}'
  local colour_lime='F{118}'
  local colour_orange='F{166}'
  local colour_pink='F{161}'
  local colour_purple='F{135}'
  local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

  PROMPT='${ret_status} %{$fg[cyan]%}%~$(git_prompt_info)$(git_prompt_status)%{$reset_color%}%(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%} $)%{$reset_color%} '

  ZSH_THEME_GIT_PROMPT_PREFIX="%{%${colour_blood}%}|%{%${colour_brick}%}"   # brick
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  ZSH_THEME_GIT_PROMPT_ADDED="%{%${colour_lime}%}●"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{%${colour_pink}%}●"
  ZSH_THEME_GIT_PROMPT_DELETED="%{%${colour_orange}%}●"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{%${colour_purple}%}●"
else
  MODE_INDICATOR="❮❮❮"
  local return_status="%(?::⏎)"

  PROMPT='%c$(git_prompt_info) %(!.#.❯) '

  ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='${return_status}$(git_prompt_status)'

  ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
  ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
  ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi
