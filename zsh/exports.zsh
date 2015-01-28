# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'
export EDITOR='vim'
# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C

export GRADLE_HOME='/opt/gradle/'

export PATH="$PATH:$GRADLE_HOME/bin/"
