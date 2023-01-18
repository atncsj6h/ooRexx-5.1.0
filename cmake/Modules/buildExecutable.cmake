#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2022-2022 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macro( build_executable _executable )

  include( ${_executable}_exe_SRCS )

  add_executable( ${_executable}_exe
    ${common_${_executable}_exe_SRCS}
    ${platform_${_executable}_exe_SRCS}
  )

  if( HAVE_IPO_SUPPORT )
    set_target_properties( ${_executable}_exe
      PROPERTIES
      INTERPROCEDURAL_OPTIMIZATION TRUE
    )
  endif()

  set_target_properties( ${_executable}_exe
    PROPERTIES
    OUTPUT_NAME ${_executable}
  )

  target_include_directories( ${_executable}_exe
    PUBLIC
    ${${_executable}_exe_include_DIRS}
  )

  target_link_libraries( ${_executable}_exe
    ${common_${_executable}_exe_LIBS}
    ${platform_${_executable}_exe_LIBS}
    ${CMAKE_REQUIRED_LIBRARIES}
  )

  foreach( argv ${${_executable}_pragma_DIAG} )
    string( MAKE_C_IDENTIFIER "have_diag_${argv}" flag )
    string( TOUPPER "${flag}" flag )
    if( ${flag} )
      target_compile_definitions( ${_executable} PRIVATE
        ${flag}
      )
    endif()
  endforeach()

  install( TARGETS ${_executable}_exe
    DESTINATION ${INST_BIN_DIR}
  )
endmacro()

