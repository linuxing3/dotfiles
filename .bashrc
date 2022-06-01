export OSH=~/.oh-my-bash
OSH_THEME="font"
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
  snap
  #fzf
  vim
  python
  #nvm
  go
  java
  #rust
  #starship
)
source $OSH/oh-my-bash.sh

