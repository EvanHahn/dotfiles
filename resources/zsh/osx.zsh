export HOMEBREW_NO_EMOJI=1
export BROWSER=open

sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent' # flush downloads list

alias sleepybear="osascript -e 'tell application \"System Events\" to sleep'"
alias flushdns='sudo killall -HUP mDNSResponder'

alias gitx='open -a GitX .'
