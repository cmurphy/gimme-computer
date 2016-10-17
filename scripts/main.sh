#!/usr/bin/env bash

help() {
    echo "Available commands are image, vm, ssh, clean."
}

invalid_command() {
    echo "${command} is not a valid command."
    help
}

main() {
    local command=$1
    shift
    case $command in
    'image')
        source $SCRIPTDIR/image.sh
        sudo true # sudo up for later
        create_image "$@"
    ;;
    'vm')
        source $SCRIPTDIR/vm.sh
        create_vm "$@"
    ;;
    'ssh')
        source $SCRIPTDIR/ssh.sh
        ssh_vm "$@"
    ;;
    'clean')
        echo "got clean"
    ;;
    *)
        invalid_command $command
    ;;
    esac
}
