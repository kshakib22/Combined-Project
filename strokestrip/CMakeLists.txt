cmake_minimum_required(VERSION 3.3)

project(strokestrip C)

# Set c++11
# https://stackoverflow.com/questions/10851247/how-to-activate-c-11-in-cmake
if (POLICY CMP0025)
  cmake_policy(SET CMP0025 NEW)
endif ()
set (CMAKE_CXX_STANDARD 14)

option(CXX "enable C++ compilation" ON)
if(CXX)
    enable_language(CXX)
endif()

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# Visual Studio compiler with static runtime libraries
if(MSVC AND MT)
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd")
endif()

find_package(GUROBI REQUIRED)
if (GUROBI_INCLUDE_DIR)
  # in cache already
  set(GUROBI_FOUND TRUE)
  set(GUROBI_INCLUDE_DIRS "${GUROBI_INCLUDE_DIR}" )
  set(GUROBI_LIBRARIES "${GUROBI_LIBRARY};${GUROBI_CXX_LIBRARY}" )
else (GUROBI_INCLUDE_DIR)

find_path(GUROBI_INCLUDE_DIR
          NAMES gurobi_c++.h
          PATHS "$ENV{GUROBI_HOME}/include"
                  "/Library/gurobi950/macos_universal2/include"
                 "C:\\libs\\gurobi502\\include"
          )

find_package( GUROBI_LIBRARY
              NAMES gurobi
		    gurobi45
		    gurobi46
        gurobi50
        gurobi51
        gurobi52
        gurobi55
        gurobi56
        gurobi60
        gurobi65
              PATHS "$ENV{GUROBI_HOME}/lib"
                    "/Library/gurobi950/macos_universal2/lib"
                    "C:\\libs\\gurobi502\\lib"
              )

find_package( GUROBI_CXX_LIBRARY 
              NAMES gurobi_c++
              PATHS "$ENV{GUROBI_HOME}/lib"
                    "/Library/gurobi950/macos_universal2/lib"
                    "C:\\libs\\gurobi502\\lib"
              )

set(GUROBI_INCLUDE_DIRS "${GUROBI_INCLUDE_DIR}" )
set(GUROBI_LIBRARIES "${GUROBI_LIBRARY};${GUROBI_CXX_LIBRARY}" )

# use c++ headers as default
# set(GUROBI_COMPILER_FLAGS "-DIL_STD" CACHE STRING "Gurobi Compiler Flags")

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBCPLEX_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GUROBI  DEFAULT_MSG
                                  GUROBI_LIBRARY GUROBI_CXX_LIBRARY GUROBI_INCLUDE_DIR)

mark_as_advanced(GUROBI_INCLUDE_DIR GUROBI_LIBRARY GUROBI_CXX_LIBRARY)

endif(GUROBI_INCLUDE_DIR)
include_directories(${GUROBI_INCLUDE_DIRS})

# Source files
file(GLOB SOURCE_FILES src/*.cpp src/*.h)
add_executable(${CMAKE_PROJECT_NAME} ${SOURCE_FILES})

if(CXX)
    set(CMAKE_CXX_STANDARD 11)
    target_link_libraries(${CMAKE_PROJECT_NAME} optimized ${GUROBI_CXX_LIBRARY} debug ${GUROBI_CXX_DEBUG_LIBRARY})
endif()

target_link_libraries(${CMAKE_PROJECT_NAME} ${GUROBI_LIBRARY})

if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
    include(FeatureSummary)
    feature_summary(WHAT ALL)
endif()

# Eigen
find_package(Eigen3 CONFIG REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} Eigen3::Eigen)

# Glm
add_subdirectory(external/glm)
target_link_libraries(${CMAKE_PROJECT_NAME} glm)

# Cornucopia
add_subdirectory(external/Cornucopia)
target_link_libraries(${CMAKE_PROJECT_NAME} Cornucopia)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE external/)
