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
        for distro in ubuntu debian centos centos7 opensuse fedora gentoo sles ; do
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
    if [[ "$*" =~ "sles" && "$DIB_RELEASE" == '12-SP4' ]] ; then
        local mkfs_opts='-O ^metadata_csum'
    else
        local mkfs_opts=''
    fi
    disk-image-create vm cloud-init-nocloud pip-and-virtualenv devuser openssh-server dhcp-all-interfaces \
                      -p python,git,less,vim,man \
                      -u \
                      --image-size 30 \
                      --mkfs-options "$mkfs_opts" \
                      $(create_output_option $*) $*
}
