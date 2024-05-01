local sScrollerID, sScrollerRect

command createScroller pName -- scrolling fields
   local tRect
   local tWidth
   if not isMobile() then exit createScroller
   deleteMobileControl pName -- delete any existing

   put (the rect of control pName) into tRect
   mobileControlCreate "scroller", pName
   put the result into sScrollerID
   mobileControlSet pName, "rect", tRect
   put the formattedwidth of control pName into tWidth
   if tWidth is empty then
      put the width of control pName into tWidth
   end if
   put ("0,0," & tWidth & "," & \
         the formattedheight of control pName) into sScrollerRect
   mobileControlSet pName, "contentRect", sScrollerRect
   mobileControlSet pName, "hScroll", 0
   mobileControlSet pName, "vScroll", 0
   mobileControlSet pName, "hIndicator", false
   mobileControlSet pName, "vIndicator", true
   mobileControlSet pName, "visible", true
end createScroller


on updateScroller pName
   local tWidth
   if not isMobile() then exit updateScroller
   if pName is among the lines of mobileControls() then -- update
      put the formattedwidth of control pName into tWidth
      if tWidth is empty then
         put the width of control pName into tWidth
      end if
      put ("0,0," & tWidth & "," & \
            the formattedheight of control pName) into sScrollerRect
      mobileControlSet pName, "contentRect", sScrollerRect
      mobileControlSet pName, "hScroll", 0
      mobileControlSet pName, "vScroll", the vScroll of control pName
   else
      createScroller pName
   end if
end updateScroller


on scrollerDidScroll pHScroll, pVScroll
   local tControlID
   put mobileControlTarget() into tControlID
   set the vScroll of control tControlID to pVScroll
end scrollerDidScroll


on deleteMobileControl pName -- jg: deletes an existing mobile contro
   -- native controls should be deleted if possible when no longer needed, as
   -- they are overlaid on the stack and will float over all cards
   if not isMobile() then exit deleteMobileControl -- do nothing on desktop
      repeat while pName is among the lines of mobileControls()
         mobileControlDelete pName
      end repeat
      end deleteMobileControl


      on formattedHeightChanged
   if isMobile() then
      put the formattedHeight of me into item 4 of sScrollerRect
      mobileControlSet sScrollerID, "contentRect", sScrollerRect
   end if
end formattedHeightChanged
