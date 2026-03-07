
# dotfiles

Personal macOS development environment configuration.

This repository contains my dotfiles used to configure my terminal, editor, and system environment.
The goal is to make it easy to reproduce my setup on a new machine.

Dotfiles are managed using **GNU Stow**, which creates symlinks from this repository into the appropriate locations in `$HOME`.

---

## Tools & Applications

Main tools configured in this repository:

* **Shell:** Zsh + Oh My Zsh
* **Prompt:** Starship
* **Editor:** Neovim (with lazy.nvim)
* **Terminal:** Ghostty
* **Window manager:** Aerospace
* **Status bar:** SketchyBar
* **System monitors:** btop / htop
* **CLI tools:** fzf, git, ripgrep, etc.

---

## Repository Structure

Each folder represents a package managed by **GNU Stow**.

```
dotfiles
├── zsh
├── git
├── aerospace
├── nvim
├── sketchybar
├── starship
├── ranger
├── ghostty
├── config
└── Brewfile
```

Inside each directory the structure mirrors `$HOME`.

Example:

```
nvim/.config/nvim
```

After stowing, this becomes:

```
~/.config/nvim -> ~/dotfiles/nvim/.config/nvim
```

---

## Requirements

Before installing:

* macOS
* Git
* Homebrew
* GNU Stow

Install dependencies:

```bash
brew install git stow
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/AritraSanyal/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Create symlinks with **stow**:

```bash
stow *
```

This will link all configurations into the correct locations in `$HOME`.

---

## Homebrew Packages

This repo includes a `Brewfile` to manage installed software.

Install everything:

```bash
brew bundle
```

---

## Neovim Setup

Plugins are managed using **lazy.nvim**.

After opening Neovim for the first time:

```
:Lazy sync
```

---

## Updating Dotfiles

To update configurations:

```bash
cd ~/dotfiles
git pull
stow *
```

---

## Notes

* Sensitive files such as SSH keys are **not included** in this repository.
* Some application caches and generated files are intentionally ignored.

---

## License

MIT License
