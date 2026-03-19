#!/bin/bash
set -e

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
zplug_dir=$dotfiles_dir/zplug
oh_my_zsh_dir=$dotfiles_dir/oh-my-zsh
oh_my_zsh_theme_dir=$oh_my_zsh_dir/custom/themes

files="zshrc vimrc"
oh_my_zsh_theme=gallois.zsh-theme
vim_plug=$HOME/.vim/autoload/plug.vim


function install_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        # Clone oh-my-zsh repository from GitHub only if it isn't already present
        if [ ! -d $oh_my_zsh_dir ]; then
            git clone https://github.com/robbyrussell/oh-my-zsh.git $oh_my_zsh_dir
        fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [ ! $(echo $SHELL) == $(which zsh) ]; then
            chsh -s $(which zsh)
        fi
    else
        # If zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # If the platform is Linux, try an apt to install zsh
        if [[ $platform == 'Linux' ]]; then
            sudo apt install -y zsh
            if [ ! -f /bin/zsh -a ! -f /usr/bin/zsh ]; then
                echo "zsh installation failed, please install it manually and re-run this script!"
                exit 1
            fi
            install_zsh
        # If the platform is OS X, tell the user to install zsh :)
        elif [[ $platform == 'Darwin' ]]; then
            echo "Please install zsh, then re-run this script!"
            exit 1
        fi
    fi
}

function symlink_file () {
    # Supply the file that's stored in the dotfiles directory
    if [ -L $HOME/.$1 ]; then
        echo "Detected Symlink at $HOME/.$1"
        if [ $(readlink -f $HOME/.$1) == $dotfiles_dir/$1 ]; then
            echo "$dotfiles_dir/$1 symlink is already established in $HOME, skipping!"
        else
            echo "Recreating symlink since it's pointing to  $(readlink -f $HOME/.$1)"
            rm $HOME/.$1
            ln -s $dotfiles_dir/$1 $HOME/.$1
        fi
    elif [ -d $HOME/.$1 ]; then
        echo "Detected directory at $HOME/.$1, backing up and symlinking to $dotfiles_dir/$1"
        mv $HOME/.$1 $HOME/.$1$(date +%d-%m-%Y-%H%M)
        ln -s $dotfiles_dir/$1 $HOME/.$1
    elif [ -f $HOME/.$1 ]; then
        echo "Detected regular file at $HOME/.$1, backing up to $HOME and symlinking to $dotfiles_dir/$1"
        mv $HOME/.$1 $HOME/.$1$(date +%d-%m-%Y-%H%M)
        ln -s $dotfiles_dir/$1 $HOME/.$1
    else
        echo "No file detected at $HOME/.$1, symlinking to $dotfiles_dir/$1"
        ln -s $dotfiles_dir/$1 $HOME/.$1
    fi
}

# Install oh-my-zsh in dotfiles_dir
if [ ! -d $oh_my_zsh_dir ]; then
    echo "$oh_my_zsh_dir doesn't exist, installing into $dotfiles_dir"
    install_zsh
else
    echo "$oh_my_zsh_dir exists, skipping!"
fi

# Symlink oh-my-zsh and zplug into HOME
symlink_file oh-my-zsh
symlink_file zplug

# Install zplug in dotfiles_dir
if [ ! -d $zplug_dir ]; then
    echo "$zplug_dir doesn't exist, installing into $dotfiles_dir"
    git clone https://github.com/zplug/zplug $zplug_dir
else
    echo "$zplug_dir exists, skipping!"
fi

# Symlink Zsh Theme
if [ ! -f $oh_my_zsh_theme_dir/$oh_my_zsh_theme ]; then
    echo "$oh_my_zsh_theme_dir/$oh_my_zsh_theme doesn't exist, symlinking from $dotfiles_dir"
    ln -s $dotfiles_dir/$oh_my_zsh_theme $oh_my_zsh_theme_dir
else
    echo "$oh_my_zsh_theme_dir/$oh_my_zsh_theme exists, skipping!"
fi

# Install uv
if ! command -v uv &>/dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv exists, skipping!"
fi

# Install eza
if ! command -v eza &>/dev/null; then
    echo "Installing eza..."
    sudo apt install -y eza
else
    echo "eza exists, skipping!"
fi

# Install vim-plug
if [ ! -f $vim_plug ]; then
    echo "Installing vim-plug..."
    curl -fLo $vim_plug --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug exists, skipping!"
fi

# Symlink config files
for file in $files; do
    symlink_file $file
done

echo ""
echo "Done! Open Vim and run :PlugInstall to install vim plugins."
