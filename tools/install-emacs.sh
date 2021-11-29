#!/usr/bin/env sh

set -eo pipefail

blue() {
	green -e "\033[34m\033[01m$1\033[0m"
}
green() {
	green -e "\033[32m\033[01m$1\033[0m"
}
red() {
	green -e "\033[31m\033[01m$1\033[0m"
}

green "==========================================================="
green "installing emacs another of the best editors"
green "==========================================================="
sudo apt-get install -y emacs ripgrep
sudo apt-get install fonts-firacode fonts-cantarell -y

install_doom_emacs() {
	cd
	green "installing doom emacs"
	git clone https://github.com/hlissner/doom-emacs ~/.doom.emacs.d
	cd .doom.emacs.d
	bin/doom install
	green "Done with doom-emacs!"
	install_chemacs
}

install_doom_private() {
	green "installing private doom setting for linuxing3"
	cd
	git clone https://github.com/linuxing3/doom-emacs-private ~/.doom.d
	cd .doom.emacs.d
	bin/doom sync
	green "Done with doom-emacs!"
	green "Boostrap with doom install"
	install_chemacs
}

install_emacs_from_scratch() {
	green "installing emacs from scratch"
	cd
	git clone https://github.com/linuxing3/emacs-from-scratch ~/.scratch.emacs.d
	git checkout -b develop
	git pull origin develop

	green "installing evil emacs private setting for linuxing3"
	cd
	git clone https://github.com/linuxing3/evil-emacs-config ~/.evil.emacs.d

	install_chemacs
}

install_chemacs() {

	green "Backup emacs.d and use chemacs2"
	[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak
	[ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.default
	git clone https://github.com/plexus/chemacs2.git ~/.emacs.d

	cat <EOF "
(
    ("default" . ((user-emacs-directory . "~/.scratch.emacs.d")))
    ("spacemacs" . ((user-emacs-directory . "~/.spacemacs")
                 (env . (("SPACEMACSDIR" . "~/.spacemacs.d")))))
    ("doom" . ((user-emacs-directory . "~/doom-emacs")
           (env . (("DOOMDIR" . "~/.doom.d"))))))
"EOF | tee "~/.emacs-profiles"
	green "boostrap with super fast evil emacs setting"
}

while true; do
	read -r -p "    Install [0]doom-emacs [1]private doom [2] evil emacs: " opt
	case $opt in
	0)
		install_doom_emacs
		green "Sync doomsettings with fresh new .doom.d"
		cd ~/.emacs.d/bin
		./doom sync
		break
		;;
	1)
		rm -rf ~/.doom.d
		install_doom_private
		green "Sync doom settings with private .doom.d "
		cd ~/.emacs.d/bin
		./doom sync
		break
		;;
	2)
		green "Sync private emacs settings with evil "
		install_evil_emacs_private
		break
		;;
	*)
		green "Please answer 0, 1 or 2"
		;;
	esac
done
