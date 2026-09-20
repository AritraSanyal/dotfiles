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

export HOMEBREW_GITHUB_API_TOKEN=""

# --------------------------------------
# 💎 Ruby (rbenv)
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
# -- Pub --
export PATH="$PATH:$HOME/.pub-cache/bin"

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
# 🚀 Antigravity
# --------------------------------------
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# --------------------------------------
# 🤖 Claude Proxy (Dev setup)
# --------------------------------------
# export ANTHROPIC_BASE_URL="http://localhost:8080"
# export ANTHROPIC_AUTH_TOKEN="test"

# --------------------------------------
# ⚙️ MacPorts
# --------------------------------------
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# --------------------------------------
# 🦀 Rust (correct setup)
# --------------------------------------
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
# 🧰 Custom Functions (FZF + Dev Tools)
# ======================================

# Remove conflicting aliases from Oh My Zsh
unalias gcb 2>/dev/null
unalias glog 2>/dev/null
unalias fd 2>/dev/null

# 🔍 Open file in nvim
vf() {
  local file
  file=$(fzf)
  [ -n "$file" ] && nvim "$file"
}

# 🌿 Git branch switcher
gcb() {
  local branch
  branch=$(git branch --all | sed 's/^..//' | fzf)
  [ -n "$branch" ] && git checkout "$branch"
}

# 📜 Git log viewer
glog() {
  git log --oneline --graph --decorate --all | fzf
}

# 💀 Kill process safely
fkill() {
  local pid
  pid=$(ps aux | fzf | awk '{print $2}')
  [ -n "$pid" ] && kill -9 "$pid"
}

# Fuzzy directory jump
fj() {
  # Use 'command' to ensure we hit the binary, not the function
  local dir
  dir=$(command fd -t d 2>/dev/null | fzf --height 40% --reverse)
  
  if [ -n "$dir" ]; then
    cd "$dir" || return
    # This part is optional: it clears the line and shows where you landed
    zle && zle reset-prompt 
  fi
}

# 🔎 Search project → open in nvim
vgrep() {
  local file
  file=$(rg --files | fzf)
  [ -n "$file" ] && nvim "$file"
}

# ======================================
# 🧠 Developer Aliases
# ======================================

# Navigation
alias n="nvim"
alias zrc="nvim ~/.zshrc"
alias src="source ~/.zshrc"
alias rz="exec zsh"

# Listing
alias ls="eza"
alias ll="eza -lh"
alias la="eza -la"

# Git UI
alias lg="lazygit"

# Flutter
alias fr="flutter run"
alias fb="flutter build"
alias fcl="flutter clean"
alias fp="flutter pub get"

# ADB
alias adbphone="adb connect $(netstat -nr | awk '/default/ {print $2; exit}'):5555"
#
# Python
alias py="python3"
alias venv="source venv/bin/activate"

# Clipboard
alias clip="pbpaste"

# SketchyBar
alias skre="sketchybar --reload"

# Aerospace
alias aerore="aerospace reload-config"

# OpenCode
alias oc="opencode"

# Utilities
alias update="brew update && brew upgrade && brew cleanup"
alias ip="ifconfig | grep inet"
alias h="history | tail -n 20"
alias path="echo $PATH | tr ':' '\n'"

# tty-clock
alias clock="tty-clock -s"
alias centerclock="tty-clock -s -c"

# DisplayPlacer
alias m90='displayplacer "id:3AAE6B03-61B3-42F5-0857-D6964E3302DB digree:90"'
alias m270='displayplacer "id:3AAE6B03-61B3-42F5-0857-D6964E3302DB digree:270"'
alias m0='displayplacer "id:3AAE6B03-61B3-42F5-0857-D6964E3302DB digree:0"'

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
export PATH="/Library/TeX/texbin:$PATH"


# Added by Antigravity CLI installer
export PATH="/Users/aritrasanyal/.local/bin:$PATH"
export PATH="/Users/aritrasanyal/.local/bin:$PATH"
