#!/bin/bash
cd $HOME/.dotfiles
git submodule foreach git pull origin master

#ZSH
echo "Installing ZSH Config"
ln -s ~/.dotfiles/zsh ~/.zsh
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv

#git
echo "Installing Git Config"
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

#Screen
echo "Installing Screen Config"
ln -s ~/.dotfiles/screen/screenrc ~/.screenrc

#SSH
echo "Installing SSH Config"
ln -s ~/.dotfiles/ssh/config ~/.ssh/config

#Gem
echo "Installing Gem Config"
ln -s ~/.dotfiles/gem/gemrc ~/.gemrc

#Sublime 3
echo "Installing Sublime Text 3 Config"
mv ~/.config/sublime-text-3/Packages/User ~/.dotfiles/sublimetext/User
cd ~/.config/sublime-text-3/Packages/
ln -s ~/.dotfiles/sublimetext/User User

#VIM
echo "Installing VIM config"
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc

echo "Do you want to install OhMyZSH"
read update_Ohmy
if [ "$update_Ohmy" == y ]; then
    curl -L http://install.ohmyz.sh | sh
fi

echo "Do you want to install Ruby"
read update_Ruby
if [ "$update_Ruby" == y ]; then
    sudo apt-get install ruby-full
fi

echo "Do you want to install Vundle for Vim?"
read update_Vundle
if [ "$update_Vundle" == y ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi