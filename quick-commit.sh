#!/bin/zsh

# ===========================
# Safety Options
# ===========================
# -e : Exit immediately if any command fails
# -u : Treat unset variables as an error
# -o pipefail : Fail if any part of a pipeline fails
set -euo pipefail

# ===========================
# Commit Message Setup
# ===========================
# Current branch name
branch=$(git rev-parse --abbrev-ref HEAD)

# Current timestamp
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Default commit message
default_msg="Quick-commit: $branch at $timestamp"

# Use provided message if available, otherwise default
msg=${1:-$default_msg}

# ===========================
# Staging And Commit
# ===========================
# Stage all changes
git add -A

# Commit only if there are staged changes
if ! git diff --cached --quiet; then
  git commit -m "$msg"
else
  echo "No staged changes to commit."
fi

# ===========================
# Push Logic
# ===========================
# Push safely if on main/master, otherwise force-with-lease
if [[ "$branch" == "main" || "$branch" == "master" ]]; then
  echo "Pushing safely to $branch..."
  git push --set-upstream origin "$branch"
else
  echo "Force-pushing (with lease) to $branch..."
  git push --force-with-lease --set-upstream origin "$branch"
fi
