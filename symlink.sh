#!/bin/zsh
 
DOTFILES_DIR="$HOME/.dotfiles"
FILES=(.zshrc .vimrc .ideavimrc quick-commit.sh)
 
for file in $FILES; do
  ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
  echo "Linked $file"
done
