#!/usr/bin/env bash

export DEBUG=Yes
export PATH=$PATH:$DDD_DIR/scripts
export DDD_DIR=${DDD_DIR:-${HOME}/projects/dib-dev-deploy}
export DDD_WORKDIR=${DDD_DIR}-deps
export DDD_VM_TEMPLATE=${DDD_DIR}/templates/vm.xml
export DDD_EMULATOR=${DDD_EMULATOR:-/usr/bin/qemu-kvm}
export IMAGE_DIR=${IMAGE_DIR:-${HOME}/.gimme-images}
export DIB_DEV_USER_PWDLESS_SUDO=${DIB_DEV_USER_PWDLESS_SUDO:-Yes}
export IMAGE_NAME=${IMAGE_NAME:-}
export DDD_EMULATOR=${DDD_EMULATOR:-/usr/bin/qemu-kvm}
export LIBVIRT_DEFAULT_URI=qemu:///system
