#!/usr/bin/env bash

export DEBUG=Yes
export DIBVENV=${DIBVENV:-${SCRIPTDIR}/../dibvenv}
export PATH=$PATH:$DDD_DIR/scripts
export IMAGE_DIR=${IMAGE_DIR:-${HOME}/.gimme-images}
export DIB_DEV_USER_PWDLESS_SUDO=${DIB_DEV_USER_PWDLESS_SUDO:-Yes}
export DIB_DEV_USER_SHELL=/bin/bash
export DIB_DEV_USER_PASSWORD=${DIB_DEV_USER_PASSWORD:-devuser}
export DIB_DEV_USER_AUTHORIZED_KEYS=${HOME}/.ssh/id_rsa_nopw.pub
export IMAGE_NAME=${IMAGE_NAME:-}
export LIBVIRT_DEFAULT_URI=qemu:///system
export VM_MEMORY=${VM_MEMORY:-4096}
export VM_CPUS=${VM_CPUS:-1}
export VM_DISK=${VM_DISK:-''}
export ELEMENTS_PATH=${ELEMENTS_PATH:+"$ELEMENTS_PATH:"}${SCRIPTDIR}/../elements
export PACKAGES=${PACKAGES:+",$PACKAGES"}
