#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( common_rxncurses_SRCS
  ${extensions_rxncurses_dir}/rxncurses.cpp
)

# files required by specific platforms
set( platform_rxncurses_SRCS
)

# Include file definition
set( rxncurses_include_DIRS
  ${api_dir}
  ${api_platform_dir}
  ${extensions_rxncurses_dir}
  ${CURSES_INCLUDE_DIRS}
)

# link library definitions
set( common_rxncurses_LIBS
  rexx rexxapi )

set( platform_rxncurses_LIBS
  ${CURSES_LIBRARIES}
)

set( rxncurses_pragma_DIAG
)
