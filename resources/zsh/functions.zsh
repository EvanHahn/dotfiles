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
    echo "\`$1' doesn't exist"
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
  elif [[ -x `which xclip` ]]; then
    xclip -selection clipboard
  else
    rm -f /tmp/clipboard 2> /dev/null
    cat $1 > /tmp/clipboard
  fi
}

pasta () {
  if [[ -x `which pbpaste` ]]; then
    pbpaste
  elif [[ -x `which xclip` ]]; then
    xclip -selection clipboard -o
  else
    cat /tmp/clipboard
  fi
}

snippet () {
  local folder=$HOME/.snippets
  if [[ -d $folder ]]; then
    if [[ $# == 0 ]]; then
      echo "available snippets in $folder:"
      ls -1 $folder
    else
      if [[ -e $folder/$1 ]]; then
        cat $folder/$1
      elif [[ -e $folder/$1.url ]]; then
        curl -sSL $(cat $folder/$1.url)
      else
        echo "cannot find snippet $1" 1>&2
      fi
    fi
  else
    echo "cannot find snippets. try creating $folder" 1>&2
  fi
}

random () {
  if [ $# -eq 0 ]; then
    local random_type="string"
  else
    local random_type="$1"
  fi
  if [[ "$random_type" == "number" ]]; then
    echo $RANDOM
  elif [[ "$random_type" == "bool" ]]; then
    if [ $(($RANDOM % 2)) -eq 0 ]; then
      echo "no"
    else
      echo "yes"
    fi
  elif [[ "$random_type" == "string" ]]; then
    python -c "
import random, string
chars = string.letters + string.digits + string.punctuation
print(''.join(random.choice(chars) for i in xrange(40)))
      "
  elif [[ "$random_type" == "letters" ]]; then
    python -c "
import random, string
print(''.join(random.choice(string.ascii_lowercase) for i in xrange(40)))
      "
  else
    echo "cannot generate random $random_type" 1>&2
  fi
}

length () {
  echo -n "$@" | wc -c | awk '{print $1}'
}

myip () {
  local local_ip=$(ipconfig getifaddr en0)
  if [ "$local_ip" == "" ]; then
    echo "offline :("
  else
    echo "local: $local_ip"
    echo -n "world: "
    curl -sS icanhazip.com
  fi
}

stopwatch () {
  date "+%l:%M:%S%p: stopwatch started (^D to stop)"
  time cat
  date "+%l:%M:%S%p: stopwatch stopped"
}

rn () {
  date "+%l:%M%p on %A, %B %e, %Y"
  echo
  cal | egrep "\b`date \"+%e\"`\b| "
}

svnignore () {
  if [ $# -eq 0 ]; then
    echo "what should i ignore?" 1>&2
  else
    svn propset svn:ignore "$1" .
  fi
}

journ () {

  local config_file="$HOME/.journconfig"

  if [[ ! -e "$config_file" ]]; then
    echo -n 'where should i store your journal files? '
    read journal_path
    echo "path=$journal_path" > "$config_file"
    unset journal_path
  fi

  local journal_path="$(cat ~/.journconfig |
                        egrep '^path=' |
                        head -n 1 |
                        tail -c+6)"

  local today="$(date '+%Y-%m-%d')"
  local today_file="$journal_path/$today.txt"

  local last_modified=0
  if [[ -e "$today_file" ]]; then
    last_modified=$(stat -f %m "$today_file")
    echo >> "$today_file"
  else
    touch "$today_file"
  fi

  local formatted_time="$(date '+%l:%M%p' | awk '{print tolower($0)}')"

  local ten_minutes=600
  local now=$(date '+%s')
  local difference=$(($now - $last_modified))
  if [ "$difference" -ge "$ten_minutes" ]; then
    echo "$formatted_time" >> "$today_file"
    echo >> "$today_file"
  fi

  echo >> "$today_file"

  if [ $# -eq 0 ]; then
    vim -c 'execute "normal G"' "$today_file"
  else
    echo "$@" >> "$today_file"
  fi

}
