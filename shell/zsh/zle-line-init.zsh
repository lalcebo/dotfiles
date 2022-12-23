#!/usr/bin/env zsh

# Cycle through dirstack
insert-cycledleft () {
  emulate -L zsh
  setopt nopushdminus
  builtin pushd -q +1 &>/dev/null || true
  # zle reset-prompt
  zle .reset-prompt # For Oh My Posh
}

zle -N insert-cycledleft

insert-cycledright () {
  emulate -L zsh
  setopt nopushdminus
  builtin pushd -q -0 &>/dev/null || true
  # zle reset-prompt
  zle .reset-prompt # For Oh My Posh
}

zle -N insert-cycledright

bindkey "\e[1;6D" insert-cycledleft   # Shift + left arrow
bindkey "\e[1;6C" insert-cycledright  # Shift + right arrow

# Save dirstack history to .zdirs
# (adapted from https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc#L1547)
DIRSTACKSIZE=${DIRSTACKSIZE:-20}
dirstack_file=${dirstack_file:-${HOME}/.zdirs}

if [[ -f ${dirstack_file} ]] && [[ ${#dirstack[*]} -eq 0 ]] ; then
  dirstack=( ${(f)"$(< $dirstack_file)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

chpwd_functions+=(chpwd_dirpersist)
chpwd_dirpersist() {
  if (( $DIRSTACKSIZE <= 0 )) || [[ -z $dirstack_file ]]; then return; fi
  local -ax my_stack
  my_stack=( ${PWD} ${dirstack} )
  builtin print -l ${(u)my_stack} >! ${dirstack_file}
}
