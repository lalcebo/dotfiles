#!/usr/bin/env bash

default_color=$(tput sgr 0)
red="$(tput setaf 1)"
yellow="$(tput setaf 3)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"

info() {
  printf "%s==> %s%s\n" "$blue" "$1" "$default_color"
}

success() {
  printf "%s==> %s%s\n" "$green" "$1" "$default_color"
}

error() {
  printf "%s==> %s%s\n" "$red" "$1" "$default_color"
}

warning() {
  printf "%s==> %s%s\n" "$yellow" "$1" "$default_color"
}

# Ask for the administrator password upfront
admin_auth() {
  warning "⚠ We need your password for some installation steps"
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}