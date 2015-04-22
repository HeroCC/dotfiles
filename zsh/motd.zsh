HIDDEN_SSH_MOTD='false'
if [[ -n $SSH_CONNECTION ]] && [[ $HIDDEN_SSH_MOTD = 'true' ]]; then
	motd_mode=none
fi

if [ "$motd_mode" = norris ]; then
	norris 2
elif [ "$motd_mode" = screenfetch ]; then
	screenfetch
elif [ "$motd_mode" = fortune ]; then
	fortune | cowsay -f $cow
elif [ "$motd_mode" = fortune_nocow ]; then
	fortune
elif [ "$motd_mode" = updates ]; then
	updates=$(cat $HOME/.updates | sed -n 1p) # See script @ http://go.herocc.com/refresh-available-updates
  update_mode=$(cat $HOME/.updates | sed -n 2p)

  if [ "$update_mode" = sec ]; then
    local sec_updates=$(echo "$updates" | cut -d ";" -f 2)
    local non_sec_updates=$(echo "$updates" | cut -d ";" -f 1)
    local reboot_required="$(/usr/lib/update-notifier/update-motd-reboot-required)"
    message="There are $sec_updates security updates and $non_sec_updates regular updates"

    if [[ "$reboot_required" != "" ]]; then
      message="$message, possibly requiring a reboot"
    fi

  elif [ "$update_mode" = total ]; then
    local non_sec_updates=$(echo "$updates")
    message="There are $non_sec_updates avaliable updates"
  fi

  echo "$message"
elif
	[ "$motd_mode" = none ]; then
  #nada
elif
	[ "$motd_mode" ]; then
	echo "Unknown motd_mode '$motd_mode', please check your .zshrc or motd file"
fi
