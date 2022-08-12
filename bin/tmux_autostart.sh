TMUX_OPTIONS="-CC"

if [[ ! $TMUX && -t 0 && $TERM_PROGRAM != vscode ]]; then
  first_unattached=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' 2>/dev/null | grep -v '^$' | head -1)
  if [[ $first_unattached ]]; then
    tmux $TMUX_OPTIONS attach-session -t $first_unattached
  else
    tmux $TMUX_OPTIONS new-session
  fi
fi
