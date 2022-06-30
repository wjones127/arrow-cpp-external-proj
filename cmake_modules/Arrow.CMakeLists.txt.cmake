cmake_minimum_required(VERSION 2.8.12)

set(ARROW_CMAKE_ARGS
    #Build settings
    -DARROW_BUILD_STATIC=ON
    -DARROW_BUILD_SHARED=OFF
    -DARROW_BOOST_USE_SHARED=ON
    -DARROW_BUILD_TESTS=OFF
    -DARROW_DEPENDENCY_SOURCE=BUNDLED

    #Arrow modules
    -DARROW_FILESYSTEM=ON
    -DARROW_GCS=ON
    -DARROW_S3=OFF
    -DARROW_CSV=ON
    -DARROW_FLIGHT=ON
    -DARROW_PARQUET=ON
    -DARROW_COMPUTE=ON
)

include(ExternalProject)
ExternalProject_Add(
    arrow_ep 
    GIT_REPOSITORY https://github.com/apache/arrow.git
    GIT_TAG master
    # GIT_REPOSITORY https://github.com/wjones127/arrow.git
    # GIT_TAG bundle-flight
    SOURCE_SUBDIR cpp
    CONFIGURE_COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" ${ARROW_CMAKE_ARGS} "${CMAKE_CURRENT_BINARY_DIR}/arrow_ep-prefix/src/arrow_ep/cpp/"
    INSTALL_COMMAND DESTDIR=${CMAKE_CURRENT_BINARY_DIR}/arrow_ep-prefix/src/arrow_ep-install cmake --build . --target install
)