#!/usr/bin/env zsh
# HeroCC's Heavily modified version of Bira / Mira ZSH theme
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

username_color='green'
host_color='green'
if [[ -n "$SSH_CONNECTION" ]]; then
	host_color='red' # If using SSH, color host red
fi

if [[ "$USER" == root ]]; then
	username_color='yellow' # If user is root, color name yellow
fi

local user_host='%{$terminfo[bold]$fg[$username_color]%}%n%{$fg_bold[$host_color]%}@%m%{$reset_color%}' # Username and Host
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}' # Current Directory

local rvm_ruby=''
if [[ "$show_rvm" != 'false' ]]; then # Only if $show_rmv is not false show it
  if which rvm-prompt &> /dev/null; then # If RVM exists
    local rvm_version="$(rvm-prompt i v g)" # Get version
    rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%} '
  elif which rbenv &> /dev/null; then # If RBENV exists
    local rvm_version="$(rbenv version | sed 's/\s.*$//')" # Get version
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%} '
  fi
  # If RVM version is system, don't display
  if [[ "$show_if_system" != 'true' ]]; then
    if [[ "$rvm_version" == system ]]; then
      rvm_ruby=''
    fi
  fi
fi

local nvm_node=''
if [[ "$show_nvm" != 'false' ]]; then # If $show_nvm is enabled
  if which nvm &> /dev/null; then # and nvm exists
    if [[ "$show_if_system" != 'true' ]]; then
      nvm_node='%{$fg[green]%}‹node-$(nvm_prompt_info)›%{$reset_color%} ' # Show regardless of version
    elif [[ $(nvm version) != 'system' ]]; then
      nvm_node='%{$fg[green]%}‹node-$(nvm_prompt_info)›%{$reset_color%} ' # Show only if version isn't system
    fi
  fi
fi

local jenv_java=''
if [[ "$show_java" != 'false' ]]; then # If $show_java is enabled
  if which jenv &> /dev/null; then # and Jenv is installed
    jenv_java_version="$(jenv version-name)" # get version
    jenv_java="%{$fg[blue]%}‹$jenv_java_version›%{$reset_color%} " # and set it
    if [[ "$show_if_system" != true ]]; then
      if [[ "$jenv_java_version" == system ]]; then
        jenv_java=""
      fi
    fi
  fi
fi

local screen_or_tmux_session=''
if which screen &> /dev/null; then
	if [[ -n "$STY" ]]; then # Screen sets this variable if inside screen session
    screen_or_tmux_session="%{$fg[magenta]%}‹$STY›%{$reset_color%} "
  fi
fi
if [[ -z "$screen_or_tmux_session" ]]; then
  if which tmux &> /dev/null; then
    if [[ -n "${TMUX+set}" ]]; then
      tmux_session_name="$(tmux display-message -p '#S')" # Get proper name
      screen_or_tmux_session="%{$fg[magenta]%}‹$tmux_session_name›%{$reset_color%} "
    fi
  fi
fi

local git_branch='$(git_prompt_info)%{$reset_color%}' # Git info

if [[ "$multiline_prompt" != "true" ]]; then
  PROMPT="${user_host}${current_dir} ${screen_or_tmux_session}${rvm_ruby}${nvm_node}${jenv_java}${git_branch}%B$%b " # Single line prompt
else
  PROMPT="╭─${user_host}${current_dir} ${screen_or_tmux_session}${rvm_ruby}${nvm_node}${jenv_java}${git_branch}"$'\n'"╰─%B$%b " #Multiline prompt
fi
RPS1="${return_code}" # Return code

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
