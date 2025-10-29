#!/usr/bin/env bash
set -e

echo "⚙️ Applying macOS defaults..."

###############################################################################
# Finder                                                                      #
###############################################################################

# Show hidden files (e.g., .gitignore, .zshrc)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show status bar at bottom of Finder windows
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar at bottom of Finder windows
defaults write com.apple.finder ShowPathbar -bool true

# Set default Finder view to list view ("Nlsv" = List)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Set new Finder windows to open in the user’s home directory
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Prevent creation of .DS_Store files on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# When performing a search, search the current folder by default (the default 'This Mac' is "SCev")
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
# Dock                                                                        #
###############################################################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Don’t show recently used apps in the Dock
defaults write com.apple.dock show-recents -bool false

# Set Dock icon size to 72 pixels
defaults write com.apple.dock tilesize -int 62

###############################################################################
# Keyboard & Trackpad                                                         #
###############################################################################

# Enable tap-to-click on trackpad for this user
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable tap-to-click on trackpad at the login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set fastest key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold (enables key repeat instead)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Enable three-finger drag gesture on trackpad
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Use linear mouse acceleration
defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"

# Disable automatic spelling correction
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# System                                                                     #
###############################################################################

# Disable “Are you sure you want to open this application?” warning
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Show battery percentage
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

###############################################################################
# Dock Apps                                                                     #
###############################################################################
defaults write com.apple.dock persistent-apps -array \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Launchpad.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/1Password.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/WhatsApp.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Teams.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Outlook.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Ghostty.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Windsurf.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>" \
  "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/System Settings.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"


###############################################################################
# Turn on the firewall                                                        #
###############################################################################

# Firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

###############################################################################
# Apply changes                                                               #
###############################################################################

# Restart affected apps/services to apply settings
killall Finder &>/dev/null || true
killall Dock &>/dev/null || true
killall SystemUIServer &>/dev/null || true

echo "✅ macOS defaults applied. Some changes may require logout or restart."
