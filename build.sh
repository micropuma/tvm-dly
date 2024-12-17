rm -rf build && mkdir build && cd build
# Specify the build configuration via CMake options
cp ../cmake/config.cmake .

# controls default compilation flags (Candidates: Release, Debug, RelWithDebInfo)
echo "set(CMAKE_BUILD_TYPE RelWithDebInfo)" >> config.cmake

# LLVM is a must dependency for compiler end
echo "set(USE_LLVM \"llvm-config --ignore-libllvm --link-static\")" >> config.cmake
echo "set(HIDE_PRIVATE_SYMBOLS ON)" >> config.cmake

# GPU SDKs, turn on if needed
echo "set(USE_CUDA   ON)" >> config.cmake
echo "set(USE_METAL  OFF)" >> config.cmake
echo "set(USE_VULKAN OFF)" >> config.cmake
echo "set(USE_OPENCL OFF)" >> config.cmake

# cuBLAS, cuDNN, cutlass support, turn on if needed
echo "set(USE_CUBLAS OFF)" >> config.cmake
echo "set(USE_CUDNN  OFF)" >> config.cmake
echo "set(USE_CUTLASS OFF)" >> config.cmake

cmake .. -DLLVM_CONFIG_EXECUTABLE=/home/douliyang/local/LLVM/bin/llvm-config && cmake --build . --parallel $(nproc)