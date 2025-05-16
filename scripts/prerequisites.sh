#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$SCRIPT_DIR/helpers.sh"

install_xcode() {
  info "Installing Apple's CLI tools (prerequisites for Git and Homebrew)..."
  if ! command -v brew > /dev/null; then
    xcode-select --install
    xcodebuild -license accept
  else
    warning "XCode is already installed"
  fi
}

install_homebrew() {
  info "Installing Homebrew..."
  if ! command -v brew > /dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    warning "Homebrew already installed"
  fi
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    install_xcode
    install_homebrew
fi
