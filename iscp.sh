#!/usr/bin/env bash
set -e

echo -en '\033[35m'
echo "~~** hey it's me, interactive scp **~~"
echo -e '\033[0m'

direction='not yet specified'
while [ "$direction" != 'from' ] && [ "$direction" != 'to' ]; do
  echo -n 'Are you copying FROM or TO a remote server? '
  read temp
  direction="$(echo $temp | awk '{print tolower($0)}')"
done

host=''
while [ "$host" == '' ]; do
  echo -n "What's the ADDRESS of the remote server? "
  read host
done

username=''
while [ "$username" == '' ]; do
  echo -n "What's your USERNAME on that remote server? "
  read username
done

remote_path=''
while [ "$remote_path" == '' ]; do
  if [ "$direction" == 'from' ]; then
    echo -n 'Where are you copying FROM on the remote server?'
  else
    echo -n 'Where are you copying TO on the remote server?'
  fi
  echo -n ' (Type "ssh" to ssh in and check.) '
  read temp
  first_character="$(echo $temp | head -c 1)"
  if [ "$temp" == 'ssh' ]; then
    ssh "$username@$host"
    echo
    echo 'Welcome back to iscp.'
  else
    remote_path="$temp"
  fi
done

local_path='not yet specified'
if [ "$direction" == 'from' ]; then
  echo -n 'What is the LOCAL DESTINATION of the file? (Default is .) '
  read local_path
  if [ "$local_path" == '' ]; then
    local_path='.'
  fi
else
  if [ -e "$1" ]; then
    local_path="$1"
  else
    while [ ! -e "$local_path" ]; do
      echo -n 'What is the LOCAL PATH of this file? '
      read local_path
    done
  fi
fi

folder_flag=''
if [ "$direction" == 'from' ]; then
  last_character_of_remote_path="$(echo -n $remote_path | tail -c 1)"
  if [ "$last_character_of_remote_path" == '.' ] || [ "$last_character_of_remote_path" == '/' ]; then
    is_folder='yes'
  else
    is_folder='not yet specified'
  fi
  while [ "$is_folder" != 'yes' ] && [ "$is_folder" != 'no' ]; do
    echo -n 'Is the remote path a FOLDER? '
    read is_folder
  done
  if [ "$is_folder" == 'yes' ]; then
    folder_flag=' -r'
  fi
else
  if [ -d "$local_path" ]; then
    folder_flag=' -r'
  fi
fi

scp_command_header="scp$folder_flag"
remote_slug="$username@$host:$remote_path"
if [ "$direction" == 'from' ]; then
  scp_command="$scp_command_header $remote_slug $local_path"
else
  scp_command="$scp_command_header $local_path $remote_slug"
fi

echo
echo "Alright, I'm gonna run this command unless you say I shouldn't:"

echo
echo -e "\033[35m$scp_command\033[0m"

echo
echo -n 'Press return to continue. Anything else will abort. '
read temp
if [ "$temp" == '' ]; then
  echo
  eval "$scp_command"
  echo
  echo -en '\033[35m'
  echo "~~** iscp will miss u **~~"
  echo -e '\033[0m'
else
  echo 'Aborting! Come again.'
fi
