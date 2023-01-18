#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
include_guard( GLOBAL )

include( dirnames )

# the public headers
set( ooRexx_HDRS
  ${api_dir}/oorexxapi.h
  ${api_dir}/oorexxerrors.h
  ${api_dir}/rexx.h
  ${api_dir}/rexxapidefs.h
  ${api_platform_dir}/rexxapitypes.h
  ${api_platform_dir}/rexxplatformapis.h
  ${api_platform_dir}/rexxplatformdefs.h
)
