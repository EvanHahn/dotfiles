alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias l="ls"
alias g="git"
alias q="exit"
alias :q="exit"

alias rn="date '+%l:%M%p on %A, %B %e, %Y'"
alias serveit="python -m SimpleHTTPServer"
alias myip="curl -s icanhazip.com"
alias removeexif="jhead -purejpg"

alias vi="vim"
alias ed="ed -p:"
alias lynx="lynx -cfg ~/Coding/personal/dotfiles/resources/lynx.cfg"
alias tmux="tmux -u2"
alias more="less"
alias mv="mv -i -v"
alias cp="cp -i -v"
alias mkdir="mkdir -p -v"

alias ,,="cd .."
alias ..l="cd .. && ls"
alias cd..="cd .."
alias gits="git s"
alias gs="git s"
alias mdkir="mkdir"
alias gut="git"
alias sudp="sudo"
alias mate.="mate ."

cd() { builtin cd $@ && ls }

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
