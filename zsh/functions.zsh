function extract {
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

function exists { which $1 &> /dev/null }

function bgsc { 
if screen -list | awk '{print $1}' | grep -q "$1$"; then
  echo "screen $1 already exists"
else
  screen -d -m -S $1
fi
}

function ialias {
  oldCmd=$(cut -f1 -d"=") <<< "$1"
  newCmd=$(cut -f2 -d"=") <<< "$1"
  baseCmd=$(cut -f1 -d" ") <<< "$newCmd"

  if command -v $baseCmd >/dev/null 2>&1; then
    alias $oldCmd=$newCmd
  else
    echo "Command '$baseCmd' not found, using '$oldCmd'";
    #alias $oldCmd='echo "Command $baseCmd not found, using $oldCmd" && $oldCmd'
  fi
}

function ipath {
  dir="$1"

  if [ -d $dir ]; then
    export PATH="$PATH:$dir"
  fi
}

function refresh_zshrc {
  source ~/.zshrc
}

function set_terminal_title
{
  if [[ $1 == "" ]]; then
    # Re-enable oh-my-zsh's title
    DISABLE_AUTO_TITLE=false
  else
    # Set title
    DISABLE_AUTO_TITLE=true # Oh-My-ZSH fix
    echo -ne "\e]2;$1\a"
  fi
}