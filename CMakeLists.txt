#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2022, 2023 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message( STATUS "CMake version  '${CMAKE_VERSION}'" )
message( STATUS "Processing     '${CMAKE_CURRENT_LIST_FILE}'" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( CMAKE_VERSION VERSION_LESS  3.25 )
  message( FATAL_ERROR "
 CMake '3.25' or higher is required,
 You are running '${CMAKE_VERSION}'" )
endif()
cmake_minimum_required( VERSION ${CMAKE_VERSION} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if( NOT DEFINED ENV{CMTK} )
  message( FATAL_ERROR "
 unable to locate the cmToolKit directory" )
endif()

set( CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR} )
list( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/SPECS )
list( APPEND CMAKE_MODULE_PATH $ENV{CMTK}/cmake/Modules )

set( TEMPL_SOURCE_PATH ${CMAKE_SOURCE_DIR} )
list( APPEND TEMPL_SOURCE_PATH ${CMAKE_SOURCE_DIR}/cmake/TEMPL )
list( APPEND TEMPL_SOURCE_PATH $ENV{CMTK}/cmake/Templates )

include( vDump )
include( vDrop )
include( vSnap )
# set( VSNAP TRUE )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# deprecate 'in-source' builds ( source directory/subdirectories )
# if You accidentally try an 'in-source' build
# You will have to manually clean up the leftovers :
# file 'CMakeCache.txt' and directory 'CMakeFiles'

set( CMAKE_DISABLE_IN_SOURCE_BUILD ON )
set( CMAKE_DISABLE_SOURCE_CHANGES  ON )

get_filename_component( _s "${CMAKE_SOURCE_DIR}" REALPATH )
string( TOLOWER "${_s}" _s )

get_filename_component( _b "${CMAKE_BINARY_DIR}" REALPATH )
string( TOLOWER "${_b}" _b )

if( ( "${_b}" STREQUAL "${_s}" ) OR
    ( "${_b}" MATCHES  "${_s}/" ) )
  message( FATAL_ERROR "
 binary directory '${CMAKE_BINARY_DIR}'
 source directory '${CMAKE_SOURCE_DIR}'
 builds that modify the source directory/subdirectories are not allowed,
 remove file 'CMakeCache.txt' and directory 'CMakeFiles' " )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# must come before the project command
# lowest macOS supported 10.13.6 High Sierra
if( APPLE AND BUILD_OSX_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_DEPLOYMENT_TARGET 10.13.6 CACHE STRING  "" FORCE)
  add_compile_options( -Wunguarded-availability )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( PROJECT ooRexx )
set( VERSION  5 )
set( RELEASE  1 )
set( MODLEVL  0 )
# let's set the revision/BLDLEVL to 0 for now
# will deal later with that for different SCMs ( subverion/git )
set( BLDLEVL  0 )

set( VERSION_TRIPLET "${VERSION}.${RELEASE}.${MODLEVL}" )
set( EXENAME rexx )
set( SOVERSION 4 )
set( PLATFORM unix )
set( DESCRIPTION "Open Object Rexx interpreter and libraries." )
set( PROVIDES rexx rexxapi )
set( REQUIRES )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
project( ${PROJECT}
  VERSION ${VERSION_TRIPLET}
  LANGUAGES C CXX
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# check if the required libraries are available
# and terminate if not
include( pkgConfig )
pkg_config( ${REQUIRES} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION ON )
set( CPACK_WARN_ON_ABSOLUTE_INSTALL_DESTINATION ON )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# system name
set( SYSTEM_NAME "${CMAKE_SYSTEM_NAME}" )
string( TOUPPER "${SYSTEM_NAME}" SYSTEM_NAME_UC )
set( "${SYSTEM_NAME_UC}" 1 )
add_compile_definitions(
  SYSTEM_NAME="${SYSTEM_NAME}"
  SYSTEM_NAME_UC="${SYSTEM_NAME_UC}"
  ${SYSTEM_NAME_UC}
)

# processor
set( SYSTEM_PROCESSOR "${CMAKE_SYSTEM_PROCESSOR}" )
string( TOUPPER "${SYSTEM_PROCESSOR}" SYSTEM_PROCESSOR )
set( "${SYSTEM_PROCESSOR}" 1 )
add_compile_definitions(
  ${SYSTEM_PROCESSOR}
  SYSTEM_PROCESSOR="${CMAKE_SYSTEM_PROCESSOR}"
)

# architecture
math( EXPR arch  "8 * ${CMAKE_SIZEOF_VOID_P}" OUTPUT_FORMAT DECIMAL)
if( NOT ( CMAKE_SIZEOF_VOID_P MATCHES 8 ) )
  message( WARNING "
 likely unsupported Architecture '${arch}-bits'" )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( VERSION_STRING "${VERSION_TRIPLET}" )
set( VERSION_STRING "${VERSION_STRING}-${CMAKE_SYSTEM_PROCESSOR}" )

if( APPLE AND BUILD_OSX_UNIVERSAL_BINARIES )
  set( CMAKE_OSX_ARCHITECTURES arm64 x86_64 )
  set( VERSION_STRING "${VERSION_STRING}-universal" )
endif()


add_compile_definitions(
  VERSION=${VERSION}
  RELEASE=${RELEASE}
  MODLEVL=${MODLEVL}
  BLDLEVL=${BLDLEVL}
  VERSION_TRIPLET="${VERSION_TRIPLET}"
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
string( TIMESTAMP COPYRIGHT_YEAR %Y )
set( COPYRIGHT_TIMESPAN "2005, ${COPYRIGHT_YEAR}" )
add_compile_definitions(
  COPYRIGHT_YEAR="${COPYRIGHT_YEAR}"
  COPYRIGHT_TIMESPAN="${COPYRIGHT_TIMESPAN}"
)

string( TIMESTAMP BUILD_DATE "%d %b %Y" )
string( TIMESTAMP BUILD_TIME "%H:%M:%S" )
string( TIMESTAMP BUILD_TIMESTAMP %Y/%m/%d-%H:%M:%S )
set( BUILD_SYSTEM ${CMAKE_SYSTEM} )
add_compile_definitions(
  BUILD_DATE="${BUILD_DATE}"
  BUILD_SYSTEM="${BUILD_SYSTEM}"
  BUILD_TIMESTAMP="${BUILD_TIMESTAMP}"
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# additional compiler flags
add_compile_options( -fomit-frame-pointer )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup the installation paths according to the GNU standards
include( GNUInstallDirs )

set( WELL_KNOWN_PREFIX_LIST
  /usr /usr/local
  /opt /opt/local
  $ENV{HOME}/GNULayout )
vsnap( WELL_KNOWN_PREFIX_LIST )
if( "${CMAKE_INSTALL_PREFIX}" IN_LIST WELL_KNOWN_PREFIX_LIST )
  set( WELL_KNOWN_PREFIX 1 )
else()
  get_filename_component( _we  "${CMAKE_INSTALL_PREFIX}" NAME_WE )
  get_filename_component( _wle "${CMAKE_INSTALL_PREFIX}" NAME_WLE )
  vsnap( CMAKE_INSTALL_PREFIX _we _wle )
endif( )

include( installDirectories )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${INST_BIN_DIR} )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${INST_LIB_DIR} )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${INST_LIB_DIR} )
set( CMAKE_REXXIMG_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${INST_LIB_DIR} )
set( CMAKE_SAMPLES_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/samples )

set( INST_CLASSES "${INST_BIN_DIR}" )
set( INST_REXXIMG "${INST_LIB_DIR}" )

vsnap( INST_DATADIR )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# short source directory names
include( dirNames )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# To ensure the required libraries are always found, regardless of whether
# executables are run directly from the build tree or after installation, we
# use settings similar to what is suggested in "Always full RPATH" at:
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/RPATH-handling

# use (i.e. don't skip) the full RPATH for the build tree
set( CMAKE_SKIP_BUILD_RPATH FALSE )

# when building, don't use the installation RPATH already (only later when installing)
set( CMAKE_BUILD_WITH_INSTALL_RPATH FALSE )

if ( APPLE )
  set( CMAKE_INSTALL_RPATH "@executable_path/../${CMAKE_INSTALL_LIBDIR}" )
else()
  # using $ORIGIN/.. instead of ${CMAKE_INSTALL_PREFIX} allows the package
  # to be relocated during installation, but this comes at a cost: we can't
  # be sure that all platforms we intend to run on really support $ORIGIN
  set( CMAKE_INSTALL_RPATH "$ORIGIN/../${CMAKE_INSTALL_LIBDIR}" )
endif()

# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the installation RPATH
set( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( CMAKE_C_STANDARD 11 )
set( CMAKE_C_STANDARD_REQUIRED YES )
set( CMAKE_CXX_STANDARD 11 )
set( CMAKE_CXX_STANDARD_REQUIRED YES )

set( CMAKE_POSITION_INDEPENDENT_CODE ON)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
option( WITH_CCACHE "" ON )
if( WITH_CCACHE )
  unset( CCACHE )
  unset( CCACHE CACHE )
  include( ccache )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
option( WITH_IPO "" ON )
if( WITH_IPO )
  include( CheckIPOSupported )
  check_ipo_supported( RESULT HAVE_IPO_SUPPORT )
  if ( HAVE_IPO_SUPPORT )
    message( STATUS "IPO is supported and enabled" )
  endif()
endif()


#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# do not rely on the system name/family
include( needLibCrypt )
include( needLibDl )
include( needLibM )
include( needLibNsl )
include( needLibPthread )
include( needLibResolv )
include( needLibRt )
include( needLibSocket )

# double check
include( CheckLibraryExists )
check_library_exists(nsl    gethostbyname   "" ZZ_HAVE_LIBNSL)
check_library_exists(resolv hstrerror       "" ZZ_HAVE_LIBRESOLV)
check_library_exists(rt     nanosleep       "" ZZ_HAVE_LIBRT)
check_library_exists(socket getaddrinfo     "" ZZ_HAVE_LIBSOCKET)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#headers
include( CheckIncludeFile )
include( checkHeader )

# we assume that the system has the ISO/IEC headers and terminate if not
# the ISO headers will not be guarded
include( isoHeaders )

# the other systems headers ( guarded )
include( sysHeaders )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# functions
include( CheckFunctionExists )
include( checkFunction )

include( sysFunctions )

# direct call to avoid the double underscore in the guard macro
check_function_exists( _NSGetEnviron HAVE_NSGETENVIRON )
check_function_exists( _NSGetExecutablePath HAVE_NSGETEXECUTABLEPATH )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( CheckFunctionExists )
check_function_exists( pathconf HAVE_PATHCONF )

if( HAVE_PATHCONF AND
    HAVE_PC_NAME_MAX AND
    HAVE_PC_PATH_MAX AND
    HAVE_PC_XATTR_SIZE_BITS )
  include( pathconf )
  pathconf( "_PC_PATH_MAX" )
  pathconf( "_PC_NAME_MAX" )
  pathconf( "_PC_XATTR_SIZE_BITS" )
  vSnap( "PC_PATH_MAX" "PC_NAME_MAX" "PC_XATTR_SIZE_BITS" )
else()
  set( PC_PATH_MAX 1024 )
  set( PC_NAME_MAX 255 )
  set( PC_XATTR_SIZE_BITS 16 )
endif()

add_compile_definitions(
  PC_PATH_MAX=${PC_PATH_MAX}
  PC_NAME_MAX=${PC_NAME_MAX}
  PC_XATTR_SIZE_BITS=${PC_XATTR_SIZE_BITS}
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( CheckFunctionExists )
check_function_exists( sysconf HAVE_SYSCONF )
if( HAVE_SYSCONF AND
    HAVE_SC_HOST_NAME_MAX AND
    HAVE_SC_LOGIN_NAME_MAX )
    include( sysconf )
    sysconf( "_SC_HOST_NAME_MAX" )
    sysconf( "_SC_LOGIN_NAME_MAX" )
    vSnap( "SC_HOST_NAME_MAX"  "SC_LOGIN_NAME_MAX")
else( )
    set( SC_HOST_NAME_MAX 255 )
    set( SC_LOGIN_NAME_MAX 255 )
endif( )
add_compile_definitions(
  SC_HOST_NAME_MAX=${SC_HOST_NAME_MAX}
  SC_LOGIN_NAME_MAX=${SC_LOGIN_NAME_MAX}
)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# symbols
include( CheckSymbolExists )

check_symbol_exists(_PC_CASE_SENSITIVE unistd.h HAVE_PC_CASE_SENSITIVE)
check_symbol_exists(FNM_CASEFOLD fnmatch.h HAVE_FNM_CASEFOLD)
check_symbol_exists(KDMKTONE linux/kd.h HAVE_KDMKTONE)
check_symbol_exists(FS_CASEFOLD_FL linux/fs.h HAVE_FS_CASEFOLD_FL)
check_symbol_exists(KERN_PROC_PATHNAME "sys/types.h;sys/sysctl.h" HAVE_KERN_PROC_PATHNAME)
check_symbol_exists(KERN_PROC_ARGV "sys/types.h;sys/sysctl.h" HAVE_KERN_PROC_ARGV)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# structures
include(CheckStructHasMember)

check_struct_has_member( "struct stat" st_mtim sys/stat.h HAVE_STAT_ST_MTIM )
check_struct_has_member( "struct stat" st_mtimespec sys/stat.h HAVE_STAT_ST_MTIMESPEC )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( checkPragmaDiagnostics )
check_pragma_diagnostics( "deprecated-declarations" )
check_pragma_diagnostics( "writable-strings" )
check_pragma_diagnostics( "write-strings" )
check_pragma_diagnostics( "stringop-overflow" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_directories( ${CMAKE_BINARY_DIR} )
include_directories(BEFORE api api/${platform_dir})

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
add_compile_definitions(
  SHARED_LIBRARY_PREFIX="${CMAKE_SHARED_LIBRARY_PREFIX}"
  SHARED_LIBRARY_SUFFIX="${CMAKE_SHARED_LIBRARY_SUFFIX}"
  )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# public headers
include( dirNames )
include( buildLibraries )

include( ${PROJECT}_HDRS )
build_headers( ${PROJECT} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# libraries
include( dirNames )
include( buildLibraries )

set( LIBRARIES rexxapi rexx )

foreach( X ${LIBRARIES} )
  include( ${X}_SPECS )
  build_objects( ${X} )
  build_shared_library( ${X} )
endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# executables
include( dirNames )
include( buildExecutables )

set( SUFF _exe )
set( EXECUTABLES rexx rexxc rexximage rxapi rxqueue rxsubcom )

foreach( X ${EXECUTABLES} )
  include( ${X}${SUFF}_SPECS )
  build_executable( ${X} )
endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the rexx image
macro( copy_image_classes origin name )
  ADD_CUSTOM_COMMAND(
    OUTPUT ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/${name}
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
      ${CMAKE_SOURCE_DIR}/${origin}/${name}
      ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/${name}
      DEPENDS ${origin}/${name} )
endmacro( copy_image_classes )

copy_image_classes( ${rexx_classes_dir} CoreClasses.orx      )
copy_image_classes( ${rexx_classes_dir} StreamClasses.orx    )
copy_image_classes( ${interpreter_platform_dir} PlatformObjects.orx  )

set( image_class_files
  ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/CoreClasses.orx
  ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/StreamClasses.orx
  ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/PlatformObjects.orx )

add_custom_command( OUTPUT ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/rexx.img
  COMMAND $<TARGET_FILE:rexximage_exe> ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/rexx.img
  DEPENDS rexximage_exe rxapi_exe ${image_class_files}
  WORKING_DIRECTORY ${CMAKE_REXXIMG_OUTPUT_DIRECTORY} )

add_custom_target( rexx_img ALL
  DEPENDS ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/rexx.img )

install( PROGRAMS ${CMAKE_REXXIMG_OUTPUT_DIRECTORY}/rexx.img
  DESTINATION ${INST_REXXIMG} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Licenses and Notices
macro( install_NOTICES argv )
  install( FILES ${argv}
    DESTINATION ${INST_DATADIR}/NOTICES
    PERMISSIONS OWNER_READ OWNER_WRITE
                GROUP_READ
                WORLD_READ )

endmacro( install_NOTICES )

install_NOTICES( ${CMAKE_SOURCE_DIR}/README.md )

install_NOTICES( ${CMAKE_SOURCE_DIR}/CPLv1.0.txt  )
install_NOTICES( ${CMAKE_SOURCE_DIR}/BOOST_LICENSE_1.0.txt )

install_NOTICES( ${CMAKE_SOURCE_DIR}/CHANGES-ooRexx ${CMAKE_SOURCE_DIR} )
install_NOTICES( ${CMAKE_SOURCE_DIR}/CHANGES-this ${CMAKE_SOURCE_DIR} )
install_NOTICES( ${CMAKE_SOURCE_DIR}/HOWTO-this ${CMAKE_SOURCE_DIR} )
install_NOTICES( ${CMAKE_SOURCE_DIR}/NOTICE-ooRexx ${CMAKE_SOURCE_DIR} )
install_NOTICES( ${CMAKE_SOURCE_DIR}/NOTICE-this ${CMAKE_SOURCE_DIR} )
install_NOTICES( ${CMAKE_SOURCE_DIR}/USAGE-this ${CMAKE_SOURCE_DIR} )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the support files

# generic macro to install files as executables
macro( install_X argv )
  install( FILES ${CMAKE_SOURCE_DIR}/${argv}
    DESTINATION ${INST_BIN_DIR}
    PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
                GROUP_EXECUTE GROUP_READ
                WORLD_EXECUTE WORLD_READ )
endmacro( install_X )

# recommended
set( CLASSES
  ${extensions_dateparser_dir}/dateparser.cls
  ${extensions_rxregexp_dir}/rxregexp.cls
  ${extensions_csvstream_dir}/csvStream.cls
  ${extensions_json_dir}/json.cls )

foreach( X ${CLASSES} )
  install_X( ${X} )
endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# manpages
macro( install_manpage page indx )
  install( FILES ${platform_dir}/${page}.${indx}
    DESTINATION ${INST_MAN_DIR}/man${indx}
    PERMISSIONS OWNER_READ OWNER_WRITE
                GROUP_READ
                WORLD_READ )
endmacro( install_manpage )

install_manpage( rexx 1 )
install_manpage( rexxc 1 )
install_manpage( rxqueue 1 )
install_manpage( rxsubcom 1 )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# documentation
if( DOCDIR )
  macro( install_manual PDF )
    install( FILES ${DOCDIR}/${PDF}.pdf
      DESTINATION ${INST_DOC_DIR}
      PERMISSIONS OWNER_READ OWNER_WRITE
                  GROUP_READ
                  WORLD_READ )
  endmacro( install_manual )
  foreach( X readme rexxapi rexxextensions rexxpg rexxref )
    install_manual( ${X} )
  endforeach()

endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the support files
foreach( X path.here path.append path.remove portable-startup.sh )
  install_X( ${support_dir}/bin/${X} )
endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the samples
install( DIRECTORY samples
  DESTINATION ${INST_DATADIR}
  PATTERN "api" EXCLUDE
  PATTERN "windows" EXCLUDE
  PATTERN "*.windows" EXCLUDE
  PATTERN "CMakeLists.*" EXCLUDE
  PATTERN "*.rex"
  PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  PATTERN "*.cls"
  PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  )
# technically samples, but nice to have in the binary dir
foreach( X rexxtry.rex rexxcps.rex )
  install_X( ${samples_dir}/${X} )
endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the api samples
install( DIRECTORY samples/api/c++
  DESTINATION ${INST_DATADIR}/apisamples
  PATTERN "windows" EXCLUDE
  PATTERN "*.windows" EXCLUDE
  PATTERN "CMakeLists.*" EXCLUDE
  PATTERN "*.rex"
  PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  PATTERN "*.cls"
  PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  )

install( DIRECTORY samples/api/classic
  DESTINATION ${INST_DATADIR}/apisamples
  PATTERN "windows" EXCLUDE
  PATTERN "*.windows" EXCLUDE
  PATTERN "CMakeLists.*" EXCLUDE
  PATTERN "*.rex"
  PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  PATTERN "*.cls"
  PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
              GROUP_EXECUTE GROUP_READ
              WORLD_EXECUTE WORLD_READ
  )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the external libraries
include( dirNames )
include( buildLibraries )

#
set( EXTERNAL hostemu rxregexp )

option( BISON "" ON)
if( BISON )
  find_package( BISON )
  if( COMMAND bison_target )
    bison_target( cmdparse
      ${extensions_hostemu_dir}/cmdparse.ypp
      ${CMAKE_BINARY_DIR}/cmdparse.cpp
      COMPILE_FLAGS -l )
  else()
    set( BISON_cmdparse_OUTPUT_SOURCE ${extensions_hostemu_dir}/cmdparse.cpp )
  endif()
else()
  set( BISON_cmdparse_OUTPUT_SOURCE ${extensions_hostemu_dir}/cmdparse.cpp )
endif()

foreach( X ${EXTERNAL} )
  include( ${X}_SPECS )
  build_objects( ${X} )
  build_shared_library( ${X} )
endforeach()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# the configuration files
include( configureTemplates )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
configure_templates( config.h isohdrs.h )
if( HAVE_CONFIG_H )
  add_compile_definitions( HAVE_CONFIG_H )
endif()
if( HAVE_ISOHDRS_H )
  add_compile_definitions( HAVE_ISOHDRS_H )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set( INST_LIBS "")
foreach( library  ${PROVIDES} )
  set( INST_LIBS "${INST_LIBS}-l${library} " )
endforeach()
string( STRIP "${INST_LIBS}" INST_LIBS )
vsnap( INST_LIBS )

configure_template( pkgconfig.pc.in ooRexx.pc)
if( HAVE_OOREXX_PC )
  install( FILES ${CMAKE_BINARY_DIR}/ooRexx.pc
    DESTINATION ${INST_LIB_DIR}/pkgconfig )
endif()

configure_template( pkgconfig.sh.in ooRexx-config )
if( HAVE_OOREXX_CONFIG )
  install( FILES ${CMAKE_BINARY_DIR}/ooRexx-config
    PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE
                GROUP_EXECUTE GROUP_READ
                WORLD_EXECUTE WORLD_READ
    DESTINATION ${INST_BIN_DIR} )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
configure_templates( cmake_uninstall.cmake ooRexxConfig.cmake )
if( HAVE_CMAKE_UNINSTALL_CMAKE )
  add_custom_target( uninstall
    COMMAND ${CMAKE_COMMAND}
      -P ${CMAKE_BINARY_DIR}/cmake_uninstall.cmake )
endif()

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
add_custom_target( portable
  COMMAND bash ${CMAKE_SOURCE_DIR}/${support_dir}/bin/portable-build.bash
    --makeself ${CMAKE_SOURCE_DIR}/${support_dir}/bin/makeself.sh
    --project  ${PROJECT}
    --prefix   ${CMAKE_INSTALL_PREFIX}
    --triplet  ${VERSION_TRIPLET}
    --version  ${VERSION_STRING}
  )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include( configurationReport OPTIONAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
vdump( "main" "exit" )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# this must be the last statement in this file.
include( CPack )
