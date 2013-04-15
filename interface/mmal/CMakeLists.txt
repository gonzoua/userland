add_definitions(-Wall -Werror)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    message(STATUS "${CMAKE_CXX_COMPILER_VERSION}")
    execute_process(COMMAND ${CMAKE_CXX_COMPILER} -v
        ERROR_VARIABLE _clangcxx_dumpedversion
        ERROR_STRIP_TRAILING_WHITESPACE
    )
    string(REGEX REPLACE ".*clang version ([0-9]\\.[0-9]+).*" "\\1" _clangcxx_version ${_clangcxx_dumpedversion})
    message(STATUS "Clang version : ${_clangcxx_version}")

    if(_clangcxx_version VERSION_GREATER 3.2)
        add_definitions(-Wno-error=undefined-inline)
    endif()
endif()

add_library(mmal SHARED util/mmal_util.c)

add_subdirectory(core)
add_subdirectory(util)
add_subdirectory(vc)

#add_subdirectory(test/lua)
#add_subdirectory(test/standalone)

if(BUILD_MMAL_APPS)
add_subdirectory(components)
target_link_libraries(mmal mmal_core mmal_util mmal_vc_client vcos mmal_components)
else(BUILD_MMAL_APPS)
target_link_libraries(mmal mmal_core mmal_util mmal_vc_client)
endif(BUILD_MMAL_APPS)

install(TARGETS mmal DESTINATION lib)
