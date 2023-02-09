#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

set( rxqueue_exe_SRCS
  ${executables_rxqueue_dir}/rxqueue.cpp
)

# Include file definition
set( rxqueue_exe_include_DIRS
  ${internals_dir}
  ${api_dir}
  ${api_platform_dir}
  ${interpreter_platform_dir}
  ${messages_dir}
)

# link library definitions
set( rxqueue_exe_LIBS
  rexx rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rxqueue_pragma_DIAG
)
