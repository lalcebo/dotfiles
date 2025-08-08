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

# Compilers
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

export LDFLAGS="-L/opt/homebrew/opt/ruby/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include $CPPFLAGS"

# pkg-config
export PKG_CONFIG_PATH=/opt/homebrew/opt/mysql-client/lib/pkgconfig
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/opt/homebrew/opt/ruby/lib/pkgconfig

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300
