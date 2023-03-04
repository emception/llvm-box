#!/bin/bash
set -e

# Simulate feature options
export VERSION=3.26.0-rc5

curl -fsSLo install-cmake.sh "https://github.com/Kitware/CMake/releases/download/v$VERSION/cmake-$VERSION-linux-$(uname -m).sh"
chmod +x install-cmake.sh
./install-cmake.sh --skip-license --prefix=/usr/local --exclude-subdir
