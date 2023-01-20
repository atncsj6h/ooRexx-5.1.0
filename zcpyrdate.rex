#! /usr/bin/env rexx

Trace "O"
signal on novalue name novalue

ibmy = "/* Copyright (c) xxxx, xxxx IBM Corporation. All rights reserved.             */"
rlay = "/* Copyright (c) xxxx-xxxx Rexx Language Association. All rights reserved.    */"

parse arg file

code = fread( file )
size = code~dimension(1)

chgd = 0
do l = 1 to 20

  if left(code[l],2) = "/*" , ,
    pos( "Copyright (c)", code[l] ) > 0 , ,
    pos( "Rexx Language Association", code[l] ) > 0 then do
      chgd = 1
      line = code[l]
      parse value code[l] with "/*" text "*/"
      text = space(text)
      parse var text head "-" . tail
      text = head", 2023 Rexx Language Association. All rights reserved."
      code[l] = "/*" left( text, 74) "*/"
  end
end

if chgd, \fwrite( file, code ) then ,
  signal logic_error
exit

/*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
fread:procedure
  use strict arg file
  hnd = .stream~new(file)
  if  hnd~open( "read" ) \= "READY:" then ,
    signal logic_error
  arr = hnd~arrayin
  if  hnd~close \= "READY:" then ,
    signal logic_error
  return arr

/*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
fwrite:procedure
  use strict arg file, arr
  say "*****" file
  hnd = .stream~new(file)
  if  hnd~open( "write replace" ) \= "READY:" then ,
    signal logic_error
  if  hnd~arrayout(arr) \= 0 then ,
    signal logic_error
  if  hnd~close \= "READY:" then ,
    signal logic_error
  return .true

/*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
logic_error:
say  "**  " || copies("- ", 38)
say  "**  " || "Logic error at line '"sigl"' "
exit

/*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*/
novalue:
say  "**  " || copies("- ", 38)
say  "**  " || "Novalue trapped, line '"sigl"' var '"condition("D")"' "
exit
