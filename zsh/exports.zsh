# Setup terminal, and turn on colors
export CLICOLOR=1


zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
[ -n "$TMUX" ] && zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
(( $+commands[exa] )) && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

if (( $+commands[nvim] )); then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'

export PATH="$HOME/.dotfiles/bin:$PATH"

[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

