#!/bin/bash

function runAnsible {
    cd "$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
    ./run-ansible.sh
}

function has {
    command -v "$1" &> /dev/null
}

function installAnsible {
    if has apt-get && ! has ansible-playbook; then
        sudo apt-get install -y ansible
    fi
}

function main {
    installAnsible
    runAnsible
}

main "$@"
