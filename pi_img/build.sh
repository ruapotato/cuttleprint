#!/bin/bash

ROOT=~/PI_build_root
#echo "Cleaning up"
#rm -r $ROOT

if [ "$EUID" -ne 0 ]
    then echo "Run as root"
    exit 1
fi

echo "Builing new root in $ROOT"
mkdir $ROOT

#Build with PI repo
#wget http://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -q
#debootstrap --keyring=/etc/apt/trusted.gpg --arch armhf bullseye $ROOT http://archive.raspbian.org/raspbian/
debootstrap --arch armhf bullseye $ROOT http://ftp.us.debian.org/debian/


echo "Adding Cuttleprint files"
mkdir $ROOT/Cuttleprint
cp ../* $ROOT/Cuttleprint/
cp -r ../gcode_snips $ROOT/Cuttleprint/

echo "Setting up for chroot"
cp /usr/bin/qemu-arm-static $ROOT/usr/bin

for i in dev sys proc
do
    mount --rbind /$i $ROOT/$i
done

echo "Running chroot_script in new root"
cp ./chroot_script $ROOT
chroot $ROOT /chroot_script


echo "Cleaning up chroot"
for i in dev sys proc
do
    sudo mount --make-rslave $ROOT/$i
    sudo umount -R $ROOT/$i
done
