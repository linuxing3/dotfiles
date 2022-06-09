#=============================================================================
# install-vim.sh --- bootstrap script for Vim
# Copyright (c) 2016-2017 Linuxing3 & Contributors
# Author: Linuxing3
# License: GPLv3
#=============================================================================

echo "==========================================================="
echo "vim, one of the best editors"
echo "==========================================================="


customize_spacevim() {
	sed -i 's/gruvbox/SpaceVim/g' ~/.SpaceVim.d/init.toml
	echo "

[[layers]]
  name = 'fzf'

[[layers]]
  name = 'lang#python'
  enable_typeinfo=true
  format_one_save=1

[[layers]]
  name = 'lang#sh'

[[layers]]
  name = 'format'

[[layers]]
  name = 'debug'
" >>~/.SpaceVim.d/init.toml
}

option=$(dialog --title " Spacevim 一键安装自动脚本" \
	--checklist "请输入:" 20 70 5 \
	"1" "neovim, modern vim style editor" 0 \
	"2" "SpaceVim, Full dark side editor" 0 \
	"3" "space-vim, yet another dist, but ligther" 0 \
	"4" "fisa-vim, with python support" 0 \
	"5" "micro, go editor" 0 \
	3>&1 1>&2 2>&3 3>&1)

cd
cp .vimrc .vimrc.old
rm -rf ~/.vim

case "$option" in
1)
        sudo apt install snap -y
        sudo snap install neovim
	export PATH=$PATH:/snap/bin
	red "Add to path:"
	red "           export PATH=$PATH:/snap/bin"

	git clone git@github.com:linuxing3/nvim ~/.config/nvim

	nvim +PackerSync
2)
	sudo apt-get install -y vim
	curl -fsSL https://spacevim.org/install.sh | bash
	customize_spacevim
	;;
3)
	sudo apt-get install -y vim
	curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh | bash
	;;
4)
	sudo apt-get install -y vim
	curl -fsSL https://raw.githubusercontent.com/fisadev/fisa-vim-config/v12.0.1/config.vim -o ~/.vimrc
	;;
5)
	curl https://getmic.ro | bash
	mv micro /usr/local/bin/
	echo "micro -plugin install comment"
	echo "micro -plugin install editorconfig"
	echo "micro -plugin install go"
	echo "micro -plugin install fzf"
	echo "micro -plugin install filemanager"
	echo "micro -plugin install scratch"
	echo "micro -plugin install fmt"
	echo "micro -plugin install snippets"
	echo "micro -plugin install nordcolors"
	echo "micro -plugin install bookmark"
	;;
*)
	echo "Skipped!"
	;;
esac
