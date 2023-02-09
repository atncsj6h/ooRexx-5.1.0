#! /usr/bin/env bash

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function Usage() {
  exit $1
}

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function __yesno() {
  for ((;;)) ; do
    echo "${1}Enter [y](ENTER) to continue"
    echo "${1}      [n/q]      to Exit"
    read z
    if [ "${z}". == . ] ; then
        return 0
    fi
    z=${z,,}
    case ${z} in
      y | ye |yes )  return 0
          ;;
      *)  return 1
          ;;
    esac
  done
}

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

me="skel""        "
me=${me:0:8}

hd="@@  ${me} - "



echo "${hd}at entry"
echo "@@"
echo "${hd}£0    '$0'"
echo "${hd}argc  '$#'"
echo "${hd}args  '$@'"
echo "${hd}path  '$PATH'"
echo "${hd}cwd   '$(pwd)'"


echo "@@"

__yesno "${hd}"
yesno=$?
if [ ${yesno} -eq 1 ] ; then
  echo "${hd}canceled"
  echo "${hd}bye"
  echo "@@"
  exit 1
fi

echo "${hd}at exit"
echo "@@"
echo "${hd}\$0    '$0'"
echo "${hd}argc  ($#)"
echo "${hd}args  '$@'"
echo "@@"

echo "${hd}bye"
echo "@@"

exit 0

