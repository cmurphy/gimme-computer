#!/usr/bin/env bash

export DEBUG=Yes
export DIBVENV=${DIBVENV:-${SCRIPTDIR}/../dibvenv}
export PATH=$PATH:$DDD_DIR/scripts
export IMAGE_DIR=${IMAGE_DIR:-${HOME}/.gimme-images}
export DIB_DEV_USER_PWDLESS_SUDO=${DIB_DEV_USER_PWDLESS_SUDO:-Yes}
export DIB_DEV_USER_SHELL=/bin/bash
export DIB_DEV_USER_PASSWORD=${DIB_DEV_USER_PASSWORD:-devuser}
export IMAGE_NAME=${IMAGE_NAME:-}
export LIBVIRT_DEFAULT_URI=qemu:///system
export VM_MEMORY=${VM_MEMORY:-4096}
