# Setup terminal, and turn on colors
export CLICOLOR=1
setopt promptsubst

zstyle ':completion:*:descriptions' format '[%d]'
(( $+commands[eza] )) && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

if [[ -n "$TMUX" ]]; then
  export FZF_TMUX=1
  export FZF_TMUX_OPTS='-p80%,60%'
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # TODO use fzf-tmux so tab and fzf's behavior is the same
  zstyle ':fzf-tab:*' popup-min-size 50 8
fi

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic --ansi
  --header 'Press CTRL-Y to copy command into clipboard'"

if (( $+commands[nvim] )); then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'

export PATH="$HOME/.dotfiles/bin:$PATH"

[[ -f ~/.config/tabtab/__tabtab.zsh ]] && source ~/.config/tabtab/__tabtab.zsh || true
