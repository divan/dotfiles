parse_git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  [[ "${ref#refs/heads/}" == "master" ]] && { echo "(M)"; return; }
  echo "("${ref#refs/heads/}")"
}

export PS1="\[\e[36;1m\][mac@\[\e[32;1m\]\W \[\e[33;1m\]\$(parse_git_branch)\[\e[0m\]]\$ "

set -o vi

complete -C /Users/divan/bin/gocomplete go

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/Users/divan/.local/bin:$PATH
