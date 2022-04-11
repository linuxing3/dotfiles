export OSH=~/.oh-my-bash
OSH_THEME="mairan"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
OSH_CUSTOM=~/.dotfiles/custom/bash
completions=(
  git
  composer
  ssh
  system
)
aliases=(
  general
  vim
)
plugins=(
  bashmarks
  git
  #fzf
  vim
  #nvm
  go
  java
  #rust
  #starship
)
source $OSH/oh-my-bash.sh
PATH=$PATH:/usr/local/toolchain/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin
