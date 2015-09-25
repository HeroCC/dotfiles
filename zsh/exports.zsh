# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
#export LS_COLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='--ignore-case --raw-control-chars'

if [ -x nvim ]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
# CTAGS Sorting in VIM/Emacs is better behaved with this in place
export LC_COLLATE=C

export PAGER='less'

# Path Stuff
if [ -d /opt/gradle/ ]; then
	export GRADLE_HOME='/opt/gradle'
	export PATH="$PATH:$GRADLE_HOME/bin"
fi

ipath /usr/local/heroku/bin

if [ -d /opt/android-sdk/ ]; then
	export ANDROID_SDK_ROOT="/opt/android-sdk"
	export ANDROID_SDK_HOME="$HOME/.android/"
	export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools"
fi

export PATH=$(echo $PATH | sed ':b;s/:\([^:]*\)\(:.*\):\1/:\1\2/;tb;s/^\([^:]*\)\(:.*\):\1/:\1\2/') # Remove path Duplicates, from http://q.gs/8pXB7
