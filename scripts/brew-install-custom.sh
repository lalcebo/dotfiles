#!/usr/bin/env bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$SCRIPT_DIR/helpers.sh"

run_brew_bundle() {
  brew_bundle_file="$SCRIPT_DIR/../homebrew/Brewfile"

  if [ -f "$brew_bundle_file" ]; then
    brew bundle install --file="$brew_bundle_file"
  else
    error "Brew bundle file not found"
    return 1
  fi
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  # Check if Homebrew is installed
  if ! command -v brew &>/dev/null; then
    error "Homebrew is not installed. Please install Homebrew first."
    exit 1
  fi
fi
