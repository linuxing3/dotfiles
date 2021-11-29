#!/usr/bin/env sh

set -eo pipefail

blue() {
	echo -e "\033[34m\033[01m$1\033[0m"
}
green() {
	echo -e "\033[32m\033[01m$1\033[0m"
}
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}

green "Usage"

green "wget https://raw.githubusercontent.com/linuxing3/dotfiles/main/tools/install-dotfiles.sh && bash install-dotfiles.sh"

install_dotfiles() {

	green "======================="
	blue "Setting awesome env for you"
	green "======================="

	cd

	sudo apt update -y

	sudo apt install -y git curl wget tmux stow

	git clone https://github.com/linuxing3/dotfiles ~/.dotfiles

	cd ~/.dotfiles && git submodule init -- && stow .

	source ~/.profile

	green "======================="
	blue " Dotfiles works, you may init other submodules"
	green "======================="
}

install_bash() {

	cd ~/.dotfiles

	git submodule init .oh-my-bash
	git submodule update .oh-my-bash

	green "======================="
	blue " bash submodules updated"
	green "======================="
}

install_emacs() {

	cd ~/.dotfiles

	git submodule init .scratch.emacs.d
	git submodule update .scratch.emacs.d

	git submodule init .evil.emacs.d
	git submodule update .evil.emacs.d

	git submodule init .emacs.d
	git submodule update .emacs.d

	green "======================="
	blue " emacs submodules updated"
	green "======================="
}

install_vim() {

	cd ~/.dotfiles

	git submodule init .space-vim
	git submodule update .space-vim
	green "======================="
	blue " vim submodules updated"
	green "======================="

}
start_menu() {
	clear
	sleep 2
	option=$(dialog --title " Dotfiles submodules安装脚本" \
		--checklist "请输入:" 20 70 5 \
		"dot" "Manage dotfiles with stow" 0 \
		"bash" "Your shell" 0 \
		"vim" "Your shell" 0 \
		"emacs" "scratch && evil && chemacs" 0 \
		3>&1 1>&2 2>&3 3>&1)
	green "Your choosed the ${option}"
	sleep 2
	case "$option" in
	dot)
		install_dotfiles
		;;
	bash)
		install_bash
		;;
	emacs)
		install_emacs
		;;
	vim)
		install_vim
		;;
	*)
		clear
		exit 1
		;;
	esac
}

start_menu
