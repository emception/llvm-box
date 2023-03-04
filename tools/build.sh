#!/bin/bash
set -e
# Sections and commands of this script are copied from build-llvm.sh [1] in the
# jprendes/emception original project.
#
# [1]: https://github.com/jprendes/emception/blob/366065547b1a59cb58011ed19aedce70c3bcbd2b/build-llvm.sh

# Cross compiling llvm needs a native build of llvm-tblgen and clang-tblgen for
# that platform. So first, we need to build them for a WebAssembly target so
# that we can use them later when we build all the other binaries. It's like a
# dependency that we need to make before making the parent project.
cmake -G Ninja \
  -S llvm \
  -B build/llvm-native \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_TARGETS_TO_BUILD=WebAssembly \
  -DLLVM_ENABLE_PROJECTS=clang
cmake --build build/llvm-native -- llvm-tblgen clang-tblgen

# Start a subshell so that we can incrementally export ... over multiple lines.
# If we try to do all these env vars in one prefix, it gets to be a mess of
# quotes and backslashes.
#
# This builds the clang, lld, and clang-tools-extra LLVM sub-projects using the
# emcmake environment wrapper. It sets a bunch of magic stuff to make builds
# like this work. I don't completely understand it.
#
# TODO: Add better comment about what the emcmake command does
(
  set -e
  export CXXFLAGS=-Dwait4=__syscall_wait4
  export LDFLAGS="-s LLD_REPORT_UNDEFINED=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s EXPORTED_FUNCTIONS=_main,_free,_malloc \
    -s EXPORTED_RUNTIME_METHODS=FS,PROXYFS,ERRNO_CODES,allocateUTF8 \
    -lproxyfs.js \
    --js-library=$PWD/tools/fsroot.js"
  emcmake cmake -G Ninja \
    -S llvm \
    -B build/llvm-wasm \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_TARGETS_TO_BUILD=WebAssembly \
    -DLLVM_ENABLE_PROJECTS='clang;lld;clang-tools-extra' \
    -DLLVM_ENABLE_DUMP=OFF \
    -DLLVM_ENABLE_ASSERTIONS=OFF \
    -DLLVM_ENABLE_EXPENSIVE_CHECKS=OFF \
    -DLLVM_ENABLE_BACKTRACES=OFF \
    -DLLVM_BUILD_TOOLS=OFF \
    -DLLVM_ENABLE_THREADS=OFF \
    -DLLVM_BUILD_LLVM_DYLIB=OFF \
    -DLLVM_INCLUDE_TESTS=OFF \
    -DLLVM_TABLEGEN=build/llvm-native/bin/llvm-tblgen \
    -DCLANG_TABLEGEN=build/llvm-native/bin/clang-tblgen
)
