if [[ -n $SSH_CONNECTION ]]; then

else
	if [ "$MOTD_MODE" = norris ]; then
		norris 2
	elif
		[ "$MOTD_MODE" = screenfetch ]; then
		screenfetch
	fi
fi