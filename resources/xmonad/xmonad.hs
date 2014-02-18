import XMonad
import System.Exit

main = xmonad defaults

defaults = defaultConfig {
	terminal = "xterm"
}
