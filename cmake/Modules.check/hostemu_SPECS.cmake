#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

include( dirnames )
# common files for all platforms.

set( hostemu_SRCS
  ${BISON_cmdparse_OUTPUT_SOURCE}
  ${extensions_hostemu_platform_dir}/hostemu.cpp
)

# Include file definition
set( hostemu_include_DIRS
  ${api_dir}
  ${api_platform_dir}
  ${extensions_hostemu_dir}
)

# link library definitions
set( hostemu_LIBS
  rexx rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)

set( hostemu_pragma_DIAG
  writable-strings
  write-strings
)
