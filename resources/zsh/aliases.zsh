alias ..="cd .."
alias 2..="cd ../.."
alias 3..="cd ../../.."
alias 4..="cd ../../../.."
alias 5..="cd ../../../../.."

alias l="ls"
alias g="git"
alias q="exit"

alias bell="tput bel"
alias rn="date '+%l:%M%p on %A, %B %e, %Y'"
alias serveit="python -m SimpleHTTPServer"
alias myip='echo -n "local: " && ipconfig getifaddr en0 && echo -n "world: " && curl -s icanhazip.com'
alias removeexif="jhead -purejpg"
alias running="ps aux | grep -v grep | grep"
alias btc='curl -sSL https://coinbase.com/api/v1/prices/historical | head -n 1 | sed "s|^.*,|$|" | sed "s|\(\.[0-9]$\)|\10|"'
alias stopwatch='date "+%l:%M:%S%p: stopwatch started (^D to stop)" && time cat && date "+%l:%M:%S%p: stopwatch stopped"'

alias more=$PAGER
alias less=$PAGER
alias vi="vim"
alias ed="ed -p:"
alias lynx="lynx -cfg ~/Coding/personal/dotfiles/resources/lynx.cfg"
alias screen="screen -U"
alias tmux="tmux -u2"
alias mv="mv -i -v"
alias cp="cp -i -v"
alias mkdir="mkdir -p -v"
alias ln="ln -v"

alias ,,="cd .."
alias ..l="cd .. && ls"
alias cd..="cd .."
alias gits="git s"
alias gs="git s"
alias mdkir="mkdir"
alias gut="git"
alias sudp="sudo"
alias mate.="mate ."
alias :q="exit"

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
