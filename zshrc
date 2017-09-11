#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

for config_file ($HOME/dotfiles/zsh/*.zsh) source $config_file

# added by travis gem
[ -f /Users/Nikita/.travis/travis.sh ] && source /Users/Nikita/.travis/travis.sh

# added after updating Java, May 28, 2015
# export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/bin"
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export ECTO_EDITOR=/usr/local/bin/nvim
export ERL_AFLAGS="-kernel shell_history enabled"

# exercism
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi

#
# Aliases & functions
#

function showFiles() {
  defaults write com.apple.finder AppleShowAllFiles YES
  killall Finder /System/Library/CoreServices/Finder.app
}

function hideFiles() {
  defaults write com.apple.finder AppleShowAllFiles NO
  killall Finder /System/Library/CoreServices/Finder.app
}

alias be='bundle exec'
alias brew_up='brew update && brew upgrade && brew cleanup'
alias ga='git add'
alias gaa='git add --all'
alias gd='git diff'
alias gph='git push && git push heroku HEAD:master'
alias gst='git status'
alias imix="iex -S mix"
alias mcc="mix clean && mix compile"
alias mmigrate="mix ecto.migrate && mix ecto.rollback --step 1 && mix ecto.migrate"
alias mpr="mix phx.routes"
alias mps="mix phx.server"
alias vim=nvim

function mcd() {
  mkdir -p $1
  cd $1
}

function dms() {
  docker-machine start $1
  eval $(docker-machine env $1)
  echo "Started docker machine $1 and set env"
  docker-machine ls
}

function replace() {
  find_this="$1"
  shift
  replace_with="$1"
  shift

  items=$(ag -l --nocolor "$find_this" "$@")
  temp="${TMPDIR:-/tmp}/replace_temp_file.$$"
  IFS=$'\n'
  for item in $items; do
    sed "s/$find_this/$replace_with/g" "$item" > "$temp" && mv "$temp" "$item"
  done
}
