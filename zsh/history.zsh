# HISTORY
HISTSIZE=9999999999
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="exit"

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt append_history         # new history lines are added as soon as they are entered (rather than waiting until the shell exits)
setopt inc_append_history     # update history in all windows on command execution
