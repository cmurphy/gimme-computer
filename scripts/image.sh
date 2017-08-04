#!/usr/bin/env bash

source ${SCRIPTDIR}/defaults.sh

prepare_environment() {
    if ! which qemu-img 2> /dev/null ; then
        sudo zypper --non-interactive install qemu
    fi
    mkdir -p $IMAGE_DIR
    if [ ! -d $DIBVENV ] ; then
        virtualenv $DIBVENV
    fi
    if ! which disk-image-create ; then
        source $DIBVENV/bin/activate
    fi
    pip install -U diskimage-builder
}

create_output_option() {
    if [[ "$*" =~ "-o .*" ]] ; then
        return
    fi
    if [ -n "$IMAGE_NAME" ] ; then
        local image_name=$IMAGE_NAME
    else
        for distro in ubuntu debian centos centos7 opensuse fedora gentoo ; do
            if [[ "$*" =~ "$distro" ]] ; then
                local image_name=$distro
                break
            fi
        done
    fi
    local output_option="-o ${IMAGE_DIR}/${image_name}"
    echo $output_option
}

create_image() {
    prepare_environment
    disk-image-create vm cloud-init-nocloud pip-and-virtualenv devuser openssh-server dhcp-all-interfaces \
                      -p python,git \
                      -u \
                      --image-size 30 \
                      $(create_output_option $*) $*
}
