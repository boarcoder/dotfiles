#!/bin/bash

# get the type of computer
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  CYGWIN*)    machine=Cygwin;;
  MINGW*)     machine=MinGw;;
  MSYS_NT*)   machine=Git;;
  *)          machine="UNKNOWN:${unameOut}"
esac
log "${machine} > Determined OS type."

log() {
  FILE_DIR=${BASH_SOURCE%/*}
  LOG="$FILE_DIR.log"
  echo "${machine}| ${1} $(date +%Y-%m-%dT%H:%M)" | tee -a "$LOG"    
}

declare -A command_run=(
  ["linux"]=linux 
  ["mac"]=mac
)

run_cmd_for_os() {
  if [ $machine == "Mac" ];then
    /bin/bash -c ${command_run["mac"]}
  fi

  if [ $machine == "Linux" ];then
    /bin/bash -c ${command_run["linux"]}
  fi

  unset command_run["mac"]
  unset command_run["linux"]
}

if [ $machine == "Mac" ];then
  log "Install xcode clt"
  /bin/zsh "${BASH_SOURCE%/*}/install-xcode-clt.sh"

  log "Install brew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ $machine == "Linux" ];then
  log "Install zsh"
  apt update && apt upgrade
  apt install -y wget
  apt install -y ca-certificates
  apt install -y zsh
fi

log "Install stow"
command_run["linux"]="apt install -y stow"
command_run["mac"]="yes| brew install stow"
run_mac_or_linux_cmd

log "Install mise-en-place environment manager (1/3)"
command_run["linux"]='curl https://mise.run | sh'
run_mac_or_linux_cmd

log "Install mise-en-place environment manager (2/3)"
command_run["linux"]='echo '\''eval"$(~/.local/bin/mise activate zsh)"'\'' >> ~/.zshrc'
run_mac_or_linux_cmd

log "Install mise-en-place environment manager (3/3)"
command_run["linux"]='echo '\''export PATH=$HOME/.local/share/mise/shims:$PATH'\'' >> ~/.zprofile"'
run_mac_or_linux_cmd

log "Install vscode"
# If wsl, you need to install in windows instead. Skipping default.
command_run["linux"]="echo skipping vscode." # sudo snap install --classic code
command_run["mac"]="yes| brew install --cask visual-studio-code"
run_mac_or_linux_cmd

log "Install starship (improve zsh)"
command_run["linux"]='sh -c "$(curl -sS https://starship.rs/install.sh)" -s "--yes"'
run_mac_or_linux_cmd

log "Add starship init"
command_run["linux"]='echo '\''eval "$(starship init zsh)"'\'' >> ~/.zshrc'
run_mac_or_linux_cmd

log "Add fonts"
# ZedMono

log "Install exa"
command_run["linux"]='sudo apt install exa'
command_run["mac"]='brew install exa'
run_mac_or_linux_cmd