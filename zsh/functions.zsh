function extract { # Detect zipped file format, and if supported, extract
echo Extracting $1 ...
if [ -f $1 ] ; then
  case $1 in
    *.tar.bz2)   tar xjf $1  ;;
*.tar.gz)    tar xzf $1  ;;
*.bz2)       bunzip2 $1  ;;
*.rar)       unrar x $1    ;;
*.gz)        gunzip $1   ;;
*.tar)       tar xf $1   ;;
*.tbz2)      tar xjf $1  ;;
*.tgz)       tar xzf $1  ;;
*.zip)       unzip $1   ;;
*.Z)         uncompress $1  ;;
*.7z)        7z x $1  ;;
*.lrz)       lrzip -d $1;;
*)        echo "'$1' cannot be extracted via extract()" ;;
esac
else
  echo "'$1' is not a valid file"
fi
}

function mysql_start {
  mysql.server start
}

function mysql_stop {
  mysql.server stop
}

# Detect empty enter, execute git status if in git dir
magic-enter () {
  if [[ -z $BUFFER ]]; then
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
      echo -ne '\n'
      git status
    fi
    zle accept-line
  else
    zle accept-line
  fi
}
zle -N magic-enter
bindkey "^M" magic-enter

function exists { which $1 &> /dev/null } # If something exists

function bgsc { # Start screen session in background if it doesn't exist
if screen -list | awk '{print $1}' | grep -q "$1$"; then
  echo "screen $1 already exists"
else
  screen -d -m -S $1
fi
}

function ialias { # If command you want to alias to exists, do it, else print an error
oldCmd=$(cut -f1 -d"=") <<< "$1"
newCmd=$(cut -f2 -d"=") <<< "$1"
baseCmd=$(cut -f1 -d" ") <<< "$newCmd"

if command -v $baseCmd >/dev/null 2>&1; then
  alias $oldCmd=$newCmd
elif [[ "$ialias_mute" != 'true' ]]; then
  echo "Command '$baseCmd' not found, using '$oldCmd'"
    #alias $oldCmd='echo "Command $baseCmd not found, using $oldCmd" && $oldCmd'
  fi
}

function ipath { # If directory exists, add it to path
dir="$1"

if [ -d $dir ]; then
  export PATH="$PATH:$dir"
fi
}

function refresh_zshrc { # Refresh zsh
source ~/.zshrc
}

function set_terminal_title {
  if [ -z $1 ]; then
    # Re-enable oh-my-zsh's title
    DISABLE_AUTO_TITLE=false
  else
    # Set title
    DISABLE_AUTO_TITLE=true # Oh-My-ZSH fix
    echo -ne "\e]2;$1\a"
  fi
}

function update_gitpulls { # Update dotfiles, rbenv, jenv, and antigen
local current_dir="$(pwd)"
if [ -d $HOME/.dotfiles ]; then
  cd $HOME/.dotfiles && ./install.sh -n
fi

if [ -d $HOME/.rbenv ]; then
  cd $HOME/.rbenv && git pull origin master
fi

if [ -d $HOME/.jenv ]; then
  cd $HOME/.jenv && git pull origin master
fi

if which antigen &> /dev/null; then
  antigen update
fi
cd $current_dir
}

function norris { # Print a formatted chuck norris joke
if [ "$1" ]; then
  timeout $1 wget "http://api.icndb.com/jokes/random" -qO- | jshon -e value -e joke -u |
  recode html | cowsay -f tux
else
  norris 3
fi
}

function jenv_prompt_info { # Get only Jenv java version
if [ -d "$HOME/.jenv" ]; then
  echo "$(jenv version-name)"
else
  echo "No Jenv found"
fi
}

function = { # Simple Calculator
calc="${@//p/+}"
calc="${calc//x/*}"
bc -l <<<"scale=10;$calc"
}

function refresh_prompt { # Refreshes only the theme / propmt
antigen theme $HOME/.zsh/custom bira-cust --no-local-clone
}

if [ -d $HOME/.jenv ]; then
  function _jenv { # Jenv workaround to refresh prompt on certian commands
  jenv "$@"
  if [[ "$1" == "shell" ]]; then
    refresh_prompt
  elif [[ "$1" == "local" ]]; then
    refresh_prompt
  elif [[ "$1" == "global" ]]; then
    refresh_prompt
  fi
}
fi

function exitt {
  touch $HOME/.tmuxframeexit
  exit
}

autosuggest_start
