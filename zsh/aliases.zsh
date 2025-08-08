#!/usr/bin/env zsh

# System
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'
alias sleep='pmset sleepnow'
alias c='clear'
alias e='exit'
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Shortcuts
alias timestamp="date +%s"
alias _='sudo'
alias please='sudo'

# Applications
alias pstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias pcharm='open -a /Applications/PyCharm.app "`pwd`"'
alias wstorm='open -a /Applications/WebStorm.app "`pwd`"'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias l='ls -a'
alias l1='ls -1'
alias la='ls -lAF'
alias ll='ls -al'
alias ls='ls -G'
alias ld='ls -ld --color */'

# Directories
alias md='mkdir -p'
alias dot="cd $DOTFILES"
alias pro="cd $HOME/Projects"
alias doc="$HOME/Documents"
alias dow="$HOME/Downloads"

# Git
alias g='git'
alias ga='git add'
alias gafzf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add' # Git add with fzf
alias grmfzf='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git rm' # Git rm with fzf
alias grfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore' # Git restore with fzf
alias grsfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged' # Git restore --staged with fzf
alias gf='git fetch'
alias gs='git status'
alias gss='git status -s'
alias gup='git fetch && git rebase'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias glo='git pull origin'
alias gl='git pull'
alias gb='git branch '
alias gbr='git branch -r'
alias gd='git diff'
alias gco='git checkout '
alias gcob='git checkout -b '
alias gcofzf='git branch | fzf | xargs git checkout' # Select branch with fzf
alias gre='git remote'
alias gres='git remote show'
alias glgg='git log --graph --max-count=10 --decorate --pretty="oneline"'
alias gm='git merge'
alias gp='git push'
alias gpo='git push origin'
alias ggpush='git push origin $(current_branch)'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gcmnv='git commit --no-verify -m'
alias gcanenv='git commit --amend --no-edit --no-verify'

# Function to commit with ticket ID from the current branch, with optional push
quick_commit() {
  local branch_name ticket_id commit_message push_flag
  branch_name=$(git branch --show-current)
  ticket_id=$(echo "$branch_name" | awk -F '-' '{print toupper($1"-"$2)}')
  commit_message="$ticket_id: $*"
  push_flag=$1

  if [[ "$push_flag" == "push" ]]; then
    # Remove 'push' from the commit message
    commit_message="$ticket_id: ${*:2}" # take all positional parameters starting from the second one
    git commit --no-verify -m "$commit_message" && git push
  else
    git commit --no-verify -m "$commit_message"
  fi
}

alias gqc='quick_commit'
alias gqcp='quick_commit push'

# Terraform
alias tf="terraform"

# Laravel
alias a="artisan"
alias tinker="artisan tinker"
alias serve="artisan serve"
alias av='artisan --version'
alias amfs='artisan migrate:fresh --seed'
alias aclear='artisan optimize:clear'

alias sa="sail artisan"
alias satinker="sail artisan tinker"
alias sav='sail artisan --version'
alias samfs='sail artisan migrate:fresh --seed'
alias saclear='sail artisan optimize:clear'

# K8s
alias kubectl="kubecolor"
