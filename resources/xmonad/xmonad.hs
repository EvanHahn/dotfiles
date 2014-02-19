import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import System.Exit

main = xmonad defaults

myLayoutHook = tiled ||| Mirror tiled
	where
		tiled = spacing 1 $ ResizableTall nmaster delta ratio []
		nmaster = 1
		ratio = 1/2
		delta = 1/100

defaults = defaultConfig {

	terminal = "xterm",

	borderWidth = 1,
	normalBorderColor = "#666666",
	focusedBorderColor = "#cbcbcb",

	layoutHook = myLayoutHook,

	focusFollowsMouse = False

}
