On macOS:

    stow -t "$HOME/Library/Application Support/Code/User" .
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

On Linux:

    stow -t "$XDG_CONFIG_HOME/Code/User" .
