parse_git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  [[ "${ref#refs/heads/}" == "master" ]] && { echo "(M)"; return; }
  echo "("${ref#refs/heads/}")"
}

export PS1="\[\e[36;1m\][mac@\[\e[32;1m\]\W \[\e[33;1m\]\$(parse_git_branch)\[\e[0m\]]\$ "

set -o vi
