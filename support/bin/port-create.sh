#! /usr/bin/env bash

Usage()
{
  exit $1
}


me="create "

echo "@@ $me  at entry"
echo "@@"
echo "@@ $me  pwd   "$(pwd)
echo "@@ $me  PATH  "$PATH
echo "@@ $me  \$0   "$0
echo "@@ $me  SELF  "$(basename $0)
echo "@@ $me  argc  "$#
echo "@@ $me  args  "$@
echo "@@"


FILEICON=""
MAKESELF=""
MANIFEST="install_manifest.txt"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
while true ; do

  flag=$(printf "%s" $1 )

  case "${flag}" in

    -makeself | --makeself )
      MAKESELF="${2}"
      shift 2 || { Usage 1 ; }
      continue
      ;;

    -manifest | --manifest )
      MANIFEST="${2}"
      shift 2 || { Usage 1 ; }
      continue
    ;;

    -prefix | --prefix )
      prefix="${2}"
      shift 2 || { Usage 1 ; }
      continue
    ;;

    -- )
      shift 1
      break
    ;;

    "-"*)
	    echo "@@ $me  Unrecognized flag :"$1
      exit 1
	  ;;

    *)
	    break
	  ;;

  esac

done

echo "@@ $me  after argument parsing"
echo "@@"
echo "@@ $me  argc  "$#
echo "@@ $me  args  "$@
echo "@@"

# accomodate for makeself.sh being in different places
if  [ "${MAKESELF}".  == "". ] ; then
  MAKESELF="$(which makeself.sh)"
fi
if  [ "${MAKESELF}".  == "". ] ; then
  if    test -f "/usr/local/bin/makeself.sh" ; then
    MAKESELF="/usr/local/bin/makeself.sh"
  else
    echo "@@ unable to build the self extracting installer"
  fi
fi
if  [ "${MAKESELF}".  != "". ] ; then
  if  ! test -x ${MAKESELF} ; then
    echo "@@ unable to build the self extracting installer"
    MAKESELF=""
  fi
fi

# handling a preexisting install_manifest.txt
#   from a normal 'gmake install' or from a 'gmake portable'

head=""
if    test -f install_manifest.txt ; then
  while read -r head; do
    break
  done <<< $( sort install_manifest.txt )

  if [[ ${prefix}/./ == ${head:0:${#prefix}}/./ ]] ; then
    mv -f "${MANIFEST}" "${MANIFEST}.orig"
    echo "@@ ${MANIFEST} backup rc("$?")"
  fi
fi

cmake -DCMAKE_INSTALL_PREFIX=portable/ooRexx-5.1.0 -P cmake_install.cmake 1>/dev/null
RC=$?
echo "@@ cmake rc("$RC")"

if [[ ${RC} == 0 ]] ; then
  if    test -f ${MANIFEST}.orig ; then
    mv -f ${MANIFEST}.orig ${MANIFEST}
    echo "@@ ${MANIFEST} restore rc("$?")"
  else
    echo "@@ ${MANIFEST}.orig missing "
  fi
fi

exit

