#   README
*
* a minimal Open Object Rexx distribution
* Linux, Darwin, Freebsd, OpenBSD only
* NO Windows, AIX, SUN, HAIKU, zOS
* * *

##  COPYRIGHT
*
* the original software
* is copyright of the original owners under the original licence
* see:
* `https://svn.code.sf.net/p/oorexx/code-0/main/trunk`
* `https://svn.code.sf.net/p/oorexx/code-0/test/trun`
*
* source code changes are dedicated to the public domain
*
* the cmake infrastructure is
* Copyright (c) 2019, 2020 Enrico Sorichetti
* Distributed under the Boost Software License, Version 1.0.
* See accompanying file `LICENSE_1_0.txt` or copy at
* `[http://www.boost.org/LICENSE_1_0.txt](http://www.boost.org/LICENSE_1_0.txt)`
* * *

##  REPOSITORY
*
* `https://github.com/atncsj6h/ooRexx.git`
* `git@github.com:atncsj6h/ooRexx.git`
* * *


##  prerequisites
*   cmake ( minimum 3.12 )
*   clang ( will not work with gcc ! )
*   bison
*   they can be installed using the system package manager
*   Or downloaded from
*   sources
*       https://cmake.org/download/
*       https://ftp.gnu.org/gnu/bison/
*   binaries
*       https://releases.llvm.org/download.html
* * *
##  PREREQUISITES
*
* cmToolKit
* at `https://github.com/atncsj6h/cmToolKit.git`
* or `git@github.com:atncsj6h/cmToolKit.git`
*
* cmake at least 3.20
* at `https://cmake.org/download/`
*
* clang
*
* bison
*
* pkgconf
* at `https://github.com/pkgconf/pkgconf/releases`
* * *

##  NICE TO HAVE
*
* ccache to speed up builds
* at `https://github.com/ccache/ccache/releases`
*
* ninja, a make alternative
* at `https://github.com/ninja-build/ninja/releases`
* * *

##  How to ( my setup )
*   naming convention and layout
*   <somewhere>/ooRexx.git
*   <somewhere>/ooRexx.git.build
*   <somewhere>/ooRexx
*   ( the <somewhere>/ooRexx/bin directory should be appended to the PATH )
*
* cd <somewhere>
* git clone ... ooRexx.git
* mkdir ooRexx.git.build
*
* cd ooRexx.git.build
* `_cmake`
* `REXX_PATH=``pwd``/bin make`
* `REXX_PATH=``pwd``/bin make install`
* * *

##  Additional considerations
*
* * *

##  tested and working on
*   APPLE El Capitan
*   APPLE High Sierra
*   APPLE Mojave
*   Fedora 31
*   Centos 8
*   FreeBSD 12.1
*   FreeBSD 13.0
*   OpenBSD 6 ( work in progress )
* * *

##  NOTES
*   [Markdown Information](https://bitbucket.org/tutorials/markdowndemo)
* * *


