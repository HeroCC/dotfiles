# Fix typoed commands
if which thefuck &> /dev/null; then
  eval "$(thefuck --alias dangit)"
fi
