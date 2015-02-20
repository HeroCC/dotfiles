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
	[ "$motd_mode" = updates ]; then
	local updates=$(/usr/lib/update-notifier/apt-check 2>&1)
	local sec_updates=$(echo "$updates" | cut -d ";" -f 2)
	local non_sec_updates=$(echo "$updates" | cut -d ";" -f 1)

	echo "There are $sec_updates security updates and $non_sec_updates regular updates"
elif
	[ "$motd_mode" = none ]; then
	clear
elif 
	[ "$motd_mode" ]; then
	echo "Unknown motd_mode '$motd_mode', please check your .zshrc or motd file"
fi