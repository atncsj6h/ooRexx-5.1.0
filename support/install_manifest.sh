#!/bin/sh


IM="install_manifest.txt"

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
