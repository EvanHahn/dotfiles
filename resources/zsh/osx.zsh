export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1
export BROWSER=open
unset DISPLAY

sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent' # flush downloads list

alias flushdns='sudo killall -HUP mDNSResponder'

alias shred='srm'

alias gitx='open -a GitX .'
alias firefox='open -a Firefox'
