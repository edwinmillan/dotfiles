ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

#Pyenv and git settings
if [[ -s /usr/local/bin/pyenv ]] ; then
  RPS1='$(git_custom_status)%{$fg[yellow]%}[%{$fg[cyan]%}`pyenv version | cut -f 1 -d " "`%{$fg[yellow]%}]%{$reset_color%} $EPS1'
fi

PROMPT='%{$fg_bold[red]%}%B[%b%~% %{$fg_bold[red]%}%B]%b%(?.%{$fg_bold[cyan]%}.%{$fg[red]%})%B$%b '
