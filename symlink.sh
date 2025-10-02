#!/bin/zsh

# Create symlinks from files in ~/.dotfiles to $HOME
# -s : create a symbolic link
# -f : overwrite existing files/symlinks if they exist

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.ideavimrc ~/.ideavimrc
ln -sf ~/.dotfiles/.aliasrc ~/.aliasrc
ln -sf ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/.dotfiles/.vimiumrc ~/.vimiumrc
ln -sf ~/.dotfiles/quick-commit.sh ~/quick-commit.sh
