#!/bin/sh

Usage()
{
  exit $1
}

me="cleanup "

echo "@@  $me   at entry"
echo "@@"
echo "@@  $me   pwd   "$(pwd)
echo "@@  $me   PATH  "$PATH
echo "@@  $me   £0    "$0
echo "@@  $me   £me   "$(basename $0)
echo "@@  $me   argc  "$#
echo "@@  $me   args  "$@
echo "@@"
echo "@@  $me   at exit"

exit

