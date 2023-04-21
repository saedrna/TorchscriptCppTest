mkdir build
cd build

cmake -GNinja \
    -DCMAKE_PREFIX_PATH=$(python -c "import torch; print(torch.utils.cmake_prefix_path)") \
    -DTORCH_CLUSTER_DIR=$(python -c "import torch_cluster; print(torch_cluster.__path__[0])") \
    -DPython_ROOT_DIR=$(python -c "import sys; print(sys.prefix)") \
    -DPython_FIND_VIRTUALENV=ONLY \
    ../

cd ..