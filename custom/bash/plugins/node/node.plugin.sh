#!/usr/bin/env bash

setup_nodemirror() {
    export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
}

setup_node_env() {
    export PATH=$PATH:/usr/local/node/bin:~/.npm_global/npm/bin
    npm config set prefix "~/.npm_global/npm"
}

# fnm stuff

setup_fnm() {
    case ":${PATH}:" in
    *:"$HOME/.fnm":*) ;;

    *)
        export FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
        export PATH="$HOME/.fnm:$PATH"
        eval "$(fnm env)"
        ;;
    esac
}

# nvm stuff
setup_nvm() {
    case ":${PATH}:" in
    *:"$HOME/.nvm":*) ;;

    *)
        # export NVM_NODEJS_ORG_MIRROR="https://nodejs.org/dist"
        export NVM_NODEJS_ORG_MIRROR="https://unofficial-builds.nodejs.org/download/release"
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
        ;;
    esac
}

# deno stuff
setup_deno() {
    case ":${PATH}:" in
    *:"$HOME/.deno":*) ;;

    *)
        export DENO_INSTALL="$HOME/.deno"
        export DVM_DIR="$HOME/.dvm"
        export PATH="$DVM_DIR/bin:$DENO_INSTALL/bin:$PATH"
        ;;
    esac
}

setup_nodemirror
setup_node_env
