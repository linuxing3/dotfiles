#!/usr/bin/env bash

export DATA_DRIVE=$HOME
export CLOUD_SERVICE_PROVIDER=OneDrive
BROWSER=qutebrowser
# EDITOR=emacsclient


alias ed="emacs --daemon"
alias eq="emacs -q"

# emacs client with socker file
alias ecs="emacsclient -n -c -s /run/user/1000/emacs/server -a /usr/bin/emacs"

# emacs client with socker file
alias ecf="emacsclient -n -c -f ~/.emacs.d/server/server -a /usr/bin/emacs"

doomx() {
    export PATH=$PATH:~/.emacs.d/bin
    doom
}

eb() {
    emacs -q --batch -l ~/.emacs.editor --eval="$1"
}
