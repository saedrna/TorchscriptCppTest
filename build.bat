@echo off

for /f "tokens=*" %%a in ('python -c "import sys; print(sys.prefix)"') do set Python_ROOT_DIR=%%a
for /f "tokens=*" %%a in ('python -c "import torch; print(torch.utils.cmake_prefix_path)"') do set Torch_DIR=%%a
for /f "tokens=*" %%a in ('python -c "import torch_cluster; print(torch_cluster.__path__[0])"') do set TORCH_CLUSTER_DIR=%%a

REM check if visual studio 2022 is installed and warn if not
if not exist "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" (
    echo Visual Studio 2022 is not installed. Please install it before continuing.
    pause
    exit /b 1
)

REM if not initialized, initialize the vs dev cmd script for x64
if not defined VSINSTALLDIR (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64
)

REM Set the following environment variables to your own paths
set CUDA_PATH=%Python_ROOT_DIR%
set CUDA_TOOLKIT_ROOT_DIR=%Python_ROOT_DIR%

mkdir build
cd build

cmake -GNinja ^
    -DCMAKE_PREFIX_PATH=%CONDA_PREFIX%/Library ^
    -DTorch_DIR=%Torch_DIR% ^
    -DTORCH_CLUSTER_DIR=%TORCH_CLUSTER_DIR% ^
    -DPython_ROOT_DIR=%Python_ROOT_DIR% ^
    -DPython_FIND_VIRTUALENV=ONLY ^
    ../

cd ..
