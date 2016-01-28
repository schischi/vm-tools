#! /bin/sh

#./kernel build i386 next

ARCH=$1
REPO=$2
MAKEOPTS=-j5
REPO_BASE=/home/schischi/dev/kern-tools/repo/
VM_DIR=`dirname $(readlink -f $0)`/$ARCH

source $VM_DIR/config
export PATH=$VM_DIR/../../gcc/toolchains/$ARCH-gcc-5.3.0/bin/:$PATH
export KBUILD_OUTPUT=$VM_DIR/kernel/$REPO
export ARCH
export CROSS
export CROSS_COMPILE

cd $REPO_BASE/$REPO
mkdir -p $KBUILD_OUTPUT
cp $VM_DIR/kernel.config $KBUILD_OUTPUT/
make olddefconfig
make $MAKEOPTS
