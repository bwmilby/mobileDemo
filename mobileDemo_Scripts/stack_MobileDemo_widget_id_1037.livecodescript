Script "stack_MobileDemo_widget_id_1037"

/*
# Name: widget "TreeView" of card id 1036 of stack "MobileDemo"
# ID: widget id 1037 of card id 1036 of stack "MobileDemo"
# Widget Kind: com.livecode.widget.treeview
*/


local sScrollerID, sScrollerRect

on preOpenCard
   if isMobile() then
      mobileControlCreate "scroller"
      put the result into sScrollerID
      put ("0,0," & (the width of me) & comma & the formattedHeight of me) into sScrollerRect
      mobileControlSet sScrollerID, "rect", the rect of me
      mobileControlSet sScrollerID, "contentRect", sScrollerRect
      mobileControlSet sScrollerID, "hScroll", 0
      mobileControlSet sScrollerID, "vScroll", 0
      mobileControlSet sScrollerID, "visible", true
   end if
end preOpenCard

on closeCard
   if isMobile() then
      mobileControlDelete sScrollerID
   end if
end closeCard

on formattedHeightChanged
   if isMobile() then
      put the formattedHeight of me into item 4 of sScrollerRect
      mobileControlSet sScrollerID, "contentRect", sScrollerRect
   end if
end formattedHeightChanged

on scrollerDidScroll pHScroll, pVScroll
   set the vScroll of me to pVScroll
   pass scrollerDidScroll
end scrollerDidScroll

function isMobile
   return the environment = "mobile"
end isMobile
