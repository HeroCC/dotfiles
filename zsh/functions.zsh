function bgsc { # Start screen session in background if it doesn't exist
if screen -list | awk '{print $1}' | grep -q "$1$"; then
  echo "screen $1 already exists"
else
  screen -d -m -S $1
fi
}

function ialias { # If command you want to alias to exists, do it, else print an error
  (( $+commands[$2] )) && alias $1=$2
}

function ipath { # If directory exists, add it to path
  [ -d "$1" ] && export PATH="$PATH:$dir"
}

function = { # Simple Calculator
calc="${@//p/+}"
calc="${calc//x/*}"
bc -l <<<"scale=10;$calc"
}

