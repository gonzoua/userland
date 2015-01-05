
#
# CMake defines to cross-compile to ARM/FreeBSD on BCM2708 using glibc.
#

SET(CMAKE_SYSTEM_NAME FreeBSD)
SET(CMAKE_C_COMPILER cc)
SET(CMAKE_CXX_COMPILER c++)
SET(CMAKE_ASM_COMPILER as)
SET(CMAKE_SYSTEM_PROCESSOR arm)

#ADD_DEFINITIONS("-march=armv6")
add_definitions("-mcpu=arm1176jzf-s -mfpu=vfp")
add_definitions("-DVCOS_DEFAULT_STACK_SIZE=16384")

# rdynamic means the backtrace should work
IF (CMAKE_BUILD_TYPE MATCHES "Debug")
   add_definitions(-rdynamic)
ENDIF()

# avoids annoying and pointless warnings from gcc
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -U_FORTIFY_SOURCE")

