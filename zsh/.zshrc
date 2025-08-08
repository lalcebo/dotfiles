# ZSH Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK

# Add path to current $PATH environment if not exist
add_to_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Add current directory, node_modules/.bin, vendor/bin to PATH
add_to_path .
add_to_path ./bin
add_to_path ./node_modules/.bin
add_to_path ./vendor/bin

# Add other directories to PATH
add_to_path $HOME/.local/bin
add_to_path $HOME/.composer/vendor/bin
add_to_path $HOME/.config/php/bin
add_to_path $HOME/.bun/bin
add_to_path $HOME/.config/flutter/bin
add_to_path $HOMEBREW_PREFIX/opt/mysql-client/bin
add_to_path $HOMEBREW_PREFIX/opt/ruby/bin
[ ! -d $(gem environment gemdir)/bin ] && mkdir -p $(gem environment gemdir)/bin
add_to_path $(gem environment gemdir)/bin
add_to_path $HOME/.pub-cache/bin
add_to_path $HOME/.claude/local
add_to_path $HOME/.opencode/bin

[ -f "$HOME/.config/zsh/custom.zsh" ] && source "$HOME/.config/zsh/custom.zsh"
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/key-bindings.zsh" ] && source "$HOME/.config/zsh/key-bindings.zsh"
[ -f "$HOME/.config/zsh/terminal-title-wrapper.zsh" ] && source "$HOME/.config/zsh/terminal-title-wrapper.zsh"

# Completions
source $HOME/.bun/_bun
source <(ng completion script)
source <(flutter bash-completion)

# opencode
export PATH=/Users/lalcebo/bin:$PATH

. "$HOME/Library/Application Support/krita/ai_diffusion/server/uv/env"
