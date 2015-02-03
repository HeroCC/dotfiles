Hello! This respository is a compilation of many of my configs and dotfiles
My Main OS is Ubuntu (14.04 ATM), and settings will be tuned to that platform, as well as some for other OSes

#Update & Install
	$ git clone git://github.com/HeroCC/dotfiles.git ~/.dotfiles && cd ~/.dotfiles

This clones the respository, and CDs into it

To install automatically, run:

	$ ./install.sh

If you want to do it manually, than follow the instructions below...

---

#Setup:
##ZSH:
This particular setup uses a combination of, [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) and [ze-best-zsh-config](https://github.com/spicycode/ze-best-zsh-config)

	$ ln -s ~/.dotfiles/zsh ~/.zsh
	$ ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
	$ ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv
And if you want to use Oh-My-ZSH:

	$ curl -L http://install.ohmyz.sh | sh

##GIT:
	$ ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
	$ ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

##SCREEN:
	$ ln -s ~/.dotfiles/screen/screenrc ~/.screenrc

##SSH:
	$ ln -s ~/.dotfiles/ssh/config ~/.ssh/config

##GEM:
	$ ln -s ~/.dotfiles/gem/gemrc ~/.gemrc

##Sublime Text (3):
This may be different on a Mac

	$ mv ~/.config/sublime-text-3/Packages/User ~/.dotfiles/sublimetext/User
	$ cd ~/.config/sublime-text-3/Packages/
	$ ln -s ~/.dotfiles/sublimetext/User User

##VIM:
	$ ln -s ~/.dotfiles/vim ~/.vim
	$ ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
	$ ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc

If Vundle is not installed:

	$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

---

#Thanks
- [@zanshin](https://github.com/zanshin/dotfiles) - Inspiration & Configs
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) & [ze-best-zsh-config](https://github.com/spicycode/ze-best-zsh-config) - ZSH Themes and Config