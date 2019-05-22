Script "stack_MobileDemo_button_id_1022"

/*
# Name: button "SizeBehavior" of group "grpBehaviors" of card "Index" of stack "MobileDemo"
# ID: button id 1022 of group id 1027 of card id 1002 of stack "MobileDemo"
*/


//>CONSTANTS
constant kLandscape = "landscape left,landscape right"
constant kPortrait = "portrait,portrait upside down"


on mouseUp
   local tHeight, tName, tSize, tWidth
   
   lock screen
   if the fullscreenmode of this stack is empty \
         and the environment is "mobile" then
      updateStatus "FullScreenMode: none" & lf \
            & tab & "Stack always resizes to screen rect" & lf \
            & tab & "Can not manually set a stack size" & lf
      exit mouseUp
   end if
   
   put the short name of me into tName
   updateStatus "Button:" && tName && "[" & the long time & "]" & lf
   setButtonBorder tName
   
   put the width of this card into tWidth
   put the height of this card into tHeight
   if tName is "deviceMax" then
      if the environment is "mobile" then
         setDeviceOrientationScreenRects
         set the rect of this stack to the effective working screenRect
      else
         if tWidth > tHeight then
            orientationChanged "portrait"
         else
            orientationChanged "landscape"
         end if
      end if
   else
      put the label of me into tSize
      if the environment is "mobile" then
         mobileSetFullScreenRectForOrientations kPortrait, "0,0," & tSize
         mobileSetFullScreenRectForOrientations kLandscape, "0,0," & \
               item 2 of tSize & comma & item 1 of tSize
      end if
      if tWidth > tHeight then
         setStackRect item 2 of tSize & comma & \
               item 1 of tSize
      else
         setStackRect tSize
      end if
   end if
   unlock screen
end mouseUp


command initializeOrientationScreenRects
   local tRect, tScreenH, tScreenW
   
   if the environment is "mobile" then
      updateStatus "initializeOrientationScreenRects" & lf
      mobileSetFullScreenRectForOrientations kPortrait, \
            the uStackRectPortrait of this stack
      mobileSetFullScreenRectForOrientations kLandscape, \
            the uStackRectLandscape of this stack
      
      put the effective working screenrect into tRect
      put item 3 of tRect - item 1 of tRect into tScreenW
      put item 4 of tRect - item 2 of tRect into tScreenH
      if tScreenH > tScreenW then
         set the uPortraitDeviceRect of this stack to tRect
      else
         set the uLandscapeDeviceRect of this stack to tRect
      end if
   end if
end initializeOrientationScreenRects


command setDeviceOrientationScreenRects
   local tLandscapeRect, tPortraitRect, tRect, tScreenH, tScreenW
   local tSetRect
   
   lock screen
   put the effective working screenrect into tRect
   put item 3 of tRect - item 1 of tRect into tScreenW
   put item 4 of tRect - item 2 of tRect into tScreenH
   put the uPortraitDeviceRect of this stack into tPortraitRect
   put the uLandscapeDeviceRect of this stack into tLandscapeRect
   updateStatus "Cached FSM device rects:" & lf & \
         "P" && tPortraitRect & " / L" && tLandscapeRect & lf
   if tPortraitRect is empty then
      if tScreenH > tScreenW then
         put tRect into tPortraitRect
         set the uPortraitDeviceRect of this stack to tRect
         put true into tSetRect
      else
         put 0,0,tScreenH,tScreenW into tPortraitRect
      end if
   end if
   if tLandscapeRect is empty then
      if tScreenW > tScreenH then
         put tRect into tLandscapeRect
         set the uLandscapeDeviceRect of this stack to tRect
         put true into tSetRect
      else
         put 0,0,tScreenH,tScreenW into tLandscapeRect
      end if
   end if
   mobileSetFullScreenRectForOrientations kPortrait, tPortraitRect
   mobileSetFullScreenRectForOrientations kLandscape, tLandscapeRect
   updateStatus "FSM device rects used:" & lf & \
         "P" && tPortraitRect & " / L" && tLandscapeRect
   if tSetRect then
      set the rect of this stack to tRect
   end if
   unlock screen
end setDeviceOrientationScreenRects


private command setStackRect pNewSize
   local tRect
   
   if the environment is "mobile" then
      put 0,0 into tRect
      put pNewSize into item 3 to 4 of tRect
   else
      put the topleft of this stack into tRect
      put item 1 of pNewSize + item 1 of tRect into item 3 of tRect
      put item 2 of pNewSize + item 2 of tRect into item 4 of tRect
   end if
   lock screen
   updateStatus "Setting new size:" && pNewSize & lf --& getRects()
   set the rect of this stack to tRect
   unlock screen
end setStackRect
