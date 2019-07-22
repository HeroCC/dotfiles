# Setup terminal, and turn on colors
if [[ $TERM == xterm ]]; then export TERM=xterm-256color; fi
export CLICOLOR=1

if [[ -a /usr/bin/nvim ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'

export PATH="$HOME/.dotfiles/bin:$PATH"

