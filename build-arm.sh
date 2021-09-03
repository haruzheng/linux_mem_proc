#!/bin/bash
set -e

find . -name "*.a" -exec rm -rf {} \;
find . -name "*.o" -exec rm -rf {} \;
PREFIX=arm-linux-gnueabi-

PWD=$(pwd)
BUILD_DIR=$PWD/bin

if [   -e "$BUILD_DIR" ];then
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"
cd $BUILD_DIR

## libpagemap
cd $PWD/../libpagemap
make clean
make prefix=arm-linux-gnueabi-

## procmem
cd $PWD/../procmem
make clean
make outdir=$BUILD_DIR prefix=arm-linux-gnueabi-

## procrank
cd $PWD/../procrank
make clean
make outdir=$BUILD_DIR prefix=arm-linux-gnueabi-
