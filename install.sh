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
  ln -s $DOTFILE_DIR/zsh ~/.zsh
  ln -s $DOTFILE_DIR/zsh/zshrc ~/.zshrc
  ln -s $DOTFILE_DIR/zsh/zshenv ~/.zshenv
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  if [ "$CI" == "false" ]; then
    chsh -s $(which zsh)
  fi

  #git
  update git
  echo "Installing Git Config"
  ln -s $DOTFILE_DIR/git/gitconfig ~/.gitconfig
  ln -s $DOTFILE_DIR/git/gitignore_global ~/.gitignore_global

  #Screen
  update screen
  echo "Installing Screen Config"
  ln -s $DOTFILE_DIR/screen/screenrc ~/.screenrc

  #SSH
  update openssh-client
  update openssh-server
  echo "Installing SSH Config"
  mkdir $DOTFILE_DIR/ssh/
  ln -s $DOTFILE_DIR/ssh/config ~/.ssh/config

  #Gem
  update ruby-full
  echo "Installing Gem Config"
  ln -s $DOTFILE_DIR/gem/gemrc ~/.gemrc
  echo Installing Rbenv
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  #Sublime 3
  echo "Installing Sublime Text 3 Config"
  mkdir ~/.config/sublime-text-3/Packages/
  cd ~/.config/sublime-text-3/Packages/
  ln -s $DOTFILE_DIR/sublimetext/User User

  #Terminator
  echo "Installing Terminator Config"
  mkdir ~/.config/terminator/config
  ln -s $DOTFILE_DIR/terminator/config ~/.config/terminator/config
  update terminator


  #VIM
  update vim
  echo "Installing VIM config"
  ln -s $DOTFILE_DIR/vim ~/.vim
  ln -s $DOTFILE_DIR/vim/vimrc ~/.vimrc
  ln -s $DOTFILE_DIR/vim/gvimrc ~/.gvimrc
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
  DOTFILE_DIR="$(pwd)"
else
  CI='false'
  DOTFILE_DIR="$HOME/.dotfiles"
fi

if [ "$noInstall" == 'true' ]; then
  pull
elif [ "$noInstall" == 'false' ]; then
  pull
  installConfigs
fi
}

main "$@"
