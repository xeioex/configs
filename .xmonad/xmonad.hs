-- 'xmonad --recompile' to rebuild
import XMonad
import XMonad.Operations

import System.IO
import System.Exit
import Data.Monoid

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.EZConfig
import XMonad.Util.Run

import XMonad.Layout.Gaps
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleFloat

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

myTerminal      = "gnome-terminal-wrapper"
myLocker        = "sflock -xshift -$(calc -p `xrandr --current | /bin/grep -P '(?<=primary )[0-9]+(?=x[0-9]+)' -o`/2)"
myXAutoLock     = "xautolock -time 5 -locker \"" ++  myLocker ++ "\""

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
xpc :: XPConfig
xpc = defaultXPConfig { bgColor = "black", fgColor = "grey", promptBorderWidth = 0,
                        position = Bottom, height = 24, historySize = 256 }

myKeys c = mkKeymap c $                                 -- keys; uses EZConfig
    [ ("M-S-<Return>",  spawn $ XMonad.terminal c)       -- spawn terminal
    , ("M-p"         ,  shellPrompt xpc)                 -- spawn menu program, uses Shell
    , ("M-w"         ,  spawn "x-www-browser")           -- spawn Google Chrome
    , ("M-k"         ,  spawn "skype.sh")                -- spawn Skype
    , ("M-c"         ,  spawn "unity-control-center")    -- spawn unity-control-center
    , ("M-v"         ,  spawn "vlc")                     -- spawn Vlc
    , ("M-e"         ,  spawn "evince")                  -- spawn Evince
    , ("M-d"         ,  spawn "deadbeef")                -- spawn Deadbeef
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

    , ("C-S-<Up>"    , spawn "pulseaudio-ctl plus")        -- volume up
    , ("C-S-<Down>"  , spawn "pulseaudio-ctl minus")       -- volume down
    , ("C-S-m"       , spawn "pulseaudio-ctl mutetoggle")  -- volume mute toggle
    , ("C-S-<Print>" , spawn "shutter.sh")  -- screenshot -> dropbox
    , ("C-S-l"       , spawn myLocker)
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
myLayoutHook = gaps [(D, 32)] $
               onWorkspace "1.web" webLayout $
               onWorkspace "2.chat" chatLayout $
               onWorkspace "3.dev" devLayout $
               onWorkspace "4.aux" auxLayout $
               defaultLayout
  where
     tiled   = Tall 1 (2/100) (1/2)
     rtall   = ResizableTall 1 (2/100) (1/2) []
     webLayout = gaps [(L, 200), (R, 200)] $ avoidStruts $ rtall
     chatLayout = avoidStruts $ rtall ||| Mirror rtall
     devLayout = gaps [(R, 480)] $ avoidStruts $ rtall
     auxLayout = gaps [(L, 400)] $ avoidStruts $ rtall
     defaultLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full ||| simpleFloat

------------------------------------------------------------------------
-- Window rules:
myManageHook :: ManageHook
myManageHook = manageSpawn <+> myHook <+> manageHook defaultConfig
               <+> manageDocks

myHook = (composeAll . concat $
    -- use xprop | grep WM_CLASS
    -- to get a class name
    [
     [className =? c --> doFloat              | c <- myFloats],
     [isDialog       --> doFloat],
     [name      =? n --> doFloat              | n <- myFloatCN],

     [className =? c <&&> role =? "browser" --> doShift  "1.web" | c <- myWebs],

     [className =? c --> doShift  "2.chat"    | c <- myChats],
     [classNotRole ("Skype", "ConversationsWindow") --> moveToChat],
     -- FIXME
     [role =? "pop-up" --> doShift  "2.chat"],
     [currentWs =? "2.chat" --> keepMaster "Thunderbird"],

     [className =? "Gnome-terminal" <&&> role =? "dev" --> doShift  "3.dev",
      className =? "Gnome-terminal" <&&> role =? "aux" --> doShift  "4.aux"],

     [className =? c --> doShift  "5.media" | c <- myMedia],
     [className =? c --> doShift  "6.reading" | c <- myReadings],

     [isFullscreen          --> doFullFloat]
    ])
  where
    myFloats   = ["Mplayer", "Ffplay", "Vlc", "GIMP"]
    myWebs     = ["Firefox", "Google-chrome", "Google-chrome-stable"]
    myChats    = ["Thunderbird", "Skype"]
    myMedia    = ["Deadbeef"]
    myReadings = ["Evince"]

    myFloatCN = ["Choose a file", "Open Image", "File Operation Progress", "Firefox Preferences",
                 "Preferences", "Search Engines", "Set up sync", "Passwords and Exceptions",
                 "Autofill Options", "Rename File", "Copying files", "Moving files",
                 "File Properties", "Replace", "Quit GIMP", "Change Foreground Color",
                 "Change Background Color", ""]

    classNotRole :: (String, String) -> Query Bool
    classNotRole (c,r) = className =? c <&&> role /=? r

    role = stringProperty "WM_WINDOW_ROLE"
    name = stringProperty "WM_NAME"

    moveToChat   = doF $ W.shift "2.chat"

    keepMaster c = assertSlave <+> assertMaster where
                assertSlave = fmap (/= c) className --> doF W.swapDown
                assertMaster = className =? c --> doF W.swapMaster

------------------------------------------------------------------------
-- Status bars and logging

-- Dzen/Conky
myBitmapsDir = "~/.xmonad/dzen2"

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
--
-- FIXME: spawn only once
myStartupHook = do
        spawnOn "1.web" "x-www-browser"
        spawnOn "2.chat" "skype.sh"
        spawnOn "2.chat" "thunderbird"
        spawnOn "2.chat" "x-www-browser --app=https://nginx.slack.com/messages/dev/"
        spawnOn "3.dev" (myTerminal ++ "  --role=dev")
        spawnOn "4.aux" (myTerminal ++ "  --role=aux")
        -- move music status to a tray
        spawnOn "4.media" "deadbeef"
        spawn myXAutoLock

------------------------------------------------------------------------
-- Main config
--
myMainConfig dzLH = defaultConfig {
    terminal           = myTerminal,
    focusFollowsMouse  = True,
    borderWidth        = 2,
    modMask            = mod4Mask,
    workspaces         = ["1.web", "2.chat", "3.dev", "4.aux", "5.media", "6.reading"] ++ map show [7..9],
    normalBorderColor  = "gray",
    focusedBorderColor = "red",

    keys               = myKeys,
    mouseBindings      = myMouseBindings,
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
--     startupHook        = myStartupHook,
    logHook            = myLogHook dzLH >> fadeInactiveLogHook 0xdddddddd
}

------------------------------------------------------------------------
-- A copy of the default bindings in simple textual tabular format.
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

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
main = do
      dzenLeftBar <- spawnPipe "dzen2 -x '1440' -y '0' -h '24' -w '1000' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
      dzenRightBar <- spawnPipe "conky -c ~/.conkyrc"
      xmonad $ withUrgencyHook dzenUrgencyHook { args = ["-bg", "red", "fg", "black", "-xs", "1", "-y", "25"] }
             $ myMainConfig dzenLeftBar
