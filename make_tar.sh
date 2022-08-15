#!/bin/bash

exit_if_failed() {
    if [ $? -ne 0 ]; then
	echo "ABORT: Previous step failed"
	exit 1
    fi
}

ORI_BOOT="boot-$2-$3-ori-magisk.img"
AZQ_TAR="AZQ_BOOT_SAMSUNG_GALAXY_$1_$2_$3_$(date +%d%m%y).tar"

echo "### Cleaning up..."
sudo rm -rf bootimg/${ORI_BOOT}
exit_if_failed

cd aik-3.8
exit_if_failed
sudo rm boot.img boot.img.lz4
sudo ./cleanup.sh
exit_if_failed

echo "### Unpacking ori boot lz4..."
lz4 -d ../bootimg/${ORI_BOOT}.lz4
exit_if_failed
echo "### Unpacking boot img..."
sudo ./unpackimg.sh ../bootimg/${ORI_BOOT}
exit_if_failed
echo "### Copying build kernel..."
sudo cp ../android_kernel_samsung_sm8450/out/Image split_img/${ORI_BOOT}-kernel
exit_if_failed
echo "### Repacking boot img..."
sudo ./repackimg.sh
exit_if_failed
echo "### Creating AZQ tar for SAMSUNG"
cp image-new.img boot.img
exit_if_failed
lz4 -B6 --content-size boot.img boot.img.lz4
exit_if_failed
tar -H ustar -cf ${AZQ_TAR} boot.img.lz4
exit_if_failed
cd ..
exit_if_failed
echo "### DONE - aik-3.8/${AZQ_TAR} created - ready to flash with Odin"
ls -lh aik-3.8/${AZQ_TAR}
exit_if_failed
cp aik-3.8/${AZQ_TAR} .
exit_if_failed
ls -lh ${AZQ_TAR}

