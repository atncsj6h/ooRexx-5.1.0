#!/bin/sh

Usage()
{
  exit $1
}

me="cleanup"
echo "@@ $me  at entry"
echo "@@"
echo "@@ $me  pwd   "$(pwd)
echo "@@ $me  PATH  "$PATH
echo "@@ $me  £0    "$0
echo "@@ $me  SELF  "$(basename $0)
echo "@@ $me  argc  "$#
echo "@@ $me  args  "$@
echo "@@"

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
args=""

while true ; do

  flag=$(printf "%s" $1 )

  case "${flag}" in

    --cleanup )
      cleanup=$2
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

exit
