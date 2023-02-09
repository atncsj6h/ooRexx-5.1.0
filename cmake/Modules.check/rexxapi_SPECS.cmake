#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# Full set of files used in all platforms.
set( common_rexxapi_SRCS
  ${rexxapi_client_dir}/ClientMessage.cpp
  ${rexxapi_client_dir}/LocalAPIContext.cpp
  ${rexxapi_client_dir}/LocalAPIManager.cpp
  ${rexxapi_client_dir}/LocalMacroSpaceManager.cpp
  ${rexxapi_client_dir}/LocalQueueManager.cpp
  ${rexxapi_client_dir}/LocalRegistrationManager.cpp
  ${rexxapi_client_dir}/MacroSpaceApi.cpp
  ${rexxapi_client_dir}/QueuesAPI.cpp
  ${rexxapi_client_dir}/RegistrationAPI.cpp
  ${rexxapi_client_platform_dir}/SysLegacyAPI.cpp
  ${rexxapi_client_platform_dir}/SysLocalAPIManager.cpp
  ${rexxapi_common_dir}/RegistrationTable.cpp
  ${rexxapi_common_dir}/ServiceMessage.cpp
  ${rexxapi_common_dir}/CSStream.cpp
  ${rexxapi_common_platform_dir}/SysAPIManager.cpp
  ${common_dir}/Utilities.cpp
  ${common_platform_dir}/SysSemaphore.cpp
  ${common_platform_dir}/SysLibrary.cpp
  ${common_platform_dir}/SysFile.cpp
  ${common_platform_dir}/SysProcess.cpp
  ${common_platform_dir}/SysThread.cpp
)

# additional source files required by specific platforms
set( platform_rexxapi_SRCS
  ${rexxapi_common_platform_dir}/SysCSStream.cpp
)

set( rexxapi_SRCS
  ${common_rexxapi_SRCS}
  ${platform_rexxapi_SRCS}
)


# Include file definition
set( rexxapi_include_DIRS
  ${rexxapi_client_dir}
  ${rexxapi_client_platform_dir}
  ${rexxapi_common_dir}
  ${rexxapi_common_platform_dir}
  ${common_dir}
  ${common_platform_dir}
  ${internals_dir}
)

# link library definitions
set( common_rexxapi_LIBS )

set( platform_rexxapi_LIBS
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rexxapi_pragma_DIAG )
