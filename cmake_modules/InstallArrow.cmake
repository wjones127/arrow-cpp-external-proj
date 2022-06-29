function(install_arrow)
    set(ARROW_DOWNLOAD_BINARY_DIR ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY})

    # Declare Arrow as an external project
    configure_file(${CMAKE_SOURCE_DIR}/cmake_modules/Arrow.CMakeLists.txt.cmake ${ARROW_DOWNLOAD_BINARY_DIR}/CMakeLists.txt COPYONLY)

    # Configure sets up external project
    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${ARROW_DOWNLOAD_BINARY_DIR}
    )

    if(result)
        message(FATAL_ERROR "CMake step for arrow failed: ${result}")
    endif()

    # Will download, configure, and build Arrow
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${ARROW_DOWNLOAD_BINARY_DIR}
    )

    if(result)
        message(FATAL_ERROR "Build step for arrow failed: ${result}")
    endif()

    # Makes Arrow discoverable to find_package()
    list(APPEND CMAKE_PREFIX_PATH "${ARROW_DOWNLOAD_BINARY_DIR}/arrow_ep-prefix/src/arrow_ep-install/usr/local/")
    set(CMAKE_PREFIX_PATH  ${CMAKE_PREFIX_PATH} PARENT_SCOPE)
endfunction()