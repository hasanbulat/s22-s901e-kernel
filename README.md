S22-s901e-kernel with root, selinux permissive
==============================================

Build
-----

`./build.sh`

- press `ENTER` to download necessary build tools as prompted.
- it would finally build a tar file of the boot image, flash that to the S22 with Odin.
- once phone has booted, enable adb and install the magisk apk from: https://github.com/topjohnwu/Magisk/releases 


Clean
-----

`./clean.sh`


Credits
-------

- Thanks to the authors of the original scripts, patches and src from https://github.com/mohammad92/android_kernel_samsung_sm8450

