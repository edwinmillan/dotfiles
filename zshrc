# Fixes a plugin error
autoload -Uz compinit
compinit

ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="gallois"

# Pyenv environment
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Activate Antidote Plugin Manager
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Auto update oh-my-zsh
DISABLE_UPDATE_PROMPT=true


source $ZSH/oh-my-zsh.sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# Themes
source $(brew --prefix)/opt/spaceship/spaceship.zsh

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
