function trytmuxexit {
  if [[ -r $HOME/.tmuxframeexit ]]; then
    rm ~/.tmuxframeexit
  else
    exit
  fi
}

function exitt {
  touch $HOME/.tmuxframeexit
  exit
}

if [[ -z "$TMUX_AUTOSTARTED" && -z "$SSH_CONNECTION" ]]; then
  export TMUX_AUTOSTARTED='true'
  tmux -2 attach -t m || tmux -2 new-session -s m && trytmuxexit
fi
