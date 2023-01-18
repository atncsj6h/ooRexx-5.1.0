#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

# common files for all platforms.
set( common_rxapi_exe_SRCS
  ${rexxapi_server_dir}/APIServer.cpp
  ${rexxapi_server_dir}/APIServerInstance.cpp
  ${rexxapi_server_dir}/APIServerThread.cpp
  ${rexxapi_server_dir}/MacroSpaceManager.cpp
  ${rexxapi_server_dir}/QueueManager.cpp
  ${rexxapi_server_dir}/RegistrationManager.cpp
  ${rexxapi_common_dir}/CSStream.cpp
  ${rexxapi_common_dir}/RegistrationTable.cpp
  ${rexxapi_common_dir}/ServiceMessage.cpp
  ${rexxapi_common_platform_dir}/SysAPIManager.cpp
  ${common_dir}/Utilities.cpp
  ${common_platform_dir}/SysProcess.cpp
  ${common_platform_dir}/SysSemaphore.cpp
  ${common_platform_dir}/SysThread.cpp
)

# files required by specific platforms
set( platform_rxapi_exe_SRCS
  ${rexxapi_common_platform_dir}/SysCSStream.cpp
  ${rexxapi_server_platform_dir}/APIService.cpp
)

set( rxapi_exe_SRCS
  ${common_rxapi_exe_SRCS}
  ${platform_rxapi_exe_SRCS}
)

# Include file definition
set( rxapi_exe_include_DIRS
  ${common_platform_dir}
  ${common_dir}
  ${rexxapi_common_platform_dir}
  ${rexxapi_common_dir}
  ${rexxapi_server_dir}
)

# link library definitions
set( rxapi_exe_LIBS
  ${LIBDL}
  ${LIBPTHREAD}
)

set( rxapi_exe_pragma_DIAG
)



