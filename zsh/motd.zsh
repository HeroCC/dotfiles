if [ -n $SSH_CONNECTION ] && [ $HIDDEN_SSH_MOTD != 'true' ]; then # If SSH, don't do MOTD
  motd_mode="none"
fi

if [[ "$motd_mode" == *"norris"* ]]; then
  motd="$(norris 2)" # Chuck norris MOTD
elif [[ "$motd_mode" == *"screenfetch"* ]]; then
  motd="$(screenfetch)" # Shows basic information about system
elif [[ "$motd_mode" == *"fortune"* ]]; then
  motd="$(fortune)" # Fortune
elif [[ "$motd_mode" == *"updates"* ]]; then
  updates=$(cat $HOME/.updates | sed -n 1p) # See script in bin folder of dotfiles
  update_mode=$(cat $HOME/.updates | sed -n 2p)

  if [ "$update_mode" = sec ]; then
    local sec_updates=$(echo "$updates" | cut -d ";" -f 2)
    local non_sec_updates=$(echo "$updates" | cut -d ";" -f 1)
    local reboot_required="$(/usr/lib/update-notifier/update-motd-reboot-required)"
    message="There are $sec_updates security updates and $non_sec_updates regular updates"

    if [ -n "$reboot_required" ]; then
      message="$message, possibly requiring a reboot"
    fi

  elif [ "$update_mode" = total ]; then
    local non_sec_updates=$(echo "$updates")
    message="There are $non_sec_updates avaliable updates"
  fi

  motd="$message"
elif [[ "$motd_mode" == *"none"* ]]; then
  motd=""
elif [[ "$motd_mode" ]]; then
  motd="Unknown motd_mode '$motd_mode', please check your .zshrc or motd file"
fi

###########################
# Begin CowSay Checking ###
###########################

if [ "$motd_mode" = none ]; then
  # Do Nothing, print nothing
elif [[ "$motd_mode" == *"cowsay"* ]]; then
  # Cowsay detected in $motd_mode
  if which cowsay &> /dev/null; then
    # Print message in cowsay mode
    echo "$motd" | cowsay -f `ls /usr/share/cowsay/cows/ | shuf -n 1`
  else
    # No cowsay installed, printing normal message
    echo "$motd"
  fi
elif [[ "$motd_mode" == *"cowthink"* ]]; then
  # Cowthink detected
  if which cowthink &> /dev/null; then
    # Print message in cowsay mode
    echo "$motd" | cowthink -f `ls /usr/share/cowsay/cows/ | shuf -n 1`
  else
    # No cowsay installed, printing normal message
    echo "$motd"
  fi
else
  echo "$motd"
fi
