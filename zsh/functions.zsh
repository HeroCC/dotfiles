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

function bgsc { # Start screen session in background if it doesn't exist
if screen -list | awk '{print $1}' | grep -q "$1$"; then
  echo "screen $1 already exists"
else
  screen -d -m -S $1
fi
}

function ialias { # If command you want to alias to exists, do it, else print an error
if command -v $2 >/dev/null 2>&1; then
  alias $1=$2
elif [[ "$ialias_mute" != 'true' ]]; then
    #echo "Command '$baseCmd' not found, using '$oldCmd'"
    true
    #alias $oldCmd='echo "Command $baseCmd not found, using $oldCmd" && $oldCmd'
  fi
}

function ipath { # If directory exists, add it to path
dir="$1"

if [ -d $dir ]; then
  export PATH="$PATH:$dir"
fi
}

function = { # Simple Calculator
calc="${@//p/+}"
calc="${calc//x/*}"
bc -l <<<"scale=10;$calc"
}

