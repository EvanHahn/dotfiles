export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_DOWNLOAD_DIR="$HOME/desktop"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pictures"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_VIDEOS_DIR="$HOME/videos"

alias ls='ls --color'

base16_shell="$XDG_CONFIG_HOME/base16-shell"
if [ -d "$base16_shell" ]; then
  source "$base16_shell/scripts/base16-default-dark.sh"
fi
