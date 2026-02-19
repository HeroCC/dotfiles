#!/bin/bash

function runAnsible {
    ./run-ansible.sh
}

function main {
    [ "$USER" == "bits" ] && sudo apt-get install ansible
    runAnsible
}

main "$@"
