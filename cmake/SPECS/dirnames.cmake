#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# shortened ( relatively ) subdirectory names
set( common_dir common )
set( common_platform_dir ${common_dir}/platform/${PLATFORM} )
set( internals_dir internals )
set( platform_dir platform/${PLATFORM} )
set( rexxapi_dir rexxapi )
set( rexxapi_client_dir ${rexxapi_dir}/client )
set( rexxapi_client_platform_dir ${rexxapi_client_dir}/platform/${PLATFORM} )
set( rexxapi_common_dir ${rexxapi_dir}/common )
set( rexxapi_common_platform_dir ${rexxapi_common_dir}/platform/${PLATFORM} )
set( rexxapi_server_dir ${rexxapi_dir}/server )
set( rexxapi_server_platform_dir ${rexxapi_server_dir}/platform/${PLATFORM} )
set( interpreter_dir interpreter )
set( interpreter_platform_dir ${interpreter_dir}/platform/${PLATFORM} )
set( interpreter_api_dir ${interpreter_dir}/api )
set( behaviour_dir ${interpreter_dir}/behaviour )
set( classes_dir ${interpreter_dir}/classes )
set( classes_support_dir ${interpreter_dir}/classes/support )
set( concurrency_dir ${interpreter_dir}/concurrency )
set( execution_dir ${interpreter_dir}/execution )
set( expression_dir ${interpreter_dir}/expression )
set( instructions_dir ${interpreter_dir}/instructions )
set( memory_dir ${interpreter_dir}/memory )
set( messages_dir ${interpreter_dir}/messages )
set( package_dir ${interpreter_dir}/package )
set( parser_dir ${interpreter_dir}/parser )
set( interpreter_common_dir ${interpreter_dir}/platform/common )
set( rexx_classes_dir ${interpreter_dir}/RexxClasses )
set( runtime_dir ${interpreter_dir}/runtime )
set( streamlibrary_dir ${interpreter_dir}/streamLibrary )
set( extensions_dir extensions )
set( extensions_platform_dir ${extensions_dir}/platform/${PLATFORM} )
set( extensions_rxftp_dir ${extensions_dir}/rxftp )
set( extensions_csvstream_dir ${extensions_dir}/csvStream )
set( extensions_json_dir ${extensions_dir}/json )
set( extensions_dateparser_dir ${extensions_dir}/dateparser )

set( extensions_rxmath_dir ${extensions_dir}/rxmath )

set( extensions_rxregexp_dir ${extensions_dir}/rxregexp )

set( extensions_rxsock_dir ${extensions_dir}/rxsock )

set( extensions_rxunixsys_dir ${extensions_platform_dir}/rxunixsys )

set( extensions_rxncurses_dir ${extensions_dir}/rxncurses )
set( extensions_orxncurses_dir ${extensions_dir}/orxncurses )

set( extensions_hostemu_dir ${extensions_dir}/hostemu )
set( extensions_hostemu_platform_dir ${extensions_hostemu_dir}/platform/${PLATFORM} )

set( executables_dir executables )
set( executables_rexx_dir ${executables_dir}/rexx/platform/${PLATFORM} )
set( executables_rexxc_dir ${executables_dir}/rexxc/platform/${PLATFORM} )
set( executables_rexximage_dir ${executables_dir}/rexximage )
set( executables_rxqueue_dir ${executables_dir}/rxqueue/platform/${PLATFORM} )
set( executables_rxsubcom_dir ${executables_dir}/rxsubcom/platform/${PLATFORM} )

set( api_dir api )
set( api_platform_dir api/platform/${PLATFORM} )

set( samples_dir samples )
set( support_dir support )

set(SAMPLES_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/${samples_dir} )
