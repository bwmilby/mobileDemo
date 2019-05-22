Script "stack_MobileDemo_card_id_1002"

/*
# Name: card "Index" of stack "MobileDemo"
# ID: card id 1002 of stack "MobileDemo"
*/


on preOpenStack
   local tMode, tOrientations, tStatus
   
   updateStatus "preOpenStack started"
   
   if the environment is "development" then
      set the rect of graphic "StackBackground" of me to 0,400,320,480
      set the rect of graphic "DeviceBackground" of me to 0,360,320,480
      show group "grpBehaviors" of me
   else
      hide group "grpBehaviors" of me
   end if
   
   if the environment is "mobile" then
      put "portrait,portrait upside down,landscape left,landscape right" into tOrientations
      mobileSetAllowedOrientations tOrientations
      put URL("file:" & specialfolderpath("cache") & "/prefs") into tMode
      if tMode is "" then put "none" into tMode
      if tMode is not "none" then
         send "initializeOrientationScreenRects" \
               to button "SizeBehavior" of group "grpBehaviors" of me
         set the fullscreenmode of this stack to tMode
         --send "setBackground" to me in 10 milliseconds
      else
         send "setDeviceOrientationScreenRects" \
               to button "SizeBehavior" of group "grpBehaviors" of me
         set the rect of this stack to the effective working screenRect
         send "setButtonBorder" && quote & "deviceMax" & quote to group "grpSize" of me
      end if
      send "setButtonBorder" && quote & tMode & quote to group "grpMode" of me
      set the label of button "deviceMax" to "Device"
      put lf & "FullScreenMode:" && tMode after tStatus
      put lf & "Device Scale:" && mobilePixelDensity() after tStatus
   else
      set the label of button "deviceMax" to "Rotate"
   end if
   if the platform is "iphone" then
      put lf & "Device resolution:" && iphoneDeviceResolution() after tStatus
   end if
   if the platform is "android" then
      put lf & "Mobile Build Info:" after tStatus
      repeat for each item tItem in "BRAND,CPU_ABI,DEVICE,DISPLAY" & \
            ",HARDWARE,MANUFACTURER,MODEL,PRODUCT"
         --BOARD,BOOTLOADER,CPU_ABI2,FINGERPRINT,HOST,
         --ID,RADIO,SERIAL,TAGS,TIME,TYPE,USER
         put lf & tab & tItem & ":" && mobileBuildInfo(tItem) after tStatus
      end repeat
   end if
   updateStatus "preOpenStack completed" & lf & tStatus & lf & getRects()
end preOpenStack


on preOpenCard
   updateStatus "preOpenCard" & lf --& getRects()
   -- need to be sure positions updated if size was changed while on another card
   resizeStack the width of this card, the height of this card
   if the environment is "development" then
      set the rect of graphic "StackBackground" of me to 0,400,320,480
   end if
end preOpenCard


on resizeStack pNewW, pNewH, pOldW, pOldH
   lock screen
   updateStatus "resizeStack" && pNewW & slash & pNewH & slash & \
         pOldW & slash & pOldH & lf & getRects()
   
   set the width of group "grpMode" of me to pNewW
   
   set the top of group "grpSize" of me to \
         the bottom of group "grpMode" of me - 4
   set the width of group "grpSize" of me to pNewW
   
   set the rect of field "Status" of me to \
         12, the bottom of group "grpSize" of me + 6, \
         pNewW - 12, pNewH - 12
   
   -- this group is hidden except for in the IDE
   set the right of group "grpBehaviors" of me to \
         the width of this card - 30
   set the top of group "grpBehaviors" of me to \
         the top of field "Status" of me
   
   setBackground
   unlock screen
end resizeStack


on setBackground
   local tCardH, tCardW, tNewH, tNewW, tRect, tScreenH, tScreenW
   
   lock screen
   set the rect of graphic "StackBackground" of me to the rect of this card
   if the fullscreenmode of this stack is "showAll" then
      -- need to translate the card rect coordinates to screen coordinates
      -- this allows setting the rect of a background img/grc to
      -- exactly cover the display area in `showAll` mode
      put the height of this card into tCardH
      put the width of this card into tCardW
      put the effective working screenRect into tRect
      put item 3 of tRect - item 1 of tRect into tScreenW
      put item 4 of tRect - item 2 of tRect into tScreenH
      put tCardW / (tScreenW / tScreenH) into tNewH
      put max(tNewH, tCardH) into tNewH
      put tCardH / (tScreenH / tScreenW) into tNewW
      put max(tNewW, tCardW) into tNewW
      set the height of graphic "DeviceBackground" of me to tNewH
      set the width of graphic "DeviceBackground" of me to tNewW
      set the loc of graphic "DeviceBackground" of me to the loc of this card
      updateStatus "DeviceBackground rect:" && \
            the rect of graphic "DeviceBackground" of me & lf
   end if
   unlock screen
end setBackground


on orientationChanged pNewOrientation
   local tCurrentOrientation, tHeight, tRect, tWidth
   
   lock screen
   if the environment is "mobile" then
      put word 1 of mobileDeviceOrientation() into pNewOrientation
      put word 1 of mobileOrientation() into tCurrentOrientation
      if the uLandscapeDeviceRect of this stack is empty and \
            the bordercolor of button "deviceMax" of group "grpSize" of me is "red" \
            and pNewOrientation is "landscape" then
         -- need to record device rect for landscape when using fullscreenmodes
         -- otherwise the `furniture` is not properly accounted for
         -- not needed for a `real` app since FSM would be used with a fixed rect
         send "setDeviceOrientationScreenRects" \
               to button "SizeBehavior" of group "grpBehaviors" of me \
               in 150 milliseconds
      end if
      -- ignore changes to `unknown`, `face up`, and `face down`
      -- and 180 degree changes (landscape left to landscape right)
      if pNewOrientation is in "portrait,landscape" and \
            pNewOrientation is not tCurrentOrientation then
         updateStatus "New Orientation:" && mobileDeviceOrientation() \
               && "[" & the long time & "]" & lf \
               & "Interface Orientation:" && mobileOrientation() & lf
      end if
   else -- the environment is "desktop" (doesn't make sense for server)
      -- figure out the current actual `orientation` of the card
      put the height of this card into tHeight
      put the width of this card into tWidth
      if tWidth > tHeight then
         put "landscape" into tCurrentOrientation
      else
         put "portrait" into tCurrentOrientation
      end if
      if pNewOrientation is not tCurrentOrientation then
         put the rect of this stack into tRect
         put item 1 of tRect + tHeight into item 3 of tRect
         put item 2 of tRect + tWidth into item 4 of tRect
         set the rect of this stack to tRect
         updateStatus "New Orientation:" && pNewOrientation && "[" & the long time & "]" \
               & lf & getRects()
      end if
   end if -- environment
   unlock screen
end orientationChanged


on suspend
   updateStatus "suspend" & lf
end suspend


on resume
   updateStatus "resume" & lf
end resume
