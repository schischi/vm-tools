#! /bin/sh

ARCH=$1
REPO=$2
CUSTOM_FLAGS=$3

VM_DIR=`dirname $(readlink -f $0)`
source ${VM_DIR}/$ARCH/config

$QEMU -kernel ${VM_DIR}/$ARCH/kernel/$REPO/$KERNEL \
      -smp 1 \
      -m 512 \
      -netdev user,id=network0 \
      -device e1000,netdev=network0 \
      -nographic \
      $QEMU_FLAGS \
      $CUSTOM_FLAGS \
      -append "root=/dev/nfs
               nfsroot=10.0.2.2:$VM_DIR/$ARCH/rootfs,vers=3
               ntfsrootdebug
               ip=dhcp
               rw $LINUX_FLAGS"
