# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# open
env=$(uname -a | cut -d' ' -f1,3)
if [[ $env =~ .*(wsl|WSL).* ]]; then
  alias open="explorer.exe"
elif [[ $env =~ .*(Darwin).* ]]; then
  alias code="open -a Visual\ Studio\ Code"
  alias chrome="open -a Google\ Chrome"
fi

# vim
alias vi="nvim"
alias vim="nvim"

# git
alias gg="git grep -n"
alias gd="git diff"
alias gs="git status"
alias gc="git checkout"

# 256 color
export TERM="xterm-256color"

# .local/bin
export PATH="$PATH:$HOME/.local/bin"

## asdf
. $HOME/.asdf/asdf.sh

## asdf go
function go_path() {
  eval "$(asdf env go | grep GOPATH)"
  export PATH="$PATH:$GOPATH/bin"
}
go_path

## asdf java
. ~/.asdf/plugins/java/set-java-home.zsh

## asdf auto reshim
function _asdf() {
  asdf $@

  if [[ $? != 0 ]]; then
    return
  fi

  if [[ $1 == "global" ]]; then
    asdf reshim $2

    if [[ $2 == "golang" ]]; then
      go_path
    fi
  fi
}
alias asdf=_asdf

## tmux
if [[ ! -n "$TMUX" ]]; then
  tmux new-session && exit
fi
