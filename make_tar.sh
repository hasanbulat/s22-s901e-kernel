#!/bin/bash

ORI_BOOT="boot-$2-$3-ori-magisk.img"
AZQ_TAR="AZQ_BOOT_SAMSUNG_GALAXY_$1_$2_$3_$(date +%d%m%y).tar"

echo "### Cleaning up..."
sudo rm bootimg/${ORI_BOOT}

cd aik-3.8
sudo rm boot.img boot.img.lz4
sudo ./cleanup.sh
echo "### Unpacking ori boot lz4..."
lz4 -d ../bootimg/${ORI_BOOT}.lz4
echo "### Unpacking boot img..."
sudo ./unpackimg.sh ../bootimg/${ORI_BOOT}
echo "### Copying build kernel..."
sudo cp ../android_kernel_samsung_sm8450/out/Image split_img/${ORI_BOOT}-kernel
echo "### Repacking boot img..."
sudo ./repackimg.sh
echo "### Creating AZQ tar for SAMSUNG"
cp image-new.img boot.img
lz4 -B6 --content-size boot.img boot.img.lz4
tar -H ustar -cf ${AZQ_TAR} boot.img.lz4
cd ..
echo "### DONE - aik-3.8/${AZQ_TAR} created"
ls -l aik-3.8/${AZQ_TAR}
