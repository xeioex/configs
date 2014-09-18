import XMonad
import XMonad.Operations

import System.IO
import System.Exit
import Data.Monoid

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)

import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad
import XMonad.Util.Run

import XMonad.Layout.SimpleFloat
import XMonad.Layout.Grid
import XMonad.Layout.IM
import Data.Ratio ((%))

import XMonad.Actions.SpawnOn
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- certain contrib modules.
--
myTerminal      = "gnome-terminal-wrapper"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 2

myModMask       = mod4Mask
myWorkspaces    = ["1.web", "2.chat", "3.dev", "4.aux", "5.media", "6.reading" ] ++ map show [7..9]
-- Dzen/Conky
myXmonadBar = "dzen2 -x '1440' -y '0' -h '24' -w '640' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
myStatusBar = "conky -c ~/.xmonad/conky_dzen | dzen2 -x '2800' -y '1176' -w '1040' -h '24' -ta 'r' -bg '#1B1D1E' -fg '#FFFFFF'"
myBitmapsDir = "~/.xmonad/dzen2"

myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
xpc :: XPConfig
xpc = defaultXPConfig { bgColor  = "black"
                , fgColor  = "grey"
                , promptBorderWidth = 0
                , position = Bottom
                , height   = 15
                , historySize = 256 }

myKeys c = mkKeymap c $                                 -- keys; uses EZConfig
    [ ("M-S-<Return>",  spawn $ XMonad.terminal c)       -- spawn terminal
    , ("M-p"         ,  shellPrompt xpc)                 -- spawn menu program, uses Shell
    , ("M-w"         ,  spawn "x-www-browser")           -- spawn Google Chrome
    , ("M-k"         ,  spawn "skype")                   -- spawn Skype
    , ("M-v"         ,  spawn "vlc")                     -- spawn Vlc
    , ("M-e"         ,  spawn "evince")                  -- spawn Evince
    , ("M-s"         ,  search)                          -- search websites, uses Search & Submap
    , ("M-S-c"       ,  kill)                            -- kill window
    , ("M-<Space>"   ,  sendMessage NextLayout)          -- next layout
    , ("M-S-<Space>" ,  setLayout $ XMonad.layoutHook c) -- default layout
    , ("M-n"         ,  refresh)                         -- resize to correct size
    , ("M-<Down>"    ,  windows W.focusDown)             -- move focus; next window
    , ("M-<Up>"      ,  windows W.focusUp)               -- move focus; prev. window
    , ("M-m"         ,  windows W.focusMaster)           -- focus on master
    , ("M-<Return>"  ,  windows W.swapMaster)            -- swap current with master
    , ("M-S-<Down>"  ,  windows W.swapDown)              -- swap focused with next window
    , ("M-S-<Up>"    ,  windows W.swapUp)                -- swap focused with prev. window
    , ("M-<Left>"    ,  sendMessage Shrink)              -- shrink master area
    , ("M-<Right>"   ,  sendMessage Expand)              -- expand master area
    , ("M-t"         ,  withFocused $ windows . W.sink)  -- put window back on tiling layer
    , ("M-,"         ,  sendMessage (IncMasterN 1))      -- increase number of windows in master pane
    , ("M-."         ,  sendMessage (IncMasterN (-1)))   -- decrease number of windows in master pane
    , ("M-b"         ,  sendMessage ToggleStruts)        -- toggle status bar gap, uses ManageDocks
    , ("M-C-q"       ,  broadcastMessage ReleaseResources
                        >> restart "xmonad" True)        -- restart xmonad
    , ("C-S-q"       ,  io (exitWith ExitSuccess))       -- exit xmonad
    ] ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [(m ++ k, windows $ f w)
        | (w, k) <- zip (XMonad.workspaces c) (map show [1..9])
        , (m, f) <- [("M-",W.greedyView), ("M-S-",W.shift)]]

 where searchSite = S.promptSearchBrowser xpc "ff3"
       search     = SM.submap . mkKeymap c $
                     [("g", searchSite S.google)
                     ,("a", searchSite S.amazon)
                     ,("y", searchSite S.youtube)
                     ,("w", searchSite S.wikipedia)]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

------------------------------------------------------------------------
-- Layouts:
myIMLayout = withIM (1%8) skype Grid
  where
     skype = And (ClassName "Skype") (Role "")

myLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full ||| simpleFloat
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:
myManageHook :: ManageHook
myManageHook = manageSpawn <+> scratchpadManageHookDefault <+> manageDocks
               <+> fullscreenManageHook <+> myFloatHook
               <+> manageHook defaultConfig
  where fullscreenManageHook = composeOne [ isFullscreen -?> doFullFloat ]
 
myFloatHook = composeAll
    [ className =? "GIMP"                  --> moveToMedia
    , className =? "Google-chrome-stable"  --> moveToWeb
    , className =? "Evince"                --> moveToReading
    , className =? "Gnome-terminal"        --> moveToDev
    , className =? "MPlayer"               --> moveToMedia
    , className =? "Vlc"                   --> doFloat
    , className =? "Skype"                 --> moveToChat
    , classNotRole ("Skype", "MainWindow") --> doFloat
    , manageDocks]
  where
    moveToWeb   = doF $ W.shift "1.web"
    moveToChat   = doF $ W.shift "2.chat"
    moveToDev   = doF $ W.shift "3.dev"
    moveToMedia = doF $ W.shift "5.media"
    moveToReading = doF $ W.shift "6.reading"
 
    classNotRole :: (String, String) -> Query Bool
    classNotRole (c,r) = className =? c <&&> role /=? r
 
    role = stringProperty "WM_WINDOW_ROLE"
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
      , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
      , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  |  "
      , ppLayout            =   dzenColor "#ebac54" "#1B1D1E" .
                                (\x -> case x of
                                    "ResizableTall"             ->      "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Mirror ResizableTall"      ->      "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Full"                      ->      "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    "Simple Float"              ->      "~"
                                    _                           ->      x
                                )
      , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
      , ppOutput            =   hPutStrLn h
    }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
        spawnOn "1.web" "x-www-browser"
        spawnOn "2.chat" "skype"
        spawnOn "3.dev" myTerminal
        spawnOn "4.aux" myTerminal

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
main = do 
          dzenLeftBar <- spawnPipe myXmonadBar
          dzenRightBar <- spawnPipe myStatusBar
          xmonad $ withUrgencyHookC dzenUrgencyHook { args = ["-bg", "red", "fg", "black", "-xs", "1", "-y", "25"] } urgencyConfig { remindWhen = Every 15 } $ defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook dzenLeftBar >> fadeInactiveLogHook 0xdddddddd,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
