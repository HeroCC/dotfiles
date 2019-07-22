# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'

alias sudo='sudo ' # Makes sudo use aliases, from https://askubuntu.com/a/22043/353466
alias please='sudo $(fc -nl -1)' # Repeat last command with sudo

# I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'

# Apt stuff
if which apt-get &> /dev/null; then
  alias agi='sudo apt-get install'
  alias agp='sudo apt-get purge'
  alias agr='sudo apt-get remove'
  alias agu='sudo apt-get update'
  alias agug='sudo apt-get upgrade'
  alias aguu='sudo apt-get update && sudo apt upgrade'
  alias agar='sudo apt-get autoremove'
  alias agdu='sudo apt-get dist-upgrade'
fi

ialias vim nvim

alias path='echo -e ${PATH//:/\\n}' # Formatted path
alias mkdir='mkdir -pv' # Verbose & Parents mkdir flag

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' # Coppied from default Ubuntu bash config

