import XMonad
import System.Exit

main = xmonad defaults

defaults = defaultConfig {
	terminal = "xterm",
	borderWidth = 10,
	normalBorderColor = "#000000",
	focusedBorderColor = "#ffffff"
}
