#!/bin/zsh

DOTFILES_DIR="$HOME/.dotfiles"
FILES=(.zshrc .vimrc .ideavimrc .p10k.zsh)

for file in $FILES; do
  source_file="$DOTFILES_DIR/$file"
  target="$HOME/$file"

  # Never link a file the repository does not have; that is how dangling links appear
  if [[ ! -e "$source_file" ]]; then
    echo "Skipped $file (not in the repository)"
    continue
  fi

  # Keep a copy of a real file before replacing it with a symlink
  if [[ -e "$target" && ! -L "$target" ]]; then
    mv "$target" "$target.backup"
    echo "Backed up $file to $file.backup"
  fi

  ln -sf "$source_file" "$target"
  echo "Linked $file"
done
