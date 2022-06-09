#!/usr/bin/env bash

version=$(dpkg --print-architecture)

install_oh_my_bash() {
    echo "==========================================================="
    echo "installing oh-my-bash"
    echo "==========================================================="
    cd
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    echo "Done!"
}

install_others() {
    echo "==========================================================="
    echo "others: like prettyping"
    echo "==========================================================="
    echo "wget https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping"
    echo "mv prettyping envsetup/bash/bin/"
    echo "chmod +x envsetup/bash/bin/prettyping"

    echo "==========================================================="
    echo "others: like taskbook"
    echo "==========================================================="
    echo "npm install --global taskbook"
}

install_lsp_servers() {

    echo "
-- use the system clipboard
$ yay -S xsel

-- parsing
$ yay -S tree-sitter

-- Fuzzy Finder
$ yay -S fd
$ yay -S sed
$ yay -S ripgrep

-- * neovim rely
$ npm install -g neovim
$ pip3 install neovim

--* Python diagnostics (use Pyright by default)
$ pip3 install pylint

-- * If you use pylint to diagnose Django code, you should install it
$ pip3 install pylint-django

-- * If you use Pyrigth to diagnose Django code, you should install it (Disabled by default)
$ pip3 install django-stubs

-- * Code format
$ yay -S stylua
$ npm install -g bash-language-server
$ npm install -g prettier
$ npm install -g gofmt
$ pip3 install autopep8
$ pip3 install sqlformat

-- * Golang debug
$ yay -S delve

-- * Python debug
$ python3 -m pip install debugpy

-- * Lazygit
$ yay -S lazygit

-- * Translate (you can also use Google or Deepl source, if you do you must install curl)
$ yay -S translate-shell

-- * Markdown preview
$ yay -S pandoc
$ npm install -g live-server

-- * Tabnine require
$ yay -S unzip
$ yay -S curl

-- * Image upload to image bed function
$ npm install picgo -g

-- * mysql client linker
$ yay -S percona-server-clients

-- * Persistent save history yank records
$ yay -S sqlite3

-- * Command-line tool to put files into recycle bin
$ yay -S trash-cli

-- * install shfmt
go install mvdan.cc/sh/v3/cmd/shfmt@latest
"
}
install_beautysh() {
    vvv
    pip install beautysh
}

install_bat() {
    echo "==========================================================="
    echo "Install bat, Another cat"
    echo "==========================================================="
    wget https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_${version}.deb
    sudo dpkg -i bat_0.13.0_${version}.deb
    rm bat_0.13.0_${version}*.deb
}

install_wtf() {
    echo "==========================================================="
    echo "Install wtf, personal information dashboard"
    echo "==========================================================="
    file=wtf_0.35.0_linux_${version}
    wget https://github.com/wtfutil/wtf/releases/download/v0.35.0/${file}.tar.gz
    tar -xvf ${file}.tar.gz
    chmod +x ${file}/wtfutil
    mv ${file}/wtfutil /usr/local/bin/
    rm -rf $file
    rm $file.tar.gz
}

tool_menu() {
    PS3='Please enter your choice: '
    select opt in "install" "tool" "extra" "bash-it" "lsp"; do
        case $opt in
        install)
            install_oh_my_bash
            break
            ;;
        bash-it)
            echo "==========================================================="
            echo "installing bash-it"
            echo "==========================================================="
            cd
            if [[ ! -d ~/workspace/bash-it ]]; then
                mkdir -p ~/workspace/bash-it
                cd ~/workspace/bash-it
                git clone https://github.com/Bash-it/bash-it .
            fi
            break
            ;;

        tool)
            cd
            tools=$(dialog --title " Bash extra tools 安装自动脚本" \
                --checklist "请输入:" 20 70 5 \
                "ncdu" "Disk usage" 0 \
                "htop" "Process Monitor" 0 \
                "fd-find" "Better finder" 0 \
                "fzf" "Better search" 0 \
                "fd" "Other Finder" 0 \
                "exa" "Better ls " 0 \
                "jed" "Another editor " 0 \
                "rip-grep" "Better grep" 0 \
                3>&1 1>&2 2>&3 3>&1)
            for tool in $tools; do
                sudo apt install $tool -y
            done
            break
            ;;

        extra)
            cd
            go install github.com/linuxing3/goful@latest
            install_bat
            install_wtf
            echo "Install startship, cross shell prompts"
            curl -fsSL https://starship.rs/install.sh | bash
            cd
            break
            ;;
        lsp)
            cd
            install_lsp_servers
            ;;
        *)
            echo "Quit"
            break
            ;;
        esac
    done
}

tool_menu
