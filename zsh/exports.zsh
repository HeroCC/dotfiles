# Setup terminal, and turn on colors
export CLICOLOR=1

if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'

export PATH="$HOME/.dotfiles/bin:$PATH"

# https://stackoverflow.com/a/55344565/1709894
export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"

[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

