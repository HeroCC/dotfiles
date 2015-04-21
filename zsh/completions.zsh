# RBenv Completions
if [ -d $HOME/.rbenv ]; then
  eval "$(rbenv init -)"
fi

# NPM Completions
if which npm &> /dev/null; then
  eval "$(npm completion -)"
fi
