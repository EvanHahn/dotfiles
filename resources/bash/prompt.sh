if [[ "$USER" == "evanmhahn" ]]; then
	export PS1="\n\[$(tput setaf 3)\] \W \[$(tput sgr0)\]"
elif [[ "$USER" == "pi" ]]; then
	export PS1="\n\[$(tput setaf 5)\] \W \[$(tput sgr0)\]"
elif [[ ~ == "/afs/umich.edu/user/e/v/evanhahn" ]]; then
	export PS1="\n\[$(tput setaf 6)\] \W \[$(tput sgr0)\]"
else
	export PS1="\n\[$(tput setaf 1)\] \W \[$(tput sgr0)\]"
fi
