# Dotfiles

Personal zsh and vim configuration.

## Installation

```bash
git clone https://github.com/edwinmillan/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

Then open Vim and run `:PlugInstall` to install vim plugins.

`install.sh` is idempotent — safe to re-run. It will:
- Install zsh if missing (Linux only; macOS requires manual install)
- Clone oh-my-zsh and zplug into the dotfiles directory
- Symlink `zshrc`, `vimrc`, `oh-my-zsh`, and `zplug` to `~/.<name>`
- Link the custom `gallois` theme into oh-my-zsh's themes directory
- Install [uv](https://github.com/astral-sh/uv) (Python package manager)
- Install vim-plug

Existing files are backed up with a timestamp before symlinking.

## What's Included

- **zsh** — oh-my-zsh + zplug with Spaceship prompt. Plugins: git, git-extras, docker, docker-compose, django, golang, exa aliases, syntax highlighting, autosuggestions.
- **vim** — vim-plug with plugins for Python (jedi-vim), Go (vim-go + gopls), git (fugitive), NERDTree, airline, and vim-hardtime.
- **gallois.zsh-theme** — Custom oh-my-zsh theme (overridden at runtime by spaceship-prompt via zplug).

## Tmux (Optional)

```bash
cd ~ && git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
```
