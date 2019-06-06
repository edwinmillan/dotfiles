ZSH=$HOME/.oh-my-zsh
ZSH_THEME="zero-gallois"

plugins=(
  git
  git-extras
  docker
  docker-compose
  zsh-autosuggestions
  zsh-syntax-highlighting
  django
  pyenv
  pip
  golang
)


source $ZSH/oh-my-zsh.sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
