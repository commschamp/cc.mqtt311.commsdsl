#!/bin/bash

if [ -z "${CC}" -o -z "$CXX" ]; then
    echo "ERROR: Compilers are not provided"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR=$( dirname ${SCRIPT_DIR} )
export BUILD_DIR="${ROOT_DIR}/build.full.${CC}"
export COMMON_INSTALL_DIR=${BUILD_DIR}/install
export COMMON_BUILD_TYPE=Debug
export EXTERNALS_DIR=${ROOT_DIR}/externals
export COMMON_USE_CCACHE=ON
mkdir -p ${BUILD_DIR}

${SCRIPT_DIR}/prepare_externals.sh

cd ${BUILD_DIR}
cmake .. -DCMAKE_INSTALL_PREFIX=${COMMON_INSTALL_DIR} \
    -DCMAKE_BUILD_TYPE=Debug -DMQTT311_GEN_TEST=ON -DMQTT311_BUILD_PROT_DOC=ON \
    -DMQTT311_GEN_TOOLS=ON -DMQTT311_GEN_SWIG=ON  -DMQTT311_GEN_EMSCRIPTEN=ON \
    -DMQTT311_USE_CCACHE=ON "$@"

procs=$(nproc)
if [ -n "${procs}" ]; then
    procs_param="--parallel ${procs}"
fi

cmake --build ${BUILD_DIR} --config ${COMMON_BUILD_TYPE} ${procs_param}
