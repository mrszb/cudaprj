cmake_minimum_required(VERSION 3.11)
set(CMAKE_CXX_STANDARD 20)

project(hello LANGUAGES CXX CUDA)
enable_language(CUDA)
add_executable(hello hello.cu)

project(addcpu LANGUAGES CXX)
add_executable(addcpu addcpu.cpp)

project(addgpu LANGUAGES CXX CUDA)
enable_language(CUDA)
add_executable(addgpu addgpu.cu)


macro(run_conan)
    if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
        message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
        file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/develop/conan.cmake"
            "${CMAKE_BINARY_DIR}/conan.cmake"
            )
    endif()

    include(${CMAKE_BINARY_DIR}/conan.cmake)

    conan_add_remote(
        NAME bincrafters
        INDEX 1
        URL
        https://bincrafters.jfrog.io/artifactory/api/conan/public-conan)

    message(STATUS "Conan: config get general.revisions_enabled=${CONAN_REV_STATUS}")
    if (NOT "${CONAN_REV_STATUS}" STREQUAL "True")
      message(AUTHOR_WARNING "Conan: Force enabling revisions (conan config set general.revisions_enabled=True)")
      execute_process(COMMAND ${CONAN_CMD} config set general.revisions_enabled=True)
    endif()

    conan_cmake_run(
        REQUIRES
        ${CONAN_EXTRA_REQUIRES}
        catch2/2.13.7                                    
        fmt/8.0.1
        spdlog/1.9.2
        OPTIONS
        ${CONAN_EXTRA_OPTIONS}
        BASIC_SETUP
        CMAKE_TARGETS # individual targets to link to
        BUILD
        missing)
endmacro()

run_conan()

# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(CTest)
endif()


if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME OR MODERN_CMAKE_BUILD_TESTING) AND BUILD_TESTING)
    add_subdirectory(tests)
endif()







