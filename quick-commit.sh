#!/bin/zsh

set -euo pipefail
 
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Error: not inside a Git repository." >&2
  exit 1
fi
 
cd "$(git rev-parse --show-toplevel)"
 
branch=$(git rev-parse --abbrev-ref HEAD)
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
default_msg="Quick-commit: $branch at $timestamp [ci skip]"
msg=${1:-$default_msg}
 
git status --short
git add -A
 
if ! git diff --cached --quiet; then
  git commit -m "$msg"
else
  echo "No staged changes to commit."
fi
 
if [[ "$branch" == "main" || "$branch" == "master" ]]; then
  echo "Pushing safely to $branch..."
  git push --set-upstream origin "$branch"
else
  echo "Force-pushing (with lease) to $branch..."
  git push --force-with-lease --set-upstream origin "$branch"
fi
