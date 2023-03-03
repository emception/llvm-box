#!/bin/bash
set -e

# Simulate feature options
export VERSION=3.26.0-rc5

# https://askubuntu.com/a/865294
mkdir "/opt/cmake-$VERSION"
cd "/opt/cmake-$VERSION"
wget "https://cmake.org/files/v$VERSION/cmake-$VERSION.tar.gz"
tar -xzvf "cmake-$VERSION.tar.gz"
cd "cmake-$VERSION"
./bootstrap
make "-j$(nproc)"
make install
