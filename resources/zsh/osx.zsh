export HOMEBREW_NO_EMOJI=1
export BROWSER=open

alias sleepybear="osascript -e 'tell application \"System Events\" to sleep'"

alias e='open -a MacVim'
alias gitx='open -a GitX .'

alias flushdns='sudo killall -HUP mDNSResponder'

sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent' # flush downloads list
