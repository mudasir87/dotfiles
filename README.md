# Dotfiles

Personal macOS configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

This repository uses a **package-based structure** where each tool has its own directory:

- `ssh/` - SSH client configuration
- `zsh/` - Zsh shell configuration
- `starship/` - Starship prompt configuration
- `ghostty/` - Ghostty terminal configuration
- `windsurf/` - Windsurf IDE settings

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

2. **Create SSH directory** (required for proper file-level symlinking):
   ```bash
   mkdir -p ~/.ssh && chmod 700 ~/.ssh
   ```

3. **Deploy all packages**:
   ```bash
   stow */
   ```

   Or install specific packages:
   ```bash
   stow ssh zsh starship
   ```

4. **Restart your shell**:
   ```bash
   source ~/.zshrc
   ```

## Uninstallation

```bash
cd ~/dotfiles
# Uninstall all packages
stow -D */

# Or uninstall specific packages
stow -D ssh zsh
```

## Notes

- The SSH package only symlinks the `config` file, not the entire `.ssh` directory
- Files like `known_hosts` will stay in `~/.ssh/` and won't appear in this repository
- Each package can be installed/uninstalled independently
