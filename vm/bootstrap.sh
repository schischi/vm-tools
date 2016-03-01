#! /bin/bash

set -e

source ./$1/config
RELEASE=jessie

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
export LC_ALL=C
export LANGUAGE=C
export LANG=C
DEBOOTSTRAP=debootstrap

# Debian
ROOTFS=$1/rootfs
mkdir -p $ROOTFS
$DEBOOTSTRAP --foreign --include="debian-keyring,debian-archive-keyring" \
    --arch $DARCH --variant=minbase $RELEASE $ROOTFS
cp /usr/bin/$QEMU_STATIC $ROOTFS/usr/bin
# Ugly fix
sed -is 's/set -e//' $ROOTFS/debootstrap/debootstrap
chroot $ROOTFS /debootstrap/debootstrap --second-stage
chroot $ROOTFS dpkg --configure -a

# NFS
grep -q $ARCH /etc/exports
if [ $? -ne 0 ]; then
    echo `pwd`"/$ROOTFS 127.0.0.1(rw,sync,no_subtree_check,no_root_squash,insecure)" >> /etc/exports
    exportfs -rav
    systemctl restart nfs-server
fi
