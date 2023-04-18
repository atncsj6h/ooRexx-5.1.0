#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

set( rexx_exe_SRCS
  ${executables_rexx_dir}/rexx.cpp
)

# Include file definition
set( rexx_exe_include_DIRS
  ${internals_dir}
  ${api_dir}
  ${api_platform_dir}
  ${common_dir}
  ${messages_dir}
)

# link library definitions
set( rexx_exe_LIBS
  rexx rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rexx_exe_pragma_DIAG
)

