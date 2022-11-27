{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-} -- Hightlight Bar

-- ================================ IMPORT ==============================================
import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import qualified XMonad.StackSet as W
import qualified Data.Map as M  
import XMonad.Actions.SwapPromote                       -- M-f swapping
import XMonad.Hooks.ManageDocks                         -- avoidStruts
import XMonad.Hooks.InsertPosition                      -- New window as master
 
import XMonad.Hooks.EwmhDesktops                        -- EWMH compliance
 
import XMonad.Actions.Submap
import XMonad.Actions.CycleWS 
import XMonad.Actions.CycleRecentWS
import XMonad.Layout.Reflect
import XMonad.Actions.DwmPromote 
 
-- For Highlight bar 
import XMonad.Layout.Decoration                         -- Creating decorated layouts.
import XMonad.Util.Types                                -- Miscellaneous commonly used types.  
 
-- POLYBAR 
import XMonad.Hooks.DynamicLog
import qualified Codec.Binary.UTF8.String              as UTF8
import qualified DBus                                  as D
import qualified DBus.Client                           as D
 
-- For subTabbed 
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation  
import XMonad.Layout.BoringWindows                      -- Skip hidden windows
import XMonad.Actions.PerLayoutKeys                     -- Different M-j & M-k for subtabbed and full
import XMonad.Layout.Renamed as RN
import XMonad.Actions.PerWindowKeys                     -- TODO
import XMonad.Actions.FloatKeys                         -- TODO
 
 
import qualified XMonad.Util.Hacks as Hacks             -- Fixes fake fullscreen 
 
-- For Scratchpad  
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.RefocusLast                         -- Supposed to fix scratchpad and subTabbed issue
  
-- ============================ GLOBALLY AVAILABLE =====================================
thenRefocusAfter :: Query Bool -> X a -> X a            -- Supposed to fix scratchpad and subTabbed issue
p `thenRefocusAfter` act = do
  tag     <- gets (W.currentTag . windowset)
  refocus <- refocusWhen p tag
  act <* windows refocus

isScratchPad :: NamedScratchpads -> Query Bool
isScratchPad = foldr (\ns b -> query ns <||> b) (pure False)   
    
-- where                                                -- refocusLast stuff(now global)
myPred = refocusingIsActive <||> isFloat
refocusLastKeys cnf
  = M.fromList
  $ ((modMask cnf              , xK_a), toggleFocus)
  : ((modMask cnf .|. shiftMask, xK_a), swapWithLast)
  : ((modMask cnf              , xK_b), toggleRefocusing)
  : [ ( (modMask cnf .|. shiftMask, n)
      , windows =<< shiftRLWhen myPred wksp
      )
    | (n, wksp) <- zip [xK_a..xK_i] (workspaces cnf)
    ]
  
scratchpads =
  [ -- (className =? "htop")/(title =? "htop")
    NS
      "htop"
      "alacritty -t htop -e htop"
      (title =? "htop")
      -- defaultFloating ,
      (customFloating $ W.RationalRect (2 / 7) (1 / 9) (2 / 5) (2 / 4)),
      --                                  x       y       l       h 
    NS
      "qBittorrent"
      "qbittorrent"
      (className =? "qBittorrent")
      -- defaultFloating ,
      (customFloating $ W.RationalRect (2 / 7) (1 / 9) (2 / 5) (2 / 4)),
      --                                  x       y       l       h 
    NS
      "scratch"
      "alacritty -t scratch -e lvim ~/.md/scratch.md ~/.md/todo.md ~/.md/routine.md ~/.md/reference.md ~/.md/ideas.md"
      (title =? "scratch")
      (customFloating $ W.RationalRect (2 / 6) (1 / 9) (2 / 5) (2 / 4)),
      --                                  x       y       l       h 
    NS
      "tags"
      "alacritty -t tags -e tags"
      (title =? "tags")
      (customFloating $ W.RationalRect (2 / 5) (2 / 9) (2 / 9) (2 / 5))
      --                                  x       y       l       h 
  ]
  where
    role = stringProperty "WM_WINDOW_ROLE"
     
rofi_launch = spawn "rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \'papirus\' "
 
-- ============================== MY CONFIG ==============================================
myConfig dbus = def  
      { modMask             = mod4Mask,
        terminal            = "alacritty",
        borderWidth         = 0,
        manageHook          = insertPosition Master Newer <+> myManageHook,
        
        handleEventHook     = refocusLastWhen myPred <> myEventHook      ,
        -- use either layoutHook or logHook for refocuslast.
        logHook             = refocusLastLogHook
    				                    <> myPolybarLogHook dbus
				                        <> logHook       def,
        layoutHook          = myLayout                                   ,
        keys                = refocusLastKeys       
				<> keys          def
      }
      `additionalKeysP` myKeys
 
-- ============================== MY STUFF ==============================================
myEventHook = handleEventHook def <> Hacks.windowedFullscreenFixEventHook
 
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      className =? "ripdrag" --> doFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]
    <+> namedScratchpadManageHook scratchpads 

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]
 
-- ================================= MY LAYOUT =======================================
myLayout = avoidStruts (tiled ||| Full)
  where
    tiled   =  renamed [RN.Replace "tiled"] $ myDecorate $ windowNavigation $ subTabbed $ boringWindows $ reflectHoriz $ Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 3/5    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

-- ================================= KEYBINDINGS ======================================
myKeys :: [(String, X ())]
myKeys =
    [
      ("<XF86AudioMute>", spawn "amixer set Master toggle"),
      ("<XF86AudioLowerVolume>", spawn "amixer set Master 3%-"),
      ("<XF86AudioRaiseVolume>", spawn "amixer set Master 3%+"),
      ("<XF86MonBrightnessUp>", spawn "brightnessctl set 1%+"),
      ("<XF86MonBrightnessDown>", spawn "brightnessctl set 1%-"),
      ("<XF86TouchpadToggle>", spawn "toggle_touchpad"),
      ("<Print>", spawn "killall flameshot; flameshot full -p ~/screenshots_full -c"),
       
      -- ("M-f", windows W.swapMaster),
      ("M-f", whenX (swapHybrid True) dwmpromote),
      ("M-<Backspace>", kill),
      ("M-h", sendMessage Expand),
      ("M-l", sendMessage Shrink),
      ("M-b", spawn "polybar-msg cmd toggle"),
      ("M-q", sequence_ [spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi",
        spawn "sh $HOME/.config/polybar/launch.sh"]),
      -- ("M-i", namedScratchpadAction scratchpads "tags"),
      -- ("M-o", namedScratchpadAction scratchpads "scratch"),
      -- Below scratchpads are patched ones by [Leary] from xmonad IRC
      ("M-e", isScratchPad scratchpads `thenRefocusAfter` namedScratchpadAction scratchpads "scratch"),
      ("M-i", isScratchPad scratchpads `thenRefocusAfter` namedScratchpadAction scratchpads "tags"),
      ("M-t", withFocused toggleFloat), 

      ("M-S-<Return>", spawn "warpd --hint"),
       
      -- SCREENSHOTS
      ("M-p f", spawn "killall flameshot; flameshot full -p ~/screenshots_full -c"),
      ("M-p s", spawn "killall flameshot; flameshot gui -s -p ~/screenshots_cutout -c"),
      ("M-p a", spawn "scrotactive"),
              
      ("M-u p", spawn "systemctl poweroff"),
      ("M-u h", spawn "systemctl hibernate"),
      ("M-u r", spawn "systemctl reboot"),
      ("M-u s", spawn "systemctl suspend"),
      ("M-u l", spawn "xset dpms force off && slock"),
      ("<XF86PowerOff>", spawn "xset dpms force off"),
      ("M-<XF86PowerOff>", spawn "xset dpms force off && slock"),
      
      -- SPAWN APPLICATIONS
      ("M-s b", spawn "brave"),
      ("M-s s", asks (XMonad.terminal . config) >>= spawn), 
      ("M-s r", rofi_launch),
      ("M-s k", spawn "kitty"),
      ("M-s q", spawn "qbittorrent"),
      ("M-s h", spawn "htop"),
      ("M-s w", spawn "warpd --hint"),
      ("M-s e", spawn "microsoft-edge-stable"),
      ("M-s n", spawn "neovide-lunarvim"),
       
      -- MANAGING TABS  
      ("M-j", bindByLayout [("tiled", focusDown), ("Full", windows W.focusDown)]),
      ("M-k", bindByLayout [("tiled", focusUp), ("Full", windows W.focusUp)]),
       
      ("M-S-k", onGroup W.focusDown'),
      ("M-S-j", onGroup W.focusUp'),
       
      ("M-C-j", windows W.swapDown),
      ("M-C-k", windows W.swapUp),
       
      ("M-d h", sendMessage $ pullGroup L),
      ("M-d l", sendMessage $ pullGroup R),
      ("M-d k", sendMessage $ pullGroup U),
      ("M-d j", sendMessage $ pullGroup D),
      ("M-d m", withFocused (sendMessage . MergeAll)),
      ("M-d u", withFocused (sendMessage . UnMerge)),
       
      -- SWITCH WORKSPACES
      ("M-<L>", prevWS),
      ("M-<R>", nextWS),
      ("M-<U>", shiftToNext >> nextWS),
      ("M-<D>", shiftToPrev >> prevWS),
       
      ("M-o", submap . M.fromList $
        [((0,k),windows $ W.greedyView i) | (i,k) <- zip myWorkspaces [xK_a .. xK_i]]
        ++
        [((0, xK_m), submap . M.fromList $
         [((0, k), shiftRLWhen myPred i >>= \shift -> windows (W.greedyView i . shift))
         | (i, k) <- zip myWorkspaces [xK_a .. xK_i]]),
         ((0, xK_p), toggleRecentWS)
        ])
    ]
    where 
            toggleFloat w = windows (\s -> if M.member w (W.floating s)
                        then W.sink w s
                        else (W.float w (W.RationalRect (1/3) (1/4) (2/5) (3/5)) s)) 

-- ================================ HIGHLIGHT BAR ===================================
--                    Make sure to add myDecorate to layoutHook 
myTheme :: Theme
myTheme = def
  { activeColor         = "#FFFF00"
  , inactiveColor       = "#444c42"
  , activeBorderColor   = "#FFFF00"
  , inactiveBorderColor = "#444c42"
  , decoWidth           = 6
  }

-- The Decoration Style.
myDecorate :: Eq a => l a -> ModifiedLayout (Decoration SideDecoration DefaultShrinker) l a
myDecorate = decoration shrinkText myTheme (SideDecoration L)

data SideDecoration a = SideDecoration Direction2D
  deriving (Show, Read)

instance Eq a => DecorationStyle SideDecoration a where

  shrink b (Rectangle _ _ dw dh) (Rectangle x y w h)
    | SideDecoration U <- b = Rectangle x (y + fi dh) w (h - dh)
    | SideDecoration R <- b = Rectangle x y (w - dw) h
    | SideDecoration D <- b = Rectangle x y w (h - dh)
    | SideDecoration L <- b = Rectangle (x + fi dw) y (w - dw) h

  pureDecoration b dw dh _ st _ (win, Rectangle x y w h)
    | win `elem` W.integrate st && dw < w && dh < h = Just $ case b of
      SideDecoration U -> Rectangle x y w dh
      SideDecoration R -> Rectangle (x + fi (w - dw)) y dw h
      SideDecoration D -> Rectangle x (y + fi (h - dh)) w dh
      SideDecoration L -> Rectangle x y dw h
    | otherwise = Nothing             
      
-- ============================== POLYBAR =============================================
mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = (D.signal opath iname mname)
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#2E9AFE"
      gray   = "#7F7F7F"
      orange = "#ea4300"
      purple = "#9058c7"
      red    = "#722222"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper blue
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppHiddenNoWindows = wrapper red
          , ppTitle           = shorten 100 . wrapper purple
          }

myPolybarLogHook dbus = dynamicLogWithPP (polybarHook dbus)

-- ================================ MAIN ==============================================
main :: IO ()
main = do
  dbus <- mkDbusClient
  xmonad . docks . ewmh $ myConfig dbus
