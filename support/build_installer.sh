#!/bin/sh

set -x
MANIFEST="install_manifest.txt"

# accomodate for makeself.sh being in different places
MAKESELF="$(which makeself.sh)"
if  [ "${MAKESELF}".  == "". ] ; then
  if    test -f "/usr/local/bin/makeself.sh" ; then
    MAKESELF="/usr/local/bin/makeself.sh"
  # elif  test -f "/Users/enrico/Downloads/Darwin/makeself-2.4.5/makeself.sh" ; then
  #   MAKESELF="/Users/enrico/Downloads/Darwin/makeself-2.4.5/makeself.sh"
  else
    echo "@@ unable to build the self extracting installer"
  fi
fi

# accomodate for fileicon being in different places
FILEICON="$(which fileicon)"
if  [ "${FILEICON}".  == "". ] ; then
  if    test -f "/usr/local/bin/fileicon" ; then
    FILEICON="/usr/local/bin/fileicon"
  else
    echo "@@ unable to attach icons to files/directories"
  fi
fi

# check if an Open Object Rexx installation exists at CMAKE_INSTALL_PREFIX
# the CMAKE_INSTALL_PREFIX will be passed  with --prefix

echo $(pwd)
echo $PATH

cmake -DCMAKE_INSTALL_PREFIX=portable/ooRexx-5.1.0-portable -P cmake_install.cmake

exit

if  [ "$1". == "save".  ] ; then
  if  test -f ${IM} ; then
    mv ${IM} ${IM}.bak
    echo "## ${IM} saved to ${IM}.bak "
  else
    echo "## ${IM} not found "
  fi
  exit
fi

if  [ "$1". == "restore".  ] ; then
  if  test -f ${IM}.bak ; then
    mv ${IM}.bak ${IM}
    echo "## ${IM}.bak restored to ${IM} "
  else
    echo "## ${IM}.bak not found "
  fi
  exit
fi

exit


#!/bin/sh

IM="install_manifest.txt"

#

echo $(pwd)
echo $PATH

cmake -DCMAKE_INSTALL_PREFIX=portable/ooRexx-5.1.0-portable -P cmake_install.cmake

exit

if  [ "$1". == "save".  ] ; then
  if  test -f ${IM} ; then
    mv ${IM} ${IM}.bak
    echo "## ${IM} saved to ${IM}.bak "
  else
    echo "## ${IM} not found "
  fi
  exit
fi

if  [ "$1". == "restore".  ] ; then
  if  test -f ${IM}.bak ; then
    mv ${IM}.bak ${IM}
    echo "## ${IM}.bak restored to ${IM} "
  else
    echo "## ${IM}.bak not found "
  fi
  exit
fi

exit
