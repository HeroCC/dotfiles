# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'

# Same as above, but in long listing format
alias ll='ls -GFhl'

alias ri='ri -Tf ansi'

alias mysql='mysql -u root'
alias mysqladmin='mysqladmin -u root'

alias sudo='sudo ' # Makes sudo use aliases, from http://go.herocc.com/sudo_aliases
ialias apt-get='apt-fast' # http://go.herocc.com/aptfast
alias please='sudo $(fc -nl -1)' # Repeat last command with sudo
alias cls='clr' # Clear the console

# I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'

ialias rm='trash-put' # Requires trash-cli
ialias dd='dcfldd' # DD with a progress report

# Apt stuff
if which apt-get &> /dev/null; then
  alias agi='sudo apt-get install'
  alias agp='sudo apt-get purge'
  alias agr='sudo apt-get remove'
  alias agu='sudo apt-get update'
  alias agug='sudo apt-get upgrade'
  alias aguu='sudo apt-get update && sudo apt-get upgrade'
  alias agar='sudo apt-get autoremove'
fi

alias xtitle='set_terminal_title' # Custom function, see functions.zsh

ialias vim='nvim' # Use the new vim

alias ping='ping -c 5' # Ping only 5 times
alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias path='echo -e ${PATH//:/\\n}' # Formatted path
alias mkdir='mkdir -pv' # Verbose & Parents mkdir flag

ialias git='hub' # Hub by GitHub : http://git.io/xy2eNw

alias jenv="_jenv" # Use the special jenv function

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' # Coppied from default Ubuntu bash config
