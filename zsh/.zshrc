# ======================================
# 🧩 Zsh Configuration (Optimized for Starship)
# ======================================

# 🧭 PATH SETUP
export ZSH="$HOME/.oh-my-zsh"

# Add Homebrew to PATH
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# RbEnv
eval "$(rbenv init -)"

# Flutter setup
export PATH="$HOME/development/flutter/bin:$PATH"

# Android SDK setup
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"

# Java setup
export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Clean up PATH duplicates
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/bin:$PATH"

# ======================================
# 🧠 Oh My Zsh Setup
# ======================================

ZSH_THEME=""  # No theme; Starship will handle the prompt

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ======================================
# 🌟 Starship Prompt
# ======================================

eval "$(starship init zsh)"

# ======================================
# 🧰 Custom Functions
# ======================================

# Fuzzy cd using fzf
fcd() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf) && cd "$dir" || return
}

# ======================================
# 🧠 Developer Aliases
# ======================================

# --- Navigation ---
#alias ..="cd .."
#alias ...="cd ../.."
# alias ....="cd ../../.."
# alias c="clear"

# --- File Listing ---
alias ls="ls --color=auto"
# alias ll="ls -lh"
# alias la="ls -la"

# --- Config Editing ---
alias n="nvim"
# alias v="nvim"
alias zrc="nvim ~/.zshrc"
alias src="source ~/.zshrc"
# alias star="nvim ~/.config/starship.toml"
alias rz="exec zsh"

# --- Git Shortcuts ---
# alias g="git"
# alias gs="git status"
# alias ga="git add ."
# alias gc="git commit -m"
# alias gp="git push"
# alias gl="git pull"
# alias gb="git branch"
# alias gco="git checkout"
# alias gcm="git checkout main"
# alias gd="git diff"
# alias glog="git log --oneline --graph --decorate"

# --- LazyGit Shortcuts ---
alias lg="lazygit"

# --- Flutter ---
alias fr="flutter run"
alias fb="flutter build"
alias fcl="flutter clean"
alias fp="flutter pub get"

# --- Node / npm ---
# alias nr="npm run"
# alias ni="npm install"
# alias nd="npm run dev"

# --- Python ---
alias py="python3"
alias venv="source venv/bin/activate"

# --- Sketchybar ---
alias skre="sketchybar --reload"

# --- System Utils ---
alias update="brew update && brew upgrade && brew cleanup"
alias ip="ifconfig | grep inet"
alias h="history | tail -n 20"
alias path="echo $PATH | tr ':' '\n'"

# ======================================
# 🧩 FZF Integration
# ======================================

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ======================================
# ✅ End of Configuration
# ======================================

# Added by Antigravity
export PATH="/Users/aritrasanyal/.antigravity/antigravity/bin:$PATH"
