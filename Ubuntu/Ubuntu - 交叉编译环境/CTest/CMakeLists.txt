cmake_minimum_required(VERSION 3.7)

# 添加GCC编译器路径
# set(CMAKE_C_COMPILER "")
# set(CMAKE_CXX_COMPILER "")

project(CTest)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

# Close not commonly used WIN32 modules 
add_definitions(-DWIN32_LEAN_AND_MEAN)

add_executable(${PROJECT_NAME} main.cpp)