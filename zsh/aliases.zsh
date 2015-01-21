# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'

# Same as above, but in long listing format
alias ll='ls -GFhl'

alias ri='ri -Tf ansi'

alias mysql='mysql -u root'
alias mysqladmin='mysqladmin -u root'

alias sudo='sudo ' #Makes sudo use aliases
alias apt-get='apt-fast'
alias gpg='gpg2'
alias please='sudo $(fc -nl -1)'

#I like verbose in chmod & chown
alias chmod='chmod -v'
alias chown='chown -v'