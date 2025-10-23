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

# --- Install Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed."
fi

# --- Update & basic tools ---
brew update
brew upgrade

echo "📦 Installing CLI tools..."
brew install stow starship fzf eza zoxide

# --- Fonts ---
echo "🔤 Installing developer fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono
brew install --cask font-cascadia-code
brew install --cask font-fira-code
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-cascadia-code-nerd-font
brew install --cask font-fira-code-nerd-font

# --- Apps ---
echo "🧩 Installing desktop apps..."
brew install --cask \
  google-chrome \
  spotify \
  whatsapp \
  microsoft-office \
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
echo "⚙️ Applying macOS system settings..."

## Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

## Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 42

## Keyboard & Trackpad
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

## Apply
killall Finder &>/dev/null || true
killall Dock &>/dev/null || true
killall SystemUIServer &>/dev/null || true

echo "✅ macOS setup complete!"
echo "🔁 Please log out or restart to apply all settings."
