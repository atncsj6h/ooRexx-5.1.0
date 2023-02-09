#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( rxunixsys_SRCS
  ${extensions_rxunixsys_dir}/rxunixsys.cpp
)

# Include file definition
set( rxunixsys_include_DIRS
  ${api_dir}
  ${api_platform_dir}
  extensions_rxunixsys_dir
)

# link library definitions
set( rxunixsys_LIBS
  rexx rexxapi
)
