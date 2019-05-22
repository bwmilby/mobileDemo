Script "stack_MobileDemo_"

/*
# Name: stack "MobileDemo"
# ID: stack "MobileDemo"
*/


//>LOCALS
local sLog


on savingMobileStandalone pTargetType, pAppBundle
   local tHeight, tLandscape, tPortrait, tVersion, tWidth
   
   put the width of this stack into tWidth
   put the height of this stack into tHeight
   if tHeight > tWidth then
      put the rect of this card into tPortrait
      put "0,0," & tHeight & comma & tWidth into tLandscape
   else
      put the rect of this card into tLandscape
      put "0,0," & tHeight & comma & tWidth into tPortrait
   end if
   set the uStackRectPortrait of this stack to tPortrait
   set the uStackRectLandscape of this stack to tLandscape
   
   put the cRevStandaloneSettings["android,version code"] of this stack into tVersion
   add 1 to tVersion
   set the cRevStandaloneSettings["android,version code"] of this stack to tVersion
   save this stack
end savingMobileStandalone


on savingStandalone
   put "savingStandalone"
end savingStandalone


command updateStatus pStatus
   put pStatus & lf before sLog
   put sLog into field "Status" of card "Index" of this stack
end updateStatus


command refreshStatus
   put sLog into field "Status" of card "Index" of this stack
end refreshStatus


function getRects
   local tRects
   
   put "Screen:" && the screenRect && slash && \
         "Stack:" && the rect of this stack & lf after tRects
   put "Working:" && the working screenRect && slash && \
         "Effective:" && the effective working screenRect & lf after tRects
   return tRects
end getRects
