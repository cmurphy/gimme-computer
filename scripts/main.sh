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
        echo "got image"
    ;;
    'vm')
        echo "got vm"
    ;;
    'ssh')
        echo "got ssh"
    ;;
    'clean')
        echo "got clean"
    ;;
    *)
        invalid_command $command
    ;;
    esac
}
