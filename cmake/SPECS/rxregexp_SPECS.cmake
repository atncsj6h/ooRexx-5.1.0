#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( rxregexp_SRCS
  ${extensions_rxregexp_dir}/automaton.cpp
  ${extensions_rxregexp_dir}/dblqueue.cpp
  ${extensions_rxregexp_dir}/rxregexp.cpp )

# Include file definition
set( rxregexp_include_DIRS
  ${internals_dir}
  ${api_dir}
  ${api_platform_dir}
  ${messages_dir}
)

# library definitions
set( rxregexp_LIBS
  rexx rexxapi )

