on mouseUp
   local tMode, tRect

   if the environment is not "mobile" then
      exit mouseUp
   end if

   lock screen
   put the short name of me into tMode

   -- checking here to put log entry in the right place (before the FSM change)
   if tMode is in "noScale,letterbox" then
      updateStatus "Change FSM to eliminate display artifacts" & lf
      if the fullscreenmode of this stack is not "exactFit" then
         set the fullscreenmode of this stack to "exactFit"
      else
         set the fullscreenmode of this stack to "showAll"
      end if
   end if

   updateStatus "FullScreenMode:" && tMode && "[" & the long time & "]" & lf
   setButtonBorder tMode
   put tMode into URL ("file:" & specialfolderpath("cache") & "/prefs")

   if the bordercolor of button"deviceMax" \
         of group"grpSize" of this card is "red" \
         or tMode is "none" then
   send "setDeviceOrientationScreenRects" \
         to button"SizeBehavior" of group"grpBehaviors" of card"Index"
   --   else if tMode is in"noScale,letterbox" then
   --      --updateStatus"Resized to eliminate display artifacts" & lf
   --      updateStatus"Change FSM to eliminate display artifacts" & lf
   --      if the fullscreenmode of this stack is not"exactFit" then
   --         set the fullscreenmode of this stack to"exactFit"
   --      else
   --         set the fullscreenmode of this stack to"showAll"
   --      end if
   end if
   if tMode is "none" then
      set the fullscreenmode of this stack to empty
      set the rect of this stack to the effective working screenRect
      send "setButtonBorder" && quote & "deviceMax" & quote to \
            group"grpSize" of this card
   else
      set the fullscreenmode of this stack to tMode
      setBackground
   end if

   if there is a field"Status" then
      send "createScroller Status" to field"Status" of this card
   else if there is a widget"TreeView" then
      send "createScroller TreeView" to widget"TreeView" of this card
   end if
   unlock screen
end mouseUp