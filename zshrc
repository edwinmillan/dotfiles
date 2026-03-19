ZSH=$HOME/.oh-my-zsh
# ZSH_THEME overridden by zplug spaceship-prompt below
ZSH_THEME="gallois"
ZPLUG_HOME=$HOME/.zplug

# Auto update oh-my-zsh
DISABLE_UPDATE_PROMPT=true

export EDITOR=vim
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.zsh_history
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

source $ZSH/oh-my-zsh.sh

# uv
export PATH="$HOME/.local/bin:$PATH"
eval "$(uv generate-shell-completion zsh)"

# Begin Plugins
source $ZPLUG_HOME/init.zsh

# Oh-My-Zsh Plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/django", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh

# Terminal
zplug "plugins/eza", from:oh-my-zsh

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
  line_sep      # Line break
  battery       # Battery level and status
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

# Install plugins if there are plugins that have not been installed
if [[ $- == *i* ]] && ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load #--verbose
