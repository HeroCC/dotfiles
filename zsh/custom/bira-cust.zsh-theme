# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ -n $SSH_CONNECTION ]]; then
	local username_color='red'
elif [[ $EUID -ne 0 ]]; then
	local username_color='green'
else
	local username_color='yellow'
fi

local user_host='%{$terminfo[bold]$fg[$username_color]%}%n%{$fg_bold[green]%}@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'

show_rvm='true'
local rvm_ruby=''
local rvm_version="$(rbenv version | sed 's/\s.*$//')"
if which rvm-prompt &> /dev/null; then
	rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%} '
else
	if which rbenv &> /dev/null; then
		rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%} '
	fi
fi

if [[ "$show_rvm" == true ]]; then
	if [[ "$rvm_version" == system ]]; then
		rvm_ruby=''
	fi
fi

local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="${user_host}${current_dir} ${rvm_ruby}${git_branch}%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
