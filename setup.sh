#!/usr/bin/env bash
set -e

echo "🍎 Starting macOS setup..."

# --- Install Xcode Command Line Tools ---
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install || true
  # Wait until installation is done
  until xcode-select -p &>/dev/null; do sleep 5; done
fi

# --- Install Homebrew (universal for Intel + Apple Silicon) ---
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Detect architecture and set Homebrew prefix
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi

# Add Homebrew to shell profile if not already added
if ! grep -q "$BREW_PREFIX/bin/brew shellenv" ~/.zprofile 2>/dev/null; then
  echo "🔧 Adding Homebrew to PATH in ~/.zprofile"
  echo "eval \"\$($BREW_PREFIX/bin/brew shellenv)\"" >> ~/.zprofile
fi

# Load for current session
eval "$($BREW_PREFIX/bin/brew shellenv)"

echo "✅ Homebrew initialized from: $BREW_PREFIX"

# --- Update & basic tools ---
brew update
brew upgrade

echo "📦 Installing CLI tools..."
brew install stow starship fzf eza zoxide

# --- Fonts ---
echo "🔤 Installing developer fonts..."
brew install --cask font-jetbrains-mono
brew install --cask font-cascadia-code
brew install --cask font-fira-code
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-cascadia-code-nf
brew install --cask font-fira-code-nerd-font

# --- Apps ---
echo "🧩 Installing desktop apps..."
brew install --cask \
  google-chrome \
  spotify \
  whatsapp \
  microsoft-office-businesspro \
  1password \
  nordvpn \
  maccy

# --- Dev tools (your preferences) ---
brew install --cask windsurf
brew install --cask ghostty
# brew install --cask xnip

# --- Cleanup ---
brew cleanup

# --- Apply macOS Defaults ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/macos/macos-defaults.sh" ]]; then
  bash "$SCRIPT_DIR/macos/macos-defaults.sh"
else
  echo "⚠️  macOS defaults script not found, skipping..."
fi

# --- Deploy Dotfiles with Stow ---
echo "🔗 Deploying dotfiles with Stow..."

# Stow all packages (stow will automatically ignore files listed in .stowrc)
cd "$SCRIPT_DIR"
stow */

echo "✅ macOS setup complete!"
echo "🔁 Please log out or restart to apply all settings."
