function fish_prompt

  set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
  set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')

  echo
  printf "%s%s%s %s@%s " (set_color $fish_color_cwd) $pwd (set_color normal) $USER (hostname -s)
  echo
  echo

end
