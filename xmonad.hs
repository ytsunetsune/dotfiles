import XMonad
import XMonad.Config.Gnome
import XMonad.Layout
import XMonad.Layout.Named
import XMonad.Layout.Tabbed
import XMonad.Layout.DragPane
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts


main = do
  xmonad $ gnomeConfig
  xmonad $ defaultConfig
    {
      modMask = myModMask
    , borderWidth = myBorderWidth
    , layoutHook = toggleLayouts (noBorders Full) $ myLayout
    }


myModMask = mod3Mask
myBorderWidth = 2

myLayout = (spacing 2 $ ResizableTall 1 (3/100) (3/5) [])
            ||| (spacing 2 $ (dragPane Horizontal (1/10) (1/2)))
            ||| (spacing 2 $ (dragPane Vertical (1/10) (1/2)))
