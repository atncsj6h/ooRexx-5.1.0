#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

set( rexxc_exe_SRCS
  ${executables_rexxc_dir}/RexxCompiler.cpp
)

# Include file definition
set( rexxc_exe_include_DIRS
  ${internals_dir}
  ${api_dir}
  ${api_platform_dir}
  ${messages_dir}
)

# link library definitions
set( rexxc_exe_LIBS
  rexx rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rexxc_exe_pragma_DIAG
)


