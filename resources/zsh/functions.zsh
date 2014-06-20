extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2) tar xvjf $1 ;;
			*.tar.gz) tar xvzf $1 ;;
			*.tar.xz) tar xvJf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) unrar x $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xvf $1 ;;
			*.tbz2) tar xvjf $1 ;;
			*.tgz) tar xvzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*.xz) unxz $1 ;;
			*.exe) cabextract $1 ;;
			*) echo "\`$1': the hell are you tryna unzip" ;;
		esac
	else
		echo "\`$1' is madness"
	fi
}

list_colors () {
	for i in {000..255}; do
		echo -ne "[38;5;${i}m$i "
	done
}

copy () {
  if [[ -x `which pbcopy` ]]; then
    pbcopy
  else
    rm -f /tmp/clipboard 2> /dev/null
    cat $1 > /tmp/clipboard
  fi
}

pasta () {
  if [[ -x `which pbpaste` ]]; then
    pbpaste
  else
    cat /tmp/clipboard
  fi
}
