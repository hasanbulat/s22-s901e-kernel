#!/bin/bash

exit_if_failed() {
    if [ $? -ne 0 ]; then
	echo "ABORT: Previous step failed"
	exit 1
    fi
}

START_DIR=`pwd`
cd android_kernel_samsung_sm8450 && ./build.sh
exit_if_failed
cd "$START_DIR"
exit_if_failed
./s901e.sh
exit_if_failed
