#!/bin/bash

echo "HeroCC's Ubuntu (16.04) Server Setup script!"
echo "This is aimed at the Ubuntu 14.04 Proxmox template"
packagesToInstall="curl git ntp unattended-upgrades"

function main {
  ## INSTALL REGULAR PACKAGES
  echo "Installing: $packagesToInstall"
  sudo apt-get install $packagesToInstall

  ## Setting Timezone
  echo "Setting Timezone to America/New_York (EST) with DST"
  timedatectl set-timezone America/New_York

  ## Generating en_US and en_US.UTF8 localization
  echo "Generating en_US and en_US.UTF-8 localizations"
  sudo locale-gen en_US en_US.UTF-8
  sudo dpkg-reconfigure locales
  echo "Supported Locales: $(cat /var/lib/locales/supported.d/local)"

  ## Configure Unattended Upgrades
  echo "Please select YES to automatically install security packages"
  sudo dpkg-reconfigure unattended-upgrades

  ## Prompting for dotfiles install
  echo "Do you want to install personal dotfiles? [Y/n]"
  read installDotfiles
  if [ "$installDotfiles" = y ] || [ "$installDotfiles" = Y ] || [ -z "$installDotfiles" ]; then
    git clone https://github.com/HeroCC/dotfiles.git ~/.dotfiles && ~/.dotfiles/install.sh
    echo "Dotfiles Install finished"
  fi
}

main "$@"
