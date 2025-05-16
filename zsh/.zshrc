# ZSH Options
setopt HIST_IGNORE_ALL_DUPS

# Add path to current $PATH environment if not exist
add_to_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$PATH:$1"
  fi
}

# Add current directory, node_modules/.bin, vendor/bin to PATH
add_to_path .
add_to_path ./bin
add_to_path ./node_modules/.bin
add_to_path ./vendor/bin

# Add other directories to PATH
add_to_path $HOME/.composer/vendor/bin
add_to_path $HOME/.config/php/bin

[ -f "$HOME/.config/zsh/custom.zsh" ] && source "$HOME/.config/zsh/custom.zsh"
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/work.zsh" ] && source "$HOME/.config/zsh/work.zsh"
