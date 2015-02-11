if [[ -n $SSH_CONNECTION ]]; then
	motd_mode=none
fi

if [ "$motd_mode" = norris ]; then
	norris 2
elif
	[ "$motd_mode" = screenfetch ]; then
	screenfetch
elif
	[ "$motd_mode" = fortune ]; then
	fortune | cowsay -f $cow
elif
	[ "$motd_mode" = fortune_nocow ]; then
	fortune
elif
	[ "$motd_mode" = none ]; then
		#Nothing
elif 
	[ "$motd_mode" ]; then
	echo "Unknown motd_mode '$motd_mode', please check your .zshrc or motd file"
fi