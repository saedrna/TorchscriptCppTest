cmake_minimum_required(VERSION 3.0)

project(Torchscript CUDA CXX)

# set output to bin lib etc.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# append cmake to module path
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

set(CXX_STANDARD 17)

find_package(Torch REQUIRED)
message(STATUS "Torch library status: ${TORCH_LIBRARIES}")

find_package(CUDAToolkit REQUIRED)

find_package(TorchCluster REQUIRED)
find_package(Python 3.8 COMPONENTS Interpreter Development REQUIRED)

add_executable(Torchscript zero/csrc/main.cpp) 
target_link_libraries(Torchscript -Wl,--no-as-needed Python::Python CUDA::cudart CUDA::nvrtc)
target_link_libraries(Torchscript -Wl,--no-as-needed "${TORCH_LIBRARIES}")
target_link_libraries(Torchscript -Wl,--no-as-needed TorchCluster::fps)
