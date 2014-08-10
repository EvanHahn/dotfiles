alias ..="cd .."
alias 2..="cd ../.."
alias 3..="cd ../../.."
alias 4..="cd ../../../.."
alias 5..="cd ../../../../.."

alias l="ls"
alias g="git"
alias q="exit"

alias bell="tput bel"
alias rn='date "+%l:%M%p on %A, %B %e, %Y" && echo && (cal | egrep "\b`date \"+%e\"`\b| ")'
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
alias lynx="lynx -cfg $HOME/.lynx.cfg"
alias screen="screen -U"
alias tmux="tmux -u2"
alias mv="nocorrect mv -i -v"
alias cp="nocorrect cp -i -v"
alias mkdir="nocorrect mkdir -p -v"
alias ln="nocorrect ln -v"

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
alias youtubedl="youtube-dl"
