Script "stack_MobileDemo_card_id_1028"

/*
# Name: card id 1028 of stack "MobileDemo"
# ID: card id 1028 of stack "MobileDemo"
*/


on preOpenCard
   updateStatus "preOpenCard" & lf --& getRects()
   -- need to be sure positions updated if size was changed while on another card
   resizeStack the width of this card, the height of this card
end preOpenCard


on resizeStack pNewW, pNewH, pOldW, pOldH
   lock screen
   updateStatus "resizeStack" && pNewW & slash & pNewH & slash & \
         pOldW & slash & pOldH & lf & getRects()
   
   set the width of group "grpMode" of me to pNewW
   
   set the top of group "grpSize" of me to \
         the bottom of group "grpMode" of me - 4
   set the width of group "grpSize" of me to pNewW
   
   setBackground
   unlock screen
end resizeStack


on setBackground
   lock screen
   set the rect of graphic "StackBackground" of me to the rect of this card
   unlock screen
end setBackground
