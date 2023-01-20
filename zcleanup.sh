#!/bin/sh


keep="-exec echo {} "

remove="-exec git rm -f {} "
remove="-exec echo {} "

if [ $# == 2 ]; then
  if [ $1 == "remove" ] && [ $2 == "remove" ]; then
    action="-exec git rm -f {} "
  else
    action="-exec echo {} "
  fi
else
  action="-exec echo {} "
fi

# find $rex5 -type d -iname "windows"       -not -path '*git*' ${action} \;

echo "**** $0 **** to be deleted "
find $rex5 -type f -iname "info.plist"    -not -path '*git*' ${action} \;
find $rex5 -type f -iname "files.html"    -not -path '*git*' ${action} \;
find $rex5 -type f -iname "*readme*"      -not -path '*git*' ${action} \;

find $rex5 -type f -iname "*.cmd"         -not -path '*git*' ${action} \;
find $rex5 -type f -iname "*.o"           -not -path '*git*' ${action} \;
find $rex5 -type f -iname "*.so"          -not -path '*git*' ${action} \;
find $rex5 -type f -iname "*.dylib"       -not -path '*git*' ${action} \;

find $rex5 -type f -iname "*.xml"         -not -path '*git*' ${action} \;
find $rex5 -type f -iname "*.xsl"         -not -path '*git*' ${action} \;

find $rex5 -type f -iname "*.def"         -not -path '*git*' ${action} \;

echo "**** $0 **** to be kept "
find . -type f -iname "*.c"               -not -path '*git*' ${keep} \;
find . -type f -iname "*.cls"             -not -path '*git*' ${keep} \;
find . -type f -iname "*.cmake"           -not -path '*git*' ${keep} \;
find . -type f -iname "*.cpp"             -not -path '*git*' ${keep} \;
find . -type f -iname "*.h"               -not -path '*git*' ${keep} \;
find . -type f -iname "*.hpp"             -not -path '*git*' ${keep} \;
find . -type f -iname "*.in"              -not -path '*git*' ${keep} \;
find . -type f -iname "*.orx"             -not -path '*git*' ${keep} \;
find . -type f -iname "*.rex"             -not -path '*git*' ${keep} \;
find . -type f -iname "*.1"               -not -path '*git*' ${keep} \;
