# Secrets
[ -f "$HOME/.env" ] && source "$HOME/.env"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

# Locale settings
export LANG="en_US.UTF-8" # Sets default locale for all categories
export LC_ALL="en_US.UTF-8" # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# GPG
export GPG_TTY=$(tty)

# Editors
export EDITOR="nano"
export VISUAL="code"

# Add /usr/local/bin to the beginning of the PATH environment variable.
export PATH="/usr/local/bin:$PATH"
