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
  folder=$HOME/.snippets
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
