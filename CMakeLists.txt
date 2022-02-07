cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(hello LANGUAGES CXX CUDA)
enable_language(CUDA)
add_executable(hello hello.cu)

project(addcpu LANGUAGES CXX)
add_executable(addcpu addcpu.cpp)

project(addgpu LANGUAGES CXX CUDA)
enable_language(CUDA)
add_executable(addgpu addgpu.cu)