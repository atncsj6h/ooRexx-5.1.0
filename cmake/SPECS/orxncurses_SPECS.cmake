#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( common_orxncurses_SRCS
  ${extensions_orxncurses_dir}/orxncurses.cpp
)

# additional source files required by specific platforms
set( platform_orxncurses_SRCS
)

# Include file definition
set( orxncurses_include_DIRS
  ${api_dir}
  ${api_platform_dir}
  ${extensions_orxncurses_dir}
  ${CURSES_INCLUDE_DIRS}
)

# link library definitions
set( common_orxncurses_LIBS
  rexx rexxapi )

set( platform_orxncurses_LIBS
  ${CURSES_LIBRARIES}
)

set( orxncurses_pragma_DIAG
)
