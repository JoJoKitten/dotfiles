--                                       _ 
-- __  ___ __ ___   ___  _ __   __ _  __| |
-- \ \/ / '_ ` _ \ / _ \| '_ \ / _` |/ _` |
--  >  <| | | | | | (_) | | | | (_| | (_| |
-- /_/\_\_| |_| |_|\___/|_| |_|\__,_|\__,_|
                                        
import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = avoidStruts $ myLayout,
        manageHook         = manageDocks <+> myManageHook,
        handleEventHook    = docksEventHook,
        startupHook        = docksStartupHook <+> myStartupHook,
        logHook            = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor xmobarTitleColor "" . shorten 100,
            ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "",
            ppSep = "   "
        }
    }


myTerminal = "termite"
myWorkspaces = map show [1..9]

------------------------------------------------------------------------
-- Window rules
myManageHook = composeAll
    [ resource  =? "desktop_window" --> doIgnore,
    className =? "stalonetray"    --> doIgnore,
    isFullscreen --> (doF W.focusDown <+> doFullFloat)]


------------------------------------------------------------------------
-- Layouts
myLayout = avoidStruts (
    spacing 10 $ Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    Full |||
    spiral (6/7)) |||
    noBorders (fullscreenFull Full)


------------------------------------------------------------------------
-- Colors and borders
myNormalBorderColor  = "#555555"
myFocusedBorderColor = "#ffffff"
myBorderWidth = 2

xmobarTitleColor = "#a0f0a0"
xmobarCurrentWorkspaceColor = "#a0f0a0"

------------------------------------------------------------------------
-- Key bindings
myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

  [
  -- launch terminal
  ((modMask, xK_Return), spawn $ XMonad.terminal conf),

  -- Close focused window.
  ((modMask .|. shiftMask, xK_q), kill),

  -- Change layout
  ((modMask, xK_a), sendMessage NextLayout),

  --  Reset the layouts on the current workspace to default
  ((modMask .|. shiftMask, xK_a), setLayout $ XMonad.layoutHook conf),

  -- Resize viewed windows to the correct size.
  ((modMask, xK_n), refresh),

  -- Move focus to the next window.
  ((modMask, xK_j), windows W.focusDown),

  -- Move focus to the previous window.
  ((modMask, xK_k), windows W.focusUp  ),

  -- Move focus to the master window.
  ((modMask, xK_m), windows W.focusMaster  ),

  -- Swap the focused window and the master window.
  ((modMask, xK_e), windows W.swapMaster),

  -- Swap the focused window with the next window.
  ((modMask .|. shiftMask, xK_j), windows W.swapDown  ),

  -- Swap the focused window with the previous window.
  ((modMask .|. shiftMask, xK_k), windows W.swapUp    ),

  -- Shrink the master area.
  ((modMask, xK_h), sendMessage Shrink),

  -- Expand the master area.
  ((modMask, xK_l), sendMessage Expand),

  -- Push window back into tiling.
  ((modMask, xK_t), withFocused $ windows . W.sink),

  -- Increment the number of windows in the master area.
  ((modMask, xK_comma), sendMessage (IncMasterN 1)),

  -- Decrement the number of windows in the master area.
  ((modMask, xK_period), sendMessage (IncMasterN (-1))),

  -- Quit xmonad.
  ((modMask .|. shiftMask, xK_x), io (exitWith ExitSuccess)),

  -- Restart xmonad.
  ((modMask .|. shiftMask, xK_r), restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]


------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--


------------------------------------------------------------------------
-- Startup hook
myStartupHook = do
    spawn "~/.start_jobs.sh"
