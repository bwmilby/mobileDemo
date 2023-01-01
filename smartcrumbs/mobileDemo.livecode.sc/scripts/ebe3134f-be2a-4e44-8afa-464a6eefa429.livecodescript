on resizeStack pNewW, pNewH, pOldW, pOldH
   lock screen
   setBackground
   unlock screen
end resizeStack


on setBackground
   lock screen
   set the rect of graphic"StackBackground" of me to the rect of this card
   unlock screen
end setBackground
