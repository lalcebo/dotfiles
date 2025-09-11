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
 /* Remap Home / End keys */
 /* Home Button*/
 "\UF729" = "moveToBeginningOfLine:";
 /* End Button */
 "\UF72B" = "moveToEndOfLine:";
 /* Shift + Home Button */
 "$\UF729" = "moveToBeginningOfLineAndModifySelection:";
 /* Shift + End Button */
 "$\UF72B" = "moveToEndOfLineAndModifySelection:";
 /* Ctrl + Home Button */
 "^\UF729" = "moveToBeginningOfDocument:";
 /* Ctrl + End Button */
 "^\UF72B" = "moveToEndOfDocument:";
  /* Shift + Ctrl + Home Button */
 "$^\UF729" = "moveToBeginningOfDocumentAndModifySelection:";
 /* Shift + Ctrl + End Button*/
 "$^\UF72B" = "moveToEndOfDocumentAndModifySelection:";
}
EOF
}

apply_osx_system_defaults() {
  info "Applying OSX system defaults..."

  # Close any open System Settings panes, to prevent them from overriding settings we're about to change
  osascript -e 'tell application "System Settings" to quit'

  # Set computer name (as done via System Settings → Sharing)
  sudo scutil --set ComputerName "Lalcebo’s MacBook Pro"
  sudo scutil --set HostName "Lalcebo-MacBook-Pro"
  sudo scutil --set LocalHostName "Lalcebo-MacBook-Pro"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Lalcebo-MacBook-Pro"

  # Disable the sound effects on boot
  sudo nvram SystemAudioVolume=" "
  defaults write "com.apple.systemsound" "com.apple.sound.uiaudio.enabled" -int 0

  # Show the ~/Library folder
  chflags nohidden ~/Library

  # Expand the following File Info panes:
  # "General", "Open with", and "Sharing & Permissions"
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

  # Expand the save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Expand print panel by default
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # Automatically quit the printer app once the print jobs are complete
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  # Disable the "Are you sure you want to open this application?" dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Avoid creating `.DS_Store` files on network and USB devices
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Display ASCII control characters using caret notation in standard text views
  defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

  # Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

  # Save to disk, rather than iCloud, by default
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Set Help Viewer windows to non-floating mode
  defaults write com.apple.helpviewer DevMode -bool true

  # Disable smart quotes and dashes as they're annoying when typing code
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  # Show hidden files inside the Finder
  defaults write com.apple.finder "AppleShowAllFiles" -bool true

  # Finder: show all filename extensions
  defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" && killall Finder

  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Show Status Bar
  defaults write com.apple.finder ShowStatusBar -bool true

  # Keep folders on top when sorting by name
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # Do not show warning when changing the file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  defaults write com.apple.screencapture type -string "png"

  # Enable the WebKit Developer Tools in the Mac App Store
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  # Enable the automatic update check
  defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

  # Enable snap-to-grid for icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

  # Increase grid spacing for icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

  # Increase the size of icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

  # Use list view in all Finder windows by default
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

  # Check for software updates daily, not just once per week
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  # Download newly available updates in background
  defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

  # Install System data files & security updates
  defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

  # Turn on app auto-update
  defaults write com.apple.commerce AutoUpdate -bool true

  # Disable Photos.app from starting everytime a device is plugged in
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    register_keyboard_shortcuts
    apply_osx_system_defaults
fi
