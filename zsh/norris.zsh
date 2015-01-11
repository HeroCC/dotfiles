#So awesome, it deserves its' own file
function norris {
  if [ "$PS1" ]; then
    if [ "$1" ]; then
      timeout $1 wget "http://api.icndb.com/jokes/random" -qO- | jshon -e value -e joke -u |
      recode html | cowsay -f tux
    else
      norris 3
    fi
  fi
}