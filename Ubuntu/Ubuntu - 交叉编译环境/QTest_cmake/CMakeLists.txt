cmake_minimum_required(VERSION 3.7)

# 添加GCC编译器路径
if(${CROSS_COMPILE_FRAMEWORK} STREQUAL "aarch64")
	message("[+] framework is aarch64")
	set(CMAKE_C_COMPILER "aarch64-linux-gnu-gcc")
	set(CMAKE_CXX_COMPILER "aarch64-linux-gnu-g++")
elseif(${CROSS_COMPILE_FRAMEWORK} STREQUAL "mips64")
	message("[+] framework is mips64")
	set(CMAKE_C_COMPILER "mips64el-loongson-linux-gcc")
	set(CMAKE_CXX_COMPILER "mips64el-loongson-linux-g++")
endif()

project(QTest)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

# Close not commonly used WIN32 modules 
add_definitions(-DWIN32_LEAN_AND_MEAN)

find_package(Qt5 COMPONENTS Core Gui Widgets REQUIRED)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Gui Qt5::Widgets)
