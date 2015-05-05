# RBenv Completions
if which rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

# NPM Completions
if which npm &> /dev/null; then
  eval "$(npm completion -)"
fi

# JEnv Completions
if which jenv &> /dev/null; then
  eval "$(jenv init -)"
fi
