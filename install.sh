#!/bin/bash
cd $HOME/.dotfiles
git pull origin master
git submodule update --init

function update {
	echo Do you want to update $1
	read update
	if [ "$update" == y ]; then
		sudo apt-get install $1
	fi
}

#ZSH
update zsh
echo "Installing ZSH Config"
ln -s ~/.dotfiles/zsh ~/.zsh
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv
chsh -s $(which zsh)

echo "Do you want to install OhMyZSH"
read update_ohmy
if [ "$update_ohmy" == y ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
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

echo "Do you want to install Vundle for Vim?"
read update_Vundle
if [ "$update_Vundle" == y ]; then
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
