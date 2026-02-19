#!/bin/bash

function pull {
  cd $DOTFILE_DIR
  git pull origin master
  git submodule init
  git submodule update
  # git submodule foreach git submodule update --init
  # git submodule foreach update --init
}

function runAnsible {
    cd $DOTFILE_DIR
    ./run-ansible.sh
}

function main {
    DOTFILE_DIR="$HOME/.dotfiles"
    [ "$USER" == "travis" ] && DOTFILE_DIR="$(pwd)"
    pull
    runAnsible
}

main "$@"
