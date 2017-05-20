# Setup terminal, and turn on colors
if [[ $TERM == xterm ]]; then export TERM=xterm-256color; fi
export CLICOLOR=1

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
	export PATH="$GRADLE_HOME/bin:${PATH}"
fi

ipath /usr/local/heroku/bin

if [ -d /opt/android-sdk/ ]; then
	export ANDROID_SDK_ROOT="/opt/android-sdk"
	export ANDROID_SDK_HOME="$HOME/.android/"
	export PATH="$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:${PATH}"
fi
