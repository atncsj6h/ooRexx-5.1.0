#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( common_rxmath_SRCS
  ${extensions_rxmath_dir}/rxmath.cpp
)

# files required by specific platformss
set( platform_rxmath_SRCS
)

# Include file definition
set( rxmath_include_DIRS
  ${lib_dir}
  ${api_dir}
  ${api_platform_dir}
)

# link library definitions
set( common_rxmath_LIBS
  rexx rexxapi )

set( platform_rxmath_LIBS
)

set( rxmath_pragma_DIAG
)
