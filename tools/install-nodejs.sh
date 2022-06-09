#!/bin/env bash
echo "==========================================================="
echo "installing node environment for you..."
echo "==========================================================="

setup_nodeenv() {
    export PATH=$PATH:/usr/local/node/bin
    # npm-prefix（可选操作）
    npm config set prefix "$HOME/.npm_global/npm"
}

install_node() {
    sudo curl -sL https://deb.nodesource.com/setup_18.x | bash -
    sudo apt install nodejs
    sudo apt install npm
}

install_nodesource() {
    cd ~/Downloads || exit
    wget https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/v18.3.0/node-v18.3.0-linux-arm64.tar.gz
    sudo tar -C /usr/local -xzf node-v18.3.0-linux-arm64.tar.gz
    setup_nodeenv
}

install_fnm() {
    cd || exit
    echo "installing fnm"
    curl -fsSL https://fnm.vercel.app/install | bash
}

install_nvm() {
    cd || exit
    echo "installing nvm"
    # install 10/11 is not availabe in stretch
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

    # curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
    # sudo apt-get udpate
    # sudo apt-get install -y nodejs
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

    while true; do
        read -r -p "    Install from [0]unofficial [1]official:  " opt
        case $opt in
        0)
            echo "update NVM_NODEJS_ORG_MIRROR to https://unofficial-builds.nodejs.org/download/release"
            export NVM_NODEJS_ORG_MIRROR="https://unofficial-builds.nodejs.org/download/release"
            break
            ;;
        1)
            echo "use default NVM_NODEJS_ORG_MIRROR https://nodejs.org/dist"
            break
            ;;
        *)
            echo "Please answer 0, 1"
            ;;
        esac
    done

    echo "Testing nvm dir exists"
    echo "If you can't run nvm, you may update sh with:"
    echo "source ~/.bashrc"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    echo "installing latest"
    nvm install node
}

install_npm_packages() {
    echo "installing yarn"
    npm i -g yarn
    echo "installing neovim"
    npm i -g neovim
    echo "installing pm2 prettier"
    npm i -g prettier pm2 bash-language-server
}

while true; do
    read -r -p "    Choose [0] fnm [1] nvm [2] test [3] node [4] extra:  " opt
    case $opt in
    0)
        install_fnm
        break
        ;;
    1)
        install_nvm
        break
        ;;
    2)
        setup_nodeenv
        break
        ;;
    3)
        install_node
        break
        ;;
    4)
        install_npm_packages
        break
        ;;
    *)
        echo "Please answer 0, 1"
        ;;
    esac
done
