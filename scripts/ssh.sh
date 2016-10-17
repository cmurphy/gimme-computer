#!/usr/bin/env bash

source ${SCRIPTDIR}/defaults.sh


ssh_cmd() {
  local vm_ip=$1
  shift
  ssh devuser@${vm_ip} -o StrictHostKeyChecking=no "$*"
}

ssh_vm() {
    local vmname=$1
    shift
    local vmip=$(virsh domifaddr $vmname | awk 'NR==3 {print $4}')
    local tries=2
    while [ -z "$vmip" -a "$tries" -gt 0 ] ; do # IP address not assigned yet
        echo "VM is not ready yet. Trying $tries more time(s) in 15 seconds."
        sleep 15
        tries=$((tries-1))
        vmip=$(virsh domifaddr $vmname | awk 'NR==3 {print $4}')
    done
    if [ -z "$vmip" -a "$tries" -eq 0 ] ; then
         echo "Could not reach VM."
         exit 1
    fi
    vmip=${vmip%/24}
    tries=2
    while [ "$tries" -gt 0 ] ; do
        local error=$(ssh_cmd $vmip true 2>&1) # Check for connection refused and try again
        if [[ ! $error =~ .*Connection\ refused.* ]] ; then
            echo "SSHing to $vmip"
            ssh_cmd $vmip "$*"
            break
        else
            echo "SSH is not ready yet. Trying again in 5 seconds."
            sleep 5
        fi
    done
}
