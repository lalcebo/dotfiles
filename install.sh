#!/usr/bin/env bash

set -euo pipefail

# Environment
. zsh/.zshenv

# Scripts
. scripts/helpers.sh
. scripts/prerequisites.sh
. scripts/brew-install-custom.sh
. scripts/osx-defaults.sh
. scripts/symlinks.sh

info "Setting up your 💻 with ❤️"
info "Dotfiles installation initialized..."

read -p "Install apps? [y/n] " install_apps
read -p "Overwrite existing dotfiles? [y/n] " overwrite_dotfiles

# Ask for the administrator password upfront
warning "⚠ We need your password for some installation steps"
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [[ "$install_apps" == "y" ]]; then
  install_xcode
  install_homebrew

  read -p "Install brew bundle? [y/n] " install_bundle
  if [[ "$install_bundle" == "y" ]]; then
    run_brew_bundle
  fi
fi

info "Adding .hushlogin file to suppress 'last login' message in terminal..."
[ ! -f ~/.hushlogin ] && touch ~/.hushlogin

register_keyboard_shortcuts
apply_osx_system_defaults

if [[ "$overwrite_dotfiles" == "y" ]]; then
  warning "Deleting existing dotfiles..."
  ./scripts/symlinks.sh --delete --include-files
fi

./scripts/symlinks.sh --create

# Apps
. git/setup.sh
create_git_config
