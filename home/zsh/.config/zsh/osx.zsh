export BROWSER=open
unset DISPLAY

sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent' # flush downloads list

alias gvim=mvim
