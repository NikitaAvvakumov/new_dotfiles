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

alias gst='git status'
alias gaa='git add --all'
alias ga='git add'
alias gd='git diff'
alias be='bundle exec'
alias gph='git push && git push heroku HEAD:master'
alias brew_up='brew update && brew upgrade && brew cleanup'
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
