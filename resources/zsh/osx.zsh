function trash () {
	# http://hints.macworld.com/article.php?story=20080224175659423
	local path
	for path in "$@"; do
		# ignore any arguments
		if [[ "$path" = -* ]]; then :
		else
			local dst=${path##*/}
			# append the time if necessary
			while [ -e ~/.Trash/"$dst" ]; do
				dst="$dst "$(date +%H-%M-%S)
			done
			mv "$path" ~/.Trash/"$dst"
		fi
	done
}

export PATH=$PATH:/opt/local/bin

alias e="mvim"

alias gitx="open -a GitX ."

alias sms="open sms:"

alias pingo="ping -o 74.125.225.36 | grep time"

alias mate='open -a "Sublime Text 2"'
