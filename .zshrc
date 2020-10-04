# Path to your oh-my-zsh installation.
export ZSH="/Users/sean/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HIST_STAMPS="yyyy-mm-dd"

plugins=(git docker httpie thefuck)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

export PATH=$GOBIN:$PATH
