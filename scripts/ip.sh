#!/usr/bin/env bash

source ${SCRIPTDIR}/defaults.sh

ip_vm() {
    local vmname=$1
    local vmip=$(virsh domifaddr $vmname | awk 'NR==3 {print $4}')
    echo ${vmip%/24}
}
