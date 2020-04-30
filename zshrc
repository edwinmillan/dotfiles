ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gallois"
ZPLUG_HOME=$HOME/.zplug

# Auto update oh-my-zsh
DISABLE_UPDATE_PROMPT=true


source $ZSH/oh-my-zsh.sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Begin Plugins
source $ZPLUG_HOME/init.zsh

# Oh-My-Zsh Plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/zsh-autosuggestions", from:oh-my-zsh
zplug "plugins/zsh-syntax-highlighting", from:oh-my-zsh
zplug "plugins/django", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh

# Terminal
zplug "DarrinTisdale/zsh-aliases-exa"

# Generic
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

# Themes
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  package       # Package version
  golang        # Go section
  venv          # virtualenv section
  pyenv         # Pyenv section
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Prompt
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_PREFIXES_SHOW=false

# Char
SPACESHIP_CHAR_SUFFIX=" "

# User
SPACESHIP_USER_SHOW=needed
SPACESHIP_USER_PREFIX=" "

# Dir
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false

# Git
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_SUFFIX=" "

# Pyenv
SPACESHIP_PYENV_SYMBOL=""


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load #--verbose

# if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
#     tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
# fi
