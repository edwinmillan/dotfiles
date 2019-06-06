#!/bin/bash

dotfiles_dir=$HOME/.dotfiles
oh_my_zsh_dir=$dotfiles_dir/oh-my-zsh
oh_my_zsh_theme_dir=$oh_my_zsh_dir/themes

files="zshrc vimrc"
oh_my_zsh_theme=zero-gallois.zsh-theme
zsh_syntax_highlighting=$oh_my_zsh_dir/plugins/zsh-syntax-highlighting
zsh_autosuggestions=$oh_my_zsh_dir/plugins/zsh-autosuggestions



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
        # If the platform is Linux, try an apt to install zsh and then recurse
        if [[ $platform == 'Linux' ]]; then
            sudo apt install zsh
            install_zsh
        # If the platform is OS X, tell the user to install zsh :)
        elif [[ $platform == 'Darwin' ]]; then
            echo "Please install zsh, then re-run this script!"
            exit
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
    elif [ -f $HOME/.$1 ]; then
        echo "Detected regular file at $HOME/.$1, backing up to $HOME and symlinking to $dotfiles_dir/$1"
        mv $HOME/.$1 $HOME/.$1$(date +$d-%m-%Y-%H%M)
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

# Install Zsh Syntax Highlighting
if [ ! -d $zsh_syntax_highlighting ]; then
    echo "$zsh_syntax_highlighting doesn't exist, cloning into $oh_my_zsh_dir/plugins"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $zsh_syntax_highlighting
else
    echo "$zsh_syntax_highlighting exists, skipping!"
fi

# Install Zsh Autosuggestions
if [ ! -d $zsh_autosuggestions ]; then
    echo "$zsh_autosuggestions doesn't exist, cloning into $oh_my_zsh_dir/plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions $zsh_autosuggestions
else
    echo "$zsh_autosuggestions exists, skipping!"
fi

# Symlink Zsh Theme
if [ ! -f $oh_my_zsh_theme_dir/$oh_my_zsh_theme ]; then
    echo "$oh_my_zsh_theme_dir/$oh_my_zsh_theme doesn't exist, symlinking from $dotfiles_dir"
    ln -s $dotfiles_dir/$oh_my_zsh_theme $oh_my_zsh_theme_dir
else
    echo "$oh_my_zsh_theme_dir/$oh_my_zsh_theme exists, skipping!"
fi

# Symlink files
for file in $files; do
    symlink_file $file
done
