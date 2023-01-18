#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Copyright (c) 2022-2022 Enrico Sorichetti
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file BOOST_LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
include_guard( GLOBAL )

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macro( build_library _library )

  include( ${_library}_SRCS )

  add_library( ${_library} SHARED
    ${common_${_library}_SRCS}
    ${platform_${_library}_SRCS}
  )

  if( HAVE_IPO_SUPPORT )
    set_target_properties( ${_library}
      PROPERTIES
      INTERPROCEDURAL_OPTIMIZATION TRUE
    )
  endif()

  set_target_properties( ${_library}
    PROPERTIES
    OUTPUT_NAME ${_library} )

  target_include_directories( ${_library}
    PUBLIC
    ${${_library}_include_DIRS}
  )

  target_link_libraries( ${_library}
    ${common_${_library}_LIBS}
    ${platform_${_library}_LIBS}
    ${CMAKE_REQUIRED_LIBRARIES}
  )

  foreach( argv ${${_library}_pragma_DIAG} )
    string( MAKE_C_IDENTIFIER "have_diag_${argv}" flag )
    string( TOUPPER "${flag}" flag )
    if( ${flag} )
      target_compile_definitions( ${_library} PRIVATE
        ${flag}
      )
    endif()
  endforeach()

  if( SOVERSION )
    set_target_properties( ${_library}
      PROPERTIES
      SOVERSION ${SOVERSION}
    )
  endif()

  install( TARGETS ${_library}
    DESTINATION ${INST_LIB_DIR}
  )
endmacro()

