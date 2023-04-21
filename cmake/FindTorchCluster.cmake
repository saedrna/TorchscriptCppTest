# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindTorchCluster
# --------
#
# Find the TorchCluster library in python
#
# Imported targets
# ^^^^^^^^^^^^^^^^
#
# This module defines the following :prop_tgt:`IMPORTED` targets:
#
# ``TorchCluster::fps``
#
# Result variables
# ^^^^^^^^^^^^^^^^
#
# This module will set the following variables in your project:
#
# ``TorchCluster_FOUND``
#   true if the TorchCluster headers and libraries were found
# ``TorchCluster_LIBRARIES``
#   TorchCluster libraries to be linked
#

# We must define TORCH_CLUSTER_DIR to let the script work
if(NOT TORCH_CLUSTER_DIR)
  message(FATAL_ERROR "TORCH_CLUSTER_DIR must be set to the path containing the TorchCluster library")
else()
    message(STATUS "TORCH_CLUSTER_DIR is set to ${TORCH_CLUSTER_DIR}")
endif()

set(TorchCluster_NAMES ${TorchCluster_NAMES} "fps" "knn")
include(FindPackageHandleStandardArgs)

foreach(name ${TorchCluster_NAMES})
    find_library(TorchCluster_${name}_LIBRARY
                 NAMES "_${name}_cuda.so"
                 PATHS "${TORCH_CLUSTER_DIR}"
                 NO_DEFAULT_PATH)

    FIND_PACKAGE_HANDLE_STANDARD_ARGS(TorchCluster REQUIRED_VARS TorchCluster_${name}_LIBRARY)
    add_library(TorchCluster::${name} UNKNOWN IMPORTED)
    set_target_properties(TorchCluster::${name} PROPERTIES
        IMPORTED_LOCATION "${TorchCluster_${name}_LIBRARY}")
    list(APPEND TorchCluster_LIBRARIES TorchCluster::${name})
    mark_as_advanced(TorchCluster_${name}_LIBRARY)
endforeach()

