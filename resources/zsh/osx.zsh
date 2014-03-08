function trash() {
	local trash_dir="${HOME}/.Trash"
	local temp_ifs=$IFS
	IFS=$'\n'
	for item in "$@"; do
		if [[ -e "$item" ]]; then
			item_name="$(basename $item)"
			if [[ -e "${trash_dir}/${item_name}" ]]; then
				mv -f "$item" "${trash_dir}/${item_name} $(date "+%H-%M-%S")"
			else
				mv -f "$item" "${trash_dir}/"
			fi
		fi
	done
	IFS=$temp_ifs
}

export PATH=$PATH:/opt/local/bin

alias e="mvim"

alias gitx="open -a GitX ."

alias sms="open sms:"

alias pingo="ping -o 74.125.225.36 | grep time"

alias mate=atom
