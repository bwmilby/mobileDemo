Script "stack_MobileDemo_button_id_1024"

/*
# Name: button "GroupBehavior" of group "grpBehaviors" of card "Index" of stack "MobileDemo"
# ID: button id 1024 of group id 1027 of card id 1002 of stack "MobileDemo"
*/


//>LOCALS
local sButtonHeight, sButtons, sButtonWidth, sHOffset, sInitialized
local sLeftMargin, sSpace, sVOffset, sWidth


on resizeControl
   local tButton, tLoc
   
   if sInitialized is not true then __Initialize
   
   if the width of me >= sWidth then
      put the loc of button 3 of me into tLoc
      add sHOffset to item 1 of tLoc
   else
      put the loc of button 1 of me into tLoc
      add sVOffset to item 2 of tLoc
   end if
   
   repeat with tButton=4 to sButtons
      set the loc of button tButton of me to tLoc
      add sHOffset to item 1 of tLoc
   end repeat
   
   set the height of me to the bottom of button sButtons of me - the top me + 4
   
   updatestatus "resizeControl" && the short name of me \
         && slash && the rect of me & lf
end resizeControl


command setButtonBorder pButtonName
   if sInitialized is not true then __Initialize
   
   repeat with tButton=1 to sButtons
      if pButtonName is the short name of button tButton of me then
         set the bordercolor of button tButton of me to "red"
      else
         set the bordercolor of button tButton of me to empty
      end if
   end repeat
end setButtonBorder


on preOpenBackground pBackgroundID
   if the id of me is not pBackgroundID then pass preOpenBackground
   updateStatus "preOpenBackground" && the short name of me & lf
   if sInitialized is not true then __Initialize
end preOpenBackground


private command __Initialize
   updateStatus "Initialize" && the short name of me & lf
   
   put the left of button 1 of me into sLeftMargin -- 12
   put the left of button 2 of me - the right of button 1 of me into sSpace -- 10
   
   put the width of button 1 of me into sButtonWidth -- 80
   put sButtonWidth + sSpace into sHOffset -- 90
   
   put the height of button 1 of me into sButtonHeight -- 30
   put sButtonHeight + sSpace into sVOffset -- 40
   
   put the number of buttons in me into sButtons -- 6
   
   -- width necessary to display buttons in a single row
   put sLeftMargin * 2 + sButtonWidth * sButtons + \
         sSpace * (sButtons - 1) into sWidth -- 554
   
   put true into sInitialized
end __Initialize
