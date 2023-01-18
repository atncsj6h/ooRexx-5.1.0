#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( common_rxsock_SRCS
  ${extensions_rxsock_dir}/rxsock.cpp
  ${extensions_rxsock_dir}/rxsockfn.cpp
)

# iles required by specific platforms
set( platform_rxsock_SRCS
)

# Include file definition
set( rxsock_include_DIRS
  ${lib_dir}
  ${api_dir}
  ${api_platform_dir}
)

# link library definitions
set( common_rxsock_LIBS
  rexx rexxapi )

set( platform_rxsock_LIBS
  ${LIBSOCKET}
)

set( rxsock_pragma_DIAG
)
