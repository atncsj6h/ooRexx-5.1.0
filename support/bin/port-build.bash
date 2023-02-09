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

if  [ 1 -eq 1 ] ; then
echo "${hd}at entry"
echo "@@"
echo "${hd}£0    '$0'"
echo "${hd}argc  '$#'"
echo "${hd}args  '$@'"
echo "${hd}path  '$PATH'"
echo "${hd}cwd   '$(pwd)'"
echo "@@"
fi

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
while true ; do

  flag=$(printf "%s" $1 )

  case "${flag}" in

	  -y | --ye | --yes)
	    yesno=y
      shift 1 || { Usage 1 ; }
      continue
      ;;

    -v | -verbose | --verbose )
      verbose=y
      shift 1 || { Usage 1 ; }
      continue
    ;;

    -DOT | -triplet | --triplet )
      triplet="${2}"
      shift 2 || { Usage 1 ; }
      continue
      ;;

    -VER | -version | --version )
      version="${2}"
      shift 2 || { Usage 1 ; }
      continue
      ;;

    -DIR | -portdir | --portdir)
      portdir="${2}"
      shift 2 || { Usage 1 ; }
      continue
      ;;

    -MS | -makeself | --makeself )
      makeself="${2}"
      shift 2 || { Usage 1 ; }
      continue
      ;;

    -MAN | -manifest | --manifest )
      manifest="${2}"
      shift 2 || { Usage 1 ; }
      continue
    ;;

    -p | -prefix | --prefix )
      prefix="${2}"
      shift 2 || { Usage 1 ; }
      continue
    ;;

    -- )
      shift 1  || { Usage 1 ; }
      break
    ;;

    "-"*)
	    echo "@@  $me - Unrecognized flag :"$1
      exit 1
	  ;;

    *)
	    break
	  ;;

  esac

done


if  [ 1 -eq 1 ] ; then
echo "${hd}after argument parsing "
echo "@@"
echo "${hd}£0       '$0'"
echo "${hd}argc     '$#'"
echo "${hd}args     '$@'"
echo "${hd}path     '$PATH'"
echo "${hd}cwd      '$(pwd)'"
echo "@@"


echo "${hd}yesno    '${yesno}'"
echo "${hd}verbose  '${verbose}'"
echo "${hd}triplet  '${triplet}'"
echo "${hd}version  '${version}'"
echo "${hd}prefix   '${prefix}'"
echo "${hd}portdir  '${portdir}'"
echo "${hd}makeself '${makeself}'"
echo "${hd}manifest '${manifest}'"

fi


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

