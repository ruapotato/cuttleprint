#!/bin/bash
IMG="./cuttleprint.img"
ROOT=~/PI_build_root
dd if=/dev/zero of=$IMG bs=1M count=4096

echo "Making new image file $IMG"
#setup loopback
losetup -Pf $IMG
device=$(losetup -a | sort | tail -n 1 | cut -d ":" -f1)
echo "Setup $device"
#mount
#mount $device$part $mount_point

#echo -e "To unmount: \numount $mount_point\nlosetup -D $IMG"
echo -e "To unmount: \nlosetup -D $IMG"


parted --script $device "mklabel  msdos"
parted --script $device "mkpart primary fat32 4MiB 256MiB"
parted --script $device "mkpart primary 256MiB -1"

boot_part="p1"
mkfs.fat -F32 -v -I $device$boot_part

root_part="p2"
mkfs.ext4 $device$root_part

echo "Mounting new partions"
mount $device$root_part /mnt
mkdir /mnt/boot
mount  $device$boot_part /mnt/boot/

echo "Copying files..."
cp -ar $ROOT/* /mnt/

echo "Unmounting image file"
umount /mnt/boot
umount /mnt
losetup -D $IMG

echo "To make SD card Run\n   dd if=$IMG of=/dev/<SDCARD> bs=1M status=progress"
