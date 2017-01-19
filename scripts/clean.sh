#!/usr/bin/env bash

source ${SCRIPTDIR}/defaults.sh

clean_vm() {
    local vmname=$1
    local force=$2
    if [ -n "$force" -a "$force" == '-f' ] ; then
        force=true
    fi
    local disk=$(virsh domblklist $vmname | awk 'NR==3 {print  $2}')
    if ! virsh domstate $vmname | grep 'shut off' ; then
        virsh destroy $vmname
    fi
    virsh undefine $vmname
    if [ "$force" == "true" ] ; then
        rm $disk -f
    else
        rm $disk
    fi
}
