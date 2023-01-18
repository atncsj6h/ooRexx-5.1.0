#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( common_rxunixsys_SRCS
)

# files required by specific platforms
set( platform_rxunixsys_SRCS
  ${extensions_platform_dir}/rxunixsys/rxunixsys.cpp
)

# Include file definition
set( rxunixsys_include_DIRS
  ${api_dir}
  ${api_platform_dir}
  ${extensions_platform_dir}/rxunixsys
)

# link library definitions
set( common_rxunixsys_LIBS
  rexx rexxapi
)

set( platform_rxunixsys_LIBS
)

set( rxunixsys_pragma_DIAG
)
