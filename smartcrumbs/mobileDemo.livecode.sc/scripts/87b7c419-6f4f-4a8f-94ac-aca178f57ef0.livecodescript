on preOpenCard
   local tOrientations
   if the environment is "mobile" then
      put "portrait,portrait upside down,landscape left,landscape right" into tOrientations
      mobileSetAllowedOrientations tOrientations
   end if
end preOpenCard


on resizeStack pNewW, pNewH, pOldW, pOldH
   lock screen
   updateStatus "resizeStack" && pNewW & slash & pNewH & slash & \
         pOldW & slash & pOldH & lf & getRects()

   set the width of group"grpMode" of me to pNewW

   set the top of group"grpSize" of me to \
         the bottom of group"grpMode" of me - 4
   set the width of group"grpSize" of me to pNewW

   setBackground
   unlock screen
end resizeStack


on setBackground
   lock screen
   set the rect of graphic"StackBackground" of me to the rect of this card
   unlock screen
end setBackground
