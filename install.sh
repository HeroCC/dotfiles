#!/bin/bash

function pull {
  cd $DOTFILE_DIR
  git pull origin master
  git submodule init
  git submodule update
  # git submodule foreach git submodule update --init
  # git submodule foreach update --init
}

function update {
  if [ "$noUpdate" == 'false' ]; then
    if [ "$autoUpdate" == 'true' ]; then
      sudo apt-get install "$@"
    elif [ "$autoUpdate" == 'false' ]; then
      echo "Do you want to update $@"
      read update
      if [ "$update" == y ]; then
        sudo apt-get install "$@"
      fi
    fi
  fi
}

function link {
  if [ "$forseLN" = 'true' ]; then
    ln -sf $1 $2
  else
    if [[ -e "$2" ]]; then
      echo "$2 already exists, if it is a symlink it will be deleted"
      if [[ -h "$2" ]]; then
        rm -rf "$2"
        ln -s $1 $2
      else
        echo "Not a symlink, renaming and linking"
        mv -f "$2" "$2_old"
        ln -s $1 $2
      fi
    else
      ln -s $1 $2
    fi
  fi
}

function installConfigs {
  #ZSH
  update zsh
  echo "Installing ZSH Config"
  link $DOTFILE_DIR/zsh ~/.zsh
  link $DOTFILE_DIR/zsh/zshrc ~/.zshrc
  link $DOTFILE_DIR/zsh/zshenv ~/.zshenv
  if [ "$CI" == "false" ] && [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s $(which zsh)
  fi
  echo ""

  #git
  update git
  echo "Installing Git Config"
  link $DOTFILE_DIR/git/gitconfig ~/.gitconfig
  link $DOTFILE_DIR/git/gitignore_global ~/.gitignore_global
  link $DOTFILE_DIR/git/gitattributes ~/.gitattributes
  echo ""

  #Screen
  update screen
  echo "Installing Screen Config"
  link $DOTFILE_DIR/screen/screenrc ~/.screenrc
  echo ""

  # Tmux
  update tmux
  echo "Installing Tmux Config"
  link $DOTFILE_DIR/tmux/tmux.conf ~/.tmux.conf
  echo ""

  #SSH
  update openssh-client
  update openssh-server
  echo "Installing SSH Config"
  mkdir -p ~/.ssh/
  link $DOTFILE_DIR/ssh/config ~/.ssh/config
  echo ""

  #Gem
  update ruby-full
  echo "Installing Gem Config"
  link $DOTFILE_DIR/gem/gemrc ~/.gemrc
  echo Installing Rbenv
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo ""

  #Sublime 3
  echo "Installing Sublime Text 3 Config"
  mkdir -p ~/.config/sublime-text-3/Packages/
  cd ~/.config/sublime-text-3/Packages/
  link $DOTFILE_DIR/sublimetext/User User
  echo ""

  #Terminator
  echo "Installing Terminator Config"
  mkdir -p ~/.config/terminator
  link $DOTFILE_DIR/terminator/config ~/.config/terminator/config
  update terminator
  echo ""

  #VIM
  update vim
  echo "Installing VIM config"
  link $DOTFILE_DIR/vim ~/.vim
  link $DOTFILE_DIR/vim/vimrc ~/.vimrc
  link $DOTFILE_DIR/vim ~/.nvim
  link $DOTFILE_DIR/vim/vimrc ~/.nvimrc
  vim +PluginInstall +qall
  echo ""

  #Gradle
  echo "Installing Gradle Config"
  mkdir -p ~/.gradle/
  link $DOTFILE_DIR/gradle/gradle.properties ~/.gradle/gradle.properties
  echo ""

  #Bin Scripts
  echo "Adding files to bin/"
  mkdir -p "$HOME/bin"
  cd $DOTFILE_DIR/bin
  for filename in $(find . -maxdepth 1 -type f -printf '%f\n')
  do
    link $DOTFILE_DIR/bin/$filename ~/bin/$filename
  done
  echo ""
}

function main {
  autoUpdate='false'
  noLN='false'
  forseLN='false'
  noUpdate='false'

  while getopts 'nufi' flag; do
    case "${flag}" in
      i) noUpdate='true' ;;
n) noLN='true' ;;
u) autoUpdate='true' ;;
f) forseLN='true' ;;
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

if [ "$noLN" == 'true' ]; then
  pull
elif [ "$noLN" == 'false' ]; then
  pull
  installConfigs
fi
}

main "$@"
