#! /bin/bash

set -e

source ./$1/config

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LC_ALL=C
export LANGUAGE=C
export LANG=C

# Debian
ROOTFS=$ARCH/rootfs
mkdir -p $ROOTFS
debootstrap --foreign --arch $DARCH --variant=minbase jessie $ROOTFS http://http.debian.net/debian/
cp /usr/bin/$QEMU_STATIC $ROOTFS/usr/bin
chroot $ROOTFS /debootstrap/debootstrap --second-stage
chroot $ROOTFS dpkg --configure -a

# NFS
grep -q $ROOTFS /etc/exports
if [ $? -ne 0 ]; then
    echo `pwd`"/$ROOTFS 127.0.0.1(rw,sync,no_subtree_check,no_root_squash,insecure)" >> /etc/exports
    exportfs -rav
    systemctl restart nfs-server
fi
