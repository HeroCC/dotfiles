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
  echo "Installing ZSH Config"
  link $DOTFILE_DIR/zsh ~/.zsh
  link $DOTFILE_DIR/zsh/zshrc ~/.zshrc
  link $DOTFILE_DIR/zsh/zshenv ~/.zshenv

#  #git
#  echo "Installing Git Config"
#  link $DOTFILE_DIR/git/gitconfig ~/.gitconfig
  link $DOTFILE_DIR/git/gitignore_global ~/.gitignore_global
  link $DOTFILE_DIR/git/gitattributes ~/.gitattributes
#  echo ""

  # Tmux
  update tmux
  echo "Installing Tmux Config"
  link $DOTFILE_DIR/tmux/tmux.conf ${XDG_CONFIG_HOME:-~/.config}/tmux/tmux.conf
  echo ""

  #SSH
  echo "Installing SSH Config"
  link $DOTFILE_DIR/ssh ~/.ssh
  echo ""

#  if [[ -n "$XDG_CURRENT_DESKTOP" ]]; then
#    #Sublime 3
#    echo "Installing Sublime Text 3 Config"
#    mkdir -p ~/.config/sublime-text-3/Packages/
#    cd ~/.config/sublime-text-3/Packages/
#    link $DOTFILE_DIR/sublimetext/User User
#    echo ""
#  fi

  #VIM
  echo "Installing VIM config"
  link $DOTFILE_DIR/vim ~/.vim
  link $DOTFILE_DIR/vim/vimrc ~/.vimrc
  link ~/.vim ~/.config/nvim
  link ~/.vimrc ~/.config/nvim/init.vim
  #vim +PluginInstall +qall
  #echo ""
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
