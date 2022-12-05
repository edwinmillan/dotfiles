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

# Pyenv
SPACESHIP_PYENV_SYMBOL=""

