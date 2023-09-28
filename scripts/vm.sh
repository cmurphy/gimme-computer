#!/usr/bin/env bash

source ${SCRIPTDIR}/defaults.sh

prepare_environment() {
    if ! rpm -q libvirt >/dev/null ; then
        sudo zypper --non-interactive install libvirt
    fi
    if ! systemctl status libvirtd >/dev/null ; then
        sudo systemctl start libvirtd
    fi
    if [ ! -f /usr/bin/qemu-kvm ] ; then
        sudo zypper --non-interactive install qemu-kvm
    fi
    if ! groups $USER | grep libvirt >/dev/null ; then
        sudo usermod -a -G libvirt $USER
    fi
}

check_net() {
    local netname=$1
    if ! virsh net-list | grep $netname >/dev/null ; then
        if ! virsh net-list --all | grep $netname >/dev/null ; then
            echo "The network $netname is not defined."
            exit 1
        else
            virsh net-autostart $netname
            virsh net-start $netname
        fi
    fi
}

check_name() {
    local vmname=$1
    local newname=$vmname
    while virsh dumpxml $newname &> /dev/null ; do # There is already a vm with this name
        local index=${newname##*-}
        if [ -z $index ] ; then index=0 ; fi
        index=$((index+1))
        local newname=${newname%-[0-9]}-${index}
    done
    if [ "$newname" != "$vmname" ] ; then
        echo "Domain $vmname already exists, creating $newname instead." 1>&2
        vmname=$newname
    fi
    echo $vmname
}

check_path() {
    local imagepath=$1
    if [ "${imagepath:0:1}" != "/" ] ; then
        imagepath=${IMAGE_DIR}/${imagepath}
    fi
    if [ "${imagepath##*.}" != "qcow2" ] ; then
        imagepath=${imagepath}.qcow2
    fi
    echo $imagepath
}

define_vm() {
    local vmname=$1
    local sourceimagepath=$2
    local imagefilename=$(basename $imagepath)
    local imagepath=${IMAGE_DIR}/${imagefilename%.qcow2}-$vmname-$(date -Iseconds).qcow2
    cp $sourceimagepath $imagepath
    if [ -n "${VM_DISK}" ] ; then
        qemu-img resize $imagepath $VM_DISK
    fi
    definition_path=$(mktemp)
    sed -e "s/{{name}}/$vmname/" \
        -e "s/{{memory}}/$VM_MEMORY/" \
        -e "s,{{imagefile}},$imagepath," \
        -e "s/{{cpus}}/$VM_CPUS/" \
        $SCRIPTDIR/../templates/vm.xml | tee $definition_path
    virsh define $definition_path
    rm $definition_path
}

start_vm() {
    local vmname=$1
    virsh start $vmname
}

create_vm() {
    local vmname=$1
    local imagepath=$2
    if [ -z "$vmname" -o -z "$imagepath" ] ; then
        echo 'vm command needs a vm name and an image path:'
        echo 'gimme vm myvm ~/.gimme-image/ubuntu.qcow2'
        exit 1
    fi
    prepare_environment
    check_net default
    vmname=$(check_name $vmname)
    imagepath=$(check_path $imagepath)
    define_vm $vmname $imagepath
    start_vm $vmname
}
