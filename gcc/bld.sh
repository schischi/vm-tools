#! /bin/sh

set -e

ARCH=$1
TARGET=$2
#ARCH=i386
#TARGET=i386-linux

GCC_VER=gcc-5.3.0
BINUTILS_VER=binutils-2.26

MAKEOPTS=-j5

BASE_DIR=`dirname $(readlink -f $0)`
GCC_SRC=$BASE_DIR/src/$GCC_VER
BINUTILS_SRC=$BASE_DIR/src/$BINUTILS_VER
BUILD_DIR=$BASE_DIR/build/$ARCH
PREFIX=$BASE_DIR/toolchains/$ARCH-$GCC_VER

export PATH=$PREFIX/bin:$PATH
mkdir -p $PREFIX $BUILD_DIR/gcc $BUILD_DIR/binutils

cd $BUILD_DIR/binutils
$BINUTILS_SRC/configure --target=$TARGET --prefix=$PREFIX \
	--enable-64-bit-bfd --disable-nls --disable-werror
make $MAKEOPTS
make install

cd $BUILD_DIR/gcc
$GCC_SRC/configure \
        --target=$TARGET --enable-targets=all --prefix=$PREFIX \
	--enable-languages=c --without-headers --disable-bootstrap \
	--enable-sjlj-exceptions --with-system-libunwind \
	--disable-nls --disable-threads --disable-shared \
	--disable-libmudflap --disable-libssp --disable-libgomp \
	--disable-decimal-float --disable-libquadmath \
	--disable-libatomic --disable-libcc1
make $MAKEOPTS
make install
