export OSH=~/.oh-my-bash
# OSH_THEME="powerline"
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
  fzf
  vim
  nvm
  go
  rust
  starship
)
source $OSH/oh-my-bash.sh
