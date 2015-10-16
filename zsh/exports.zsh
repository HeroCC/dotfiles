# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
#export LS_COLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

if [[ -a /usr/bin/nvim ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

export PAGER='less'
export LESS='--ignore-case --raw-control-chars'

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
