#! /usr/bin/env rexx

/*
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2022, 2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)
*/

say '.RexxInfo:'
say

rexxInfo = .RexxInfo~class           -- get .RexxInfo's class object
methods  = rexxInfo~methods(.nil)    -- query all its instance methods
done = 0
skip = 0
do method over methods~allIndexes~sort
  if translate(method) = translate("copy") then do
    skip += 1
    iterate
  end
  interpret "value = .rexxinfo~"method
  if translate(method) = translate("endofline") then do
    say left(method, 24) "'"c2x(value)"'"
    done += 1
    iterate
  end
  say left(method, 24) value
  done +=1
end

say
say "entries  : processed '"done"', skipped '"skip"'"

exit
