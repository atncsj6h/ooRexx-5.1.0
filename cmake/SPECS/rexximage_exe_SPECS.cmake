#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

set( rexximage_exe_SRCS
  ${executables_rexximage_dir}/rexximage.cpp
)

# Include file definition
set( rexximage_exe_include_DIRS
  ${internals_dir}
  ${api_dir}
  ${api_platform_dir}
)

# link library definitions
set( rexximage_exe_LIBS
  rexx rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rexximage_exe_pragma_DIAG
)

