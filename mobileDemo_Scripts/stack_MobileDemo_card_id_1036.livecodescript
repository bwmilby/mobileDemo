Script "stack_MobileDemo_card_id_1036"

/*
# Name: card id 1036 of stack "MobileDemo"
# ID: card id 1036 of stack "MobileDemo"
*/


on preOpenCard
   updateStatus "preOpenCard" & lf --& getRects()
   -- need to be sure positions updated if size was changed while on another card
   resizeStack the width of this card, the height of this card
   
   local tData
   put the arrayData of widget 1 of me into tData
   put "" into tData[0 && the ticks]
   set the arrayData of widget 1 of me to tData
end preOpenCard


on resizeStack pNewW, pNewH, pOldW, pOldH
   lock screen
   updateStatus "resizeStack" && pNewW & slash & pNewH & slash & \
         pOldW & slash & pOldH & lf & getRects()
   
   set the width of group "grpMode" of me to pNewW
   
   set the top of group "grpSize" of me to \
         the bottom of group "grpMode" of me - 4
   set the width of group "grpSize" of me to pNewW
   
   set the height of widget 1 of me to pNewH - (the bottom of group "grpSize" of me + 18)
   set the top of widget 1 of me to \
         the bottom of group "grpSize" of me + 6
   set the width of widget 1 of me to pNewW - 24
   set the left of widget 1 of me to 12
   
   setBackground
   unlock screen
end resizeStack


on setBackground
   lock screen
   set the rect of graphic "StackBackground" of me to the rect of this card
   unlock screen
end setBackground

