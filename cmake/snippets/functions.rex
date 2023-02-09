in = .stream~new("functions.txt")
ou = .stream~new("functions.h.in")

rc = in~open( "READ" )
rc = ou~open( "WRITE REPLACE" )

call lineout ou, "/*" copies("- ",35)
call lineout ou, "*/"
call lineout ou, "#ifndef functions_h_included"
call lineout ou, "#define functions_h_included"

do while ( lines(in) > 0 )
  thething = strip(linein(in) )

  if thething = "" then do
    call lineout ou, ""
    iterate
  end

  call lineout ou, ""
  buf = "/* Define to 1 if the system has the '" || thething || "' function. */ "
  call lineout ou, buf

  buf = "#cmakedefine " || "HAVE_" || translate(translate(thething,"__","/.") )
  call lineout ou, buf
end

call lineout ou, ""
call lineout ou, "#endif  /*  functions_h_included */"

rc = ou~close()
rc = in~close()

exit
