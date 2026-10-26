# dotfiles

Personal macOS development environment configuration.

This repository contains my dotfiles used to configure my terminal, editor, and system environment.
The goal is to make it easy to reproduce my setup on a new machine.

Dotfiles are managed using **GNU Stow**, which creates symlinks from this repository into the appropriate locations in `$HOME`.

---

## Tools & Applications

Main tools configured in this repository:

- **Window Manager:** Aerospace (tiling window manager for macOS)
- **Status Bar:** SketchyBar (custom themes, workspace & system monitors)
- **Terminal:** Ghostty (Catppuccin Mocha theme)
- **Shell:** Zsh + Oh My Zsh
- **Prompt:** Starship (Catppuccin Mocha palette)
- **Editor:** Neovim (lazy.nvim, blink.cmp, conform.nvim, kickstart-based)
- **System Monitors:** btop / htop
- **CLI Tools:** fzf, git, eza, ripgrep, etc.
- **Languages & SDKs:** Flutter/Dart, Rust, Swift, Python, Java

---

## Repository Structure

Each folder represents a package managed by **GNU Stow**:

```
dotfiles
├── aerospace/      # Aerospace window manager config (~/.aerospace.toml)
├── config/         # XDG ~/.config directory
│   ├── btop/       # btop system monitor
│   ├── ghostty/    # Ghostty terminal config
│   ├── nvim/       # Neovim configuration
│   ├── sketchybar/ # SketchyBar status bar & plugins
│   ├── starship/   # Starship prompt configuration
│   └── ...
├── fzf/            # fzf shell integration (~/.fzf.zsh)
├── git/            # Git configuration (~/.gitconfig)
├── script/         # Custom maintenance scripts (e.g. update_ios_simulators.sh)
├── zsh/            # Zsh configuration (~/.zshrc)
└── Brewfile        # Homebrew bundle snapshot (packages, casks, fonts)
```

Inside each directory the structure mirrors `$HOME`.

Example:

```
config/.config/nvim  -->  ~/.config/nvim
zsh/.zshrc          -->  ~/.zshrc
```

---

## Requirements

Before installing on a fresh macOS machine:

- macOS
- Command Line Tools: `xcode-select --install`
- Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- GNU Stow: `brew install stow`

---

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/AritraSanyal/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Restore all Homebrew packages and applications:

   ```bash
   brew bundle --file=~/dotfiles/Brewfile
   ```

3. Create symlinks with **stow**:
   ```bash
   stow aerospace config fzf git zsh
   ```

---

## Homebrew Packages (`Brewfile`)

This repository includes a `Brewfile` capturing all installed command-line formulae, GUI casks, taps, and fonts.

### Install / Restore:

```bash
brew bundle --file=~/dotfiles/Brewfile
```

### Update `Brewfile`:

Whenever you install new tools or casks and want to update the snapshot:

```bash
brew bundle dump --force --describe --file=~/dotfiles/Brewfile
```

---

## Neovim Setup

Plugins and tools are managed automatically:

- **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Completion:** [blink.cmp](https://github.com/Saghen/blink.cmp) (Rust-powered fuzzy autocompletion)
- **Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim) (unified formatting on save for Lua, Dart, Rust, Swift)
- **LSP & Tools:** [mason.nvim](https://github.com/williamboman/mason.nvim)

On first launch, plugins will install automatically. To sync plugins manually:

```vim
:Lazy sync
```

To check active formatters on any file:

```vim
:ConformInfo
```

---

## Helper Scripts

Custom helper scripts live in [`script/`](script/):

- **`script/update_ios_simulators.sh`**: Interactive CLI tool to clean up old runtime caches, remove unavailable virtual devices, and download the latest iOS platforms. Run via alias:
  ```bash
  sims
  ```

---

## Updating Dotfiles

To pull updates and restow:

```bash
cd ~/dotfiles
git pull
stow aerospace config fzf git zsh
```

---

## Notes

- Sensitive files such as SSH keys and `.env` credentials are **never tracked**.
- Caches and local runtime states are ignored via `.gitignore`.
