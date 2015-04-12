#!/bin/bash

function pull {
  cd $DOTFILE_DIR
  git pull origin master
  git submodule foreach git submodule update --init
  # git submodule foreach update --init
}

function update {
  if [ "$autoUpdate" == 'true' ]; then
    sudo apt-get install $1
  else
   echo Do you want to update $1
   read update
   if [ "$update" == y ]; then
    sudo apt-get install $1
  fi
fi
}

function installConfigs {
  #ZSH
  update zsh
  echo "Installing ZSH Config"
  ln -s ~/.dotfiles/zsh ~/.zsh
  ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
  ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  if [ "$CI" == "false" ]; then
    chsh -s $(which zsh)
  fi

  #git
  update git
  echo "Installing Git Config"
  ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

  #Screen
  update screen
  echo "Installing Screen Config"
  ln -s ~/.dotfiles/screen/screenrc ~/.screenrc

  #SSH
  update openssh-client
  update openssh-server
  echo "Installing SSH Config"
  mkdir ~/.dotfiles/ssh/
  ln -s ~/.dotfiles/ssh/config ~/.ssh/config

  #Gem
  update ruby-full
  echo "Installing Gem Config"
  ln -s ~/.dotfiles/gem/gemrc ~/.gemrc
  echo Installing Rbenv
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  #Sublime 3
  echo "Installing Sublime Text 3 Config"
  mkdir ~/.config/sublime-text-3/Packages/
  cd ~/.config/sublime-text-3/Packages/
  ln -s ~/.dotfiles/sublimetext/User User

  #Terminator
  echo "Installing Terminator Config"
  mkdir ~/.config/terminator/config
  ln -s ~/.dotfiles/terminator/config ~/.config/terminator/config
  update terminator


  #VIM
  update vim
  echo "Installing VIM config"
  ln -s ~/.dotfiles/vim ~/.vim
  ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
  ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

}

function main {
  autoUpdate='false'
  noInstall='false'

  while getopts 'nu' flag; do
    case "${flag}" in
      n) noInstall='true' ;;
u) autoUpdate='true' ;;
*) error "Unexpected option ${flag}" ;;
esac
done

if [ "$USER" == "travis" ]; then
  CI='true'
  DOTFILE_DIR="$HOME/HeroCC/dotfiles"
fi

if [ "$noInstall" == 'true' ]; then
  pull
elif [ "$noInstall" == 'false' ]; then
  pull
  installConfigs
fi
}

main "$@"
