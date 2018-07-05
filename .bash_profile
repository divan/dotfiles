export GOPATH=/Users/divan
export PATH=/usr/local/go/bin:~/bin:$PATH

# added by Anaconda3 4.3.0 installer
#export PATH="//anaconda/bin:$PATH"

export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PROMPT_DIRTRIM=1

cover () {
	t="/tmp/go-cover.$$.tmp"
	go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}

alias grep='grep --color="auto"'
alias ccat='ccat -G Keyword="yellow" -G Plaintext="lightgray" -G Type="green" -G Punctuation="yellow" -G String="fuchsia"'
alias dirs="dirs -v"
alias p='pushd'
alias o='popd'
alias vim=nvim

parse_git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  [[ "${ref#refs/heads/}" == "master" ]] && { echo "(M)"; return; }
  echo "("${ref#refs/heads/}")"
}

export PS1="\[\e[36;1m\][mac@\[\e[32;1m\]\W \[\e[33;1m\]\$(parse_git_branch)\[\e[0m\]]\$ "

set -o vi

source ~/.git-completion.bash

export HOMEBREW_NO_AUTO_UPDATE=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/divan/google-cloud-sdk/path.bash.inc' ]; then source '/Users/divan/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/divan/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/divan/google-cloud-sdk/completion.bash.inc'; fi

export ANDROID_HOME=/Users/divan/Library/Android/sdk
export ANDROID_NDK_HOME=~/Library/Android/sdk/ndk-bundle/

export PATH="$HOME/.cargo/bin:$PATH"

export STATUS_GO_HOME=~/src/github.com/status-im/status-go
export STATUS_REACT_HOME=~/src/github.com/status-im/status-react
