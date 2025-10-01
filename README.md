# Dotfiles

Personal macOS configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

Install the following tools before deploying:

```bash
# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Required tools
brew install stow starship fzf eza zoxide
```

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mudasir87/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Deploy with Stow**:
   ```bash
   stow .
   ```

3. **Restart your shell**:
   ```bash
   source ~/.zshrc
   ```

## Uninstallation

```bash
cd ~/dotfiles
stow -D .
```
