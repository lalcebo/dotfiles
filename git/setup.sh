#!/usr/bin/env bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$SCRIPT_DIR/../scripts/helpers.sh"

create_git_config() {
  info "Creating git config file..."

  if [ ! -s "$HOME/.gitconfig" ]; then
    # First, ask for the user's full name and email
    read -p "What is your full name? " NAME
    read -p "What is your email address? " EMAIL

    { \
      echo "[user]"; \
      echo "	name = $NAME"; \
      echo "	email = $EMAIL"; \
      echo "[core]"; \
      echo "	excludesfile = ~/.gitignore"; \
      echo "	autocrlf = input"; \
    } > "$HOME/.gitconfig"
  fi
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    create_git_config
fi
