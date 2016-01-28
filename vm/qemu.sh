#! /bin/sh

ARCH=$1
REPO=$2

source ./$ARCH/config
VM_DIR=`dirname $(readlink -f $0)`

$QEMU -kernel $ARCH/kernel/$REPO/$KERNEL \
      -netdev user,id=network0 \
      -device e1000,netdev=network0 \
      $QEMU_FLAGS \
      -append "root=/dev/nfs
               nfsroot=10.0.2.2:$VM_DIR/$ARCH/rootfs
               ntfsrootdebug
               ip=dhcp
               rw $LINUX_FLAGS"
