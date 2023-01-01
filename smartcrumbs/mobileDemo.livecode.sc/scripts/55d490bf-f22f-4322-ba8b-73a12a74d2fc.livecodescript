on mouseUp
   local tOrientations
   if the environment is "mobile" then
      put "portrait,portrait upside down,landscape left,landscape right" into tOrientations
      mobileSetAllowedOrientations tOrientations
   end if
end mouseUp