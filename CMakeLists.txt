cmake_minimum_required(VERSION 3.10.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

project(jetson-example VERSION 0.1.0 LANGUAGES C CXX)

add_subdirectory(${CMAKE_SOURCE_DIR}/src)
add_executable(jetson-example ${CMAKE_SOURCE_DIR}/src/main.cpp)

include_directories(src)

# Add testing
include(CTest)
enable_testing()

install(TARGETS jetson-example DESTINATION bin)