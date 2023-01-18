#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

set( rxsubcom_exe_SRCS
  ${utilities_rxsubcom_dir}/rxsubcom.cpp
)

# Include file definition
set( rxsubcom_exe_include_DIRS
  ${lib_dir}
  ${api_dir}
  ${api_platform_dir}
  ${interpreter_platform_dir}
  ${messages_dir}
)

# link library definitions
set( rxsubcom_exe_LIBS
  rexx rexxapi
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rxsubcom_pragma_DIAG
)
