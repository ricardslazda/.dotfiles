# ===========================
# Powerlevel10k Instant Prompt
# ===========================
 
# Speeds up shell startup by loading the prompt early
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
 
# ===========================
# Homebrew
# ===========================
 
# Initialize Homebrew if installed (macOS package manager)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
 
# ===========================
# Zinit (Plugin Manager)
# ===========================
 
# Define install path
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
 
# Install zinit if missing
if [[ ! -d "$ZINIT_HOME" ]]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
 
# Load zinit
source "${ZINIT_HOME}/zinit.zsh"
 
# ===========================
# Plugins
# ===========================
 
# Powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k
 
# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting
 
# Extra completions
zinit light zsh-users/zsh-completions
 
# fzf-powered tab completion
zinit light Aloxaf/fzf-tab
 
# Oh-My-Zsh extract plugin
zinit snippet OMZP::extract
 
# Enable completion system
autoload -Uz compinit && compinit
 
# Enhanced vi mode plugin
zinit light jeffreytse/zsh-vi-mode
 
# Replay zinit completions
zinit cdreplay -q
 
# ===========================
# Powerlevel10k Configuration
# ===========================
 
# Disable the Powerlevel10k configuration wizard
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
 
# ===========================
# History Configuration
# ===========================
 
# History file size
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
 
# Append instead of overwrite
setopt appendhistory
 
# Share history across sessions
setopt sharehistory
 
# Ignore commands starting with space
setopt hist_ignore_space
 
# Remove all older duplicates
setopt hist_ignore_all_dups
 
# Don’t save duplicates
setopt hist_save_no_dups
 
# Ignore duplicates in current session
setopt hist_ignore_dups
 
# Avoid duplicate matches during search
setopt hist_find_no_dups
 
# ===========================
# Completion Styles
# ===========================
 
# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
 
# Use LS_COLORS for completion colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
 
# Disable menu selection
zstyle ':completion:*' menu no
 
# Preview directory contents when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
 
# Preview target directory contents when completing zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
 
# ===========================
# Aliases
# ===========================
 
# Launch system monitor
alias b="btop"

# Extract compressed archives
alias e="extract"

# Display simplified man pages
alias t="tldr"

# Open Git TUI
alias g="lazygit"

# Open Docker TUI
alias d="lazydocker"

# Open pet snippet picker and execute selected command
alias p="pet exec"
 
# Run quick Git commit & push script
c() { "$HOME/quick-commit.sh" "$@"; }
 
# Open Vim in current directory or on specified files
v() {
  if [[ $# -eq 0 ]]; then
    vim .
  else
    vim "$@"
  fi
}
 
# ===========================
# Fzf and Zoxide
# ===========================
 
# Initialize fzf (fuzzy finder)
eval "$(fzf --zsh)"
 
# Initialize zoxide (smarter cd)
eval "$(zoxide init --cmd cd zsh)"
