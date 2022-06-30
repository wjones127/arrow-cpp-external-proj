cmake_minimum_required(VERSION 3.7...3.23)

if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

project(ArrowMinimalExample VERSION 1.0
                            DESCRIPTION "Example project using Arrow C++ Library"
                            LANGUAGES CXX)


set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/" ${CMAKE_MODULE_PATH})

include(InstallArrow) 
install_arrow()
find_package(Arrow CONFIG REQUIRED)
find_package(Parquet CONFIG REQUIRED PATHS "${CMAKE_PREFIX_PATH}/lib/cmake/arrow" )
find_package(ArrowFlight CONFIG REQUIRED PATHS "${CMAKE_PREFIX_PATH}/lib/cmake/arrow" )

set(CMAKE_CXX_STANDARD 11)

add_executable(arrow_example app.cpp)

target_link_libraries(arrow_example 
    PRIVATE
        arrow_flight_static
        parquet_static
        arrow_static
        arrow_bundled_dependencies
        ${CMAKE_DL_LIBS}
        curl
        )

