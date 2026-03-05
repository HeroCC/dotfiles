#!/bin/bash

function runAnsible {
    cd "$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
    ./run-ansible.sh
}

function main {
    [ "$USER" == "bits" ] && sudo apt-get install -y ansible
    runAnsible
}

main "$@"
