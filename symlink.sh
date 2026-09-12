#!/bin/zsh

DOTFILES_DIR="$HOME/.dotfiles"
FILES=(.zshrc .vimrc .ideavimrc .p10k.zsh .claude-statusline.sh)

for file in $FILES; do
  source_file="$DOTFILES_DIR/$file"
  target="$HOME/$file"

  if [[ ! -e "$source_file" ]]; then
    echo "Skipped $file (not in the repository)"
    continue
  fi

  if [[ -e "$target" && ! -L "$target" ]]; then
    mv "$target" "$target.backup"
    echo "Backed up $file to $file.backup"
  fi

  ln -sf "$source_file" "$target"
  echo "Linked $file"
done
