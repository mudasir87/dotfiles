# Dotfiles

Personal macOS configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

This repository uses a **package-based structure** where each tool has its own directory:

- `ssh/` - SSH client configuration
- `zsh/` - Zsh shell configuration
- `starship/` - Starship prompt configuration
- `ghostty/` - Ghostty terminal configuration
- `windsurf/` - Windsurf IDE settings

## Quick Start (Full Setup)

For a **fresh macOS machine**, run the complete setup script:

```bash
git clone https://github.com/mudasir87/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

This will:
- ✅ Install Homebrew
- ✅ Install CLI tools (stow, starship, fzf, eza, zoxide)
- ✅ Install fonts (JetBrains Mono, Cascadia Code, Fira Code + Nerd Fonts)
- ✅ Install desktop apps (Chrome, Spotify, WhatsApp, Office, 1Password, etc.)
- ✅ Install dev tools (Windsurf, Ghostty)
- ✅ Apply macOS system defaults
- ✅ Deploy all dotfiles with Stow

## Manual Installation Options

### Option 1: Only Deploy Dotfiles (Stow)

If you already have the required tools installed and only want to symlink dotfiles:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mudasir87/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Prerequisites**:
   ```bash
   brew install stow starship fzf eza zoxide
   ```

3. **Create SSH directory** (required for proper file-level symlinking):
   ```bash
   mkdir -p ~/.ssh && chmod 700 ~/.ssh
   ```

4. **Deploy all packages**:
   ```bash
   stow */
   ```

   Or install specific packages:
   ```bash
   stow ssh zsh starship ghostty windsurf
   ```

5. **Restart your shell**:
   ```bash
   source ~/.zshrc
   ```

### Option 2: Only Apply macOS Defaults

If you only want to apply macOS system settings without installing apps or dotfiles:

```bash
cd ~/dotfiles
bash macos/macos-defaults.sh
```

This will configure:
- **Finder**: Show hidden files, status bar, path bar, list view, disable warnings
- **Dock**: Auto-hide, minimize to app icon, hide recents, set icon size
- **Keyboard & Trackpad**: Enable tap-to-click, fast key repeat, three-finger drag
- **System**: Disable app quarantine warning, show battery percentage, enable firewall
- **Dock Apps**: Set default dock applications

## Uninstallation

```bash
cd ~/dotfiles
# Uninstall all packages
stow -D */

# Or uninstall specific packages
stow -D ssh zsh
```
