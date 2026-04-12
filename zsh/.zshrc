# ======================================
# 🧩 Zsh Configuration (Optimized for Dev)
# ======================================

# ======================================
# 🧭 PATH / Environment Setup
# ======================================

# Oh My Zsh location
export ZSH="$HOME/.oh-my-zsh"

# --------------------------------------
# 🍺 Homebrew (must be early)
# --------------------------------------
if command -v brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi  

# --------------------------------------
# 💎 Ruby (rbenv) - FIXED
# --------------------------------------

export RBENV_ROOT="$HOME/.rbenv"

if [ -d "$RBENV_ROOT" ]; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init - zsh)"
fi

# --------------------------------------
# 🐦 Flutter
# --------------------------------------
export PATH="$PATH:/opt/homebrew/Caskroom/flutter/latest/flutter/bin"

# --------------------------------------
# 🤖 Android SDK
# --------------------------------------
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"

# --------------------------------------
# ☕ Java (OpenJDK)
# --------------------------------------
export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# --------------------------------------
# 🚀 Antigravity (only once)
# --------------------------------------
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# --------------------------------------
# 🤖 Claude Proxy (Dev setup)
# --------------------------------------
export ANTHROPIC_BASE_URL="http://localhost:8080"
export ANTHROPIC_AUTH_TOKEN="test"

# --------------------------------------
# 🦀 Rust (CORRECT WAY)
# --------------------------------------
# This loads cargo, rustc into PATH
. "$HOME/.cargo/env"

# ======================================
# 🧠 Oh My Zsh Setup
# ======================================

ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ======================================
# 🧰 Custom Functions
# ======================================

# 🔍 Fuzzy directory change
fcd() {
  local dir
  dir=$(find . -type d 2>/dev/null | fzf) && cd "$dir" || return
}

# ======================================
# 🧠 Developer Aliases
# ======================================

# Navigation
alias n="nvim"
alias zrc="nvim ~/.zshrc"
alias src="source ~/.zshrc"
alias rz="exec zsh"

# Listing (using eza)
alias ls="eza"
alias ll="eza -lh"
alias la="eza -la"

# Git UI
alias lg="lazygit"

# Flutter shortcuts
alias fr="flutter run"
alias fb="flutter build"
alias fcl="flutter clean"
alias fp="flutter pub get"

# Python
alias py="python3"
alias venv="source venv/bin/activate"

# SketchyBar
alias skre="sketchybar --reload"

# OpenCode
alias oc="opencode"

# Utilities
alias update="brew update && brew upgrade && brew cleanup"
alias ip="ifconfig | grep inet"
alias h="history | tail -n 20"
alias path="echo $PATH | tr ':' '\n'"

# ======================================
# 🔧 Config Editing Shortcuts
# ======================================

alias star="nvim ~/.config/starship.toml"
alias nvrc="nvim ~/.config/nvim"
alias skrc="nvim ~/.config/sketchybar"

# ======================================
# 🧩 FZF Integration
# ======================================

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ======================================
# 🌟 Starship Prompt (Load Last)
# ======================================

eval "$(starship init zsh)"

# ======================================
# 🧩 Dart Completion (optional)
# ======================================

[[ -f ~/.dart-cli-completion/zsh-config.zsh ]] && source ~/.dart-cli-completion/zsh-config.zsh

# ======================================
# ✅ End of Configuration
# ======================================
