#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$SCRIPT_DIR/helpers.sh"

register_keyboard_shortcuts() {
  # Register CTRL+/ keyboard shortcut to avoid system beep when pressed
  info "Registering keyboard shortcuts..."
  mkdir -p "$HOME/Library/KeyBindings"
  cat >"$HOME/Library/KeyBindings/DefaultKeyBinding.dict" <<EOF
{
 "^\U002F" = "noop";
}
EOF
}

apply_osx_system_defaults() {
  info "Applying OSX system defaults..."

  # Close any open System Settings panes, to prevent them from overriding settings we're about to change
  osascript -e 'tell application "System Settings" to quit'

  # Disable the sound effects on boot
  sudo nvram SystemAudioVolume=" "
  defaults write "com.apple.systemsound" "com.apple.sound.uiaudio.enabled" -int 0

  # Show the ~/Library folder
  chflags nohidden ~/Library

  # Automatically quit the printer app once the print jobs are complete
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  # Disable the "Are you sure you want to open this application?" dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Avoid creating `.DS_Store` files on network and USB devices
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Show hidden files inside the Finder
  defaults write com.apple.finder "AppleShowAllFiles" -bool true

  # Show Status Bar
  defaults write com.apple.finder "ShowStatusBar" -bool true

  # Do not show warning when changing the file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  defaults write com.apple.screencapture type -string "png"

  # Enable the WebKit Developer Tools in the Mac App Store
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  # Enable the automatic update check
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

  # Check for software updates daily, not just once per week
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  # Download newly available updates in background
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

  # Install System data files & security updates
  defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

  # Turn on app auto-update
  defaults write com.apple.commerce AutoUpdate -bool true
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    register_keyboard_shortcuts
    apply_osx_system_defaults
fi
