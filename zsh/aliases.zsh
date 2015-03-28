# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'

# Same as above, but in long listing format
alias ll='ls -GFhl'

alias ri='ri -Tf ansi'

alias mysql='mysql -u root'
alias mysqladmin='mysqladmin -u root'

alias sudo='sudo ' # Makes sudo use aliases, from http://go.herocc.com/sudo_aliases
ialias apt-get='apt-fast' # http://go.herocc.com/aptfast
ialias gpg='gpg2'
alias please='sudo $(fc -nl -1)'
alias cls='clr'

# I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'

ialias rm='trash-put' # Requires trash-cli
ialias dd='dcfldd' # DD with a progress report

# Apt stuff
ialias agi='sudo apt-get install'
ialias agp='sudo apt-get purge'
ialias agr='sudo apt-get remove'
ialias agu='sudo apt-get update'
ialias agug='sudo apt-get upgrade'
ialias aguu='sudo apt-get update && sudo apt-get upgrade'

alias xtitle='set_terminal_title'
