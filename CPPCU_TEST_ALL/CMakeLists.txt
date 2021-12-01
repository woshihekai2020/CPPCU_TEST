cmake_minimum_required(VERSION 3.17)
project(CPPCU_TEST_ALL C CXX CUDA)

set(CMAKE_CXX_STANDARD  14)
set(CMAKE_CUDA_STANDARD 14)

set( CUDA_TOOLKIT_ROOT_DIR /usr/local/cuda-10.2 )
set( CUDA_CUDART_LIBRARY /usr/local/cuda-10.2/lib64/libcudart.so)
find_package( CUDA REQUIRED)
include_directories( ${CUDA_INCLUDE_DIRS} )
link_directories(${CUDA_LIBRARIES})
set( CUDA_SOURCE_PROPERTY_FORMAT OBJ )
set( CMAKE_CUDA_SEPARABLE_COMPILATION ON )
set( CUDA_PROPAGATE_HOST_FLAGS OFF )
set( CUDA_NVCC_FLAGS -arch=sm-55; -O3; -G; -g; -std=c++14 )

aux_source_directory( "include" HEADER_LIST )
aux_source_directory( "include/0_CU" HEADER_LIST )
#aux_source_directory( "include/2_slambook" HEADER_LIST )
#aux_source_directory( "include/3_VIO" HEADER_LIST )
aux_source_directory( "src" CPP_LIST )
aux_source_directory( "src/0_CU" CPP_LIST )
#aux_source_directory( "src/2_slambook" CPP_LIST )
#aux_source_directory( "src/3_VIO" CPP_LIST )


LIST(APPEND CMAKE_MOULDLE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules")

add_executable(CPPCU_TEST_ALL main.cpp All.h ${HEADER_LIST} ${CPP_LIST}
        src/baseTOOL.cpp include/baseTOOL.h src/0_CU/cu2_addSum.cu include/0_CU/cu2_addSum.cuh src/0_CU/cu3_calcTime.cu include/0_CU/cu3_calcTime.cuh)

set_target_properties(
        CPPCU_TEST_ALL
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
