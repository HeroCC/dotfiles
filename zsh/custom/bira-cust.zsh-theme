#!/usr/bin/env zsh
# HeroCC's Heavily modified version of Bira / Mira ZSH theme
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

username_color='green'
host_color='green'
if [[ -n $SSH_CONNECTION ]]; then
	host_color='red'
fi

if [[ "$USER" == root ]]; then
	username_color='yellow'
fi

local user_host='%{$terminfo[bold]$fg[$username_color]%}%n%{$fg_bold[$host_color]%}@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'

local rvm_ruby=''

if [[ "$show_rvm" != 'false' ]]; then
  if which rvm-prompt &> /dev/null; then
    local rvm_version="$(rvm-prompt i v g)"
    rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%} '
  elif which rbenv &> /dev/null; then
    local rvm_version="$(rbenv version | sed 's/\s.*$//')"
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%} '
  fi
  # If RVM version is system, don't display
  if [[ "$rvm_version" == system ]]; then
    rvm_ruby=''
  fi
fi

local nvm_node=''
if which nvm &> /dev/null; then
  if [[ $(nvm version) != system ]]; then
    nvm_node='%{$fg[green]%}‹node-$(nvm_prompt_info)›%{$reset_color%} '
  fi
fi

local jenv_java=''
if which jenv &> /dev/null; then
  jenv_java_version='$(jenv version-name)'
  if [[ "$(jenv version-name)" != system ]]; then
    jenv_java="%{$fg[blue]%}‹$jenv_java_version›%{$reset_color%} "
  fi
fi

local git_branch='$(git_prompt_info)%{$reset_color%}'

if [[ "multiline_prompt" != true ]]; then
  PROMPT="${user_host}${current_dir} ${rvm_ruby}${nvm_node}${jenv_java}${git_branch}%B$%b "
fi
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
