#!/bin/bash 
set -e 

PWD=$(pwd)
BUILD_DIR=$PWD/build-arm

if [   -e "$BUILD_DIR" ];then
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -DCMAKE_TOOLCHAIN_FILE=/opt/sh/cmake/cmake_arm.cmake \
	-DCMAKE_BUILD_TYPE=Release \
	../

make 
