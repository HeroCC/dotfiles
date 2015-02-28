# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'

# Same as above, but in long listing format
alias ll='ls -GFhl'

alias ri='ri -Tf ansi'

alias mysql='mysql -u root'
alias mysqladmin='mysqladmin -u root'

alias sudo='sudo ' # Makes sudo use aliases, from http://go.herocc.com/sudo_aliases
alias apt-get='apt-fast' # http://go.herocc.com/aptfast
alias gpg='gpg2'
alias please='sudo $(fc -nl -1)'
alias cls='clr'

# I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'

alias rm='trash-put' # Requires trash-cli
alias dd='dcfldd' # DD with a progress report