on mouseUp
   local tOrientations
   if the environment is "mobile" then
      put "portrait,portrait upside down" into tOrientations
      mobileSetAllowedOrientations tOrientations
   end if
end mouseUp