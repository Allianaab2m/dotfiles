#!/usr/bin/env zsh

set -ue

function init() {
  echo  "┌────────────────────────────────────────────────────────────────────────┐"
  echo "│               Alliana's dotfiles deploy script                         │"
  echo "│                                                                        │"
  echo "│  https://dot.ab2m.link/install                                         │"
  echo "│                                                                        │"
  echo "│Be sure to review the contents of this shell script before proceeding!  │"
  echo "│  https://github.com/Allianaab2m/dotfiles/blob/main/install.sh          │"
  echo "│  https://github.com/Allianaab2m/dotfiles/blob/main/setup.ts            │"
  echo "│                                                                        │"
  echo "│The following tools will be installed:                                  │"
  echo "│  - Rust toolchains(rustup, rustc, cargo)                               │"
  echo "│  - rtx-cli(https://github.com/jdx/rtx)                                 │"
  echo "│  - sheldon(https://sheldon.cli.rs)                                     │"
  echo "│  - ghq(https://github.com/x-motemen/ghq)                               │"
  echo "│                                                                        │"
  echo "│  - Deno@latest                                                         │"
  echo "│  - Node.js@LTS                                                         │"
  echo "│  - Go@latest                                                           │"
  echo "│                                                                        │"
  echo "└────────────────────────────────────────────────────────────────────────┘"
  echo "Do you want to deploy?(y/N)\n"
  if read -q; then
    echo "\n"
    install_rust
    echo "\n"
    install_rtx
    echo "\n"
    install_deno_via_rtx
    echo "\n"
    run_deno_script
    echo "\n"
  else
    echo -e "\e[31m\nDeploy was aborted.\e[m\n"
    exit 1
  fi

}

function install_rust() {
  echo -e "\e[36m> Installing Rust toolchain(rustup, rustc, cargo)...\e[m\n"    

  if ! command -v rustup > /dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo -e "\e[36m>>> Installed Rust toolchain!\e[m\n"    
  else
    echo -e "\e[34m>>> Rust toolchain has been already installed.\e[m\n"    
  fi
  rustup self update
  rustup update
  rustup --version
}

function install_rtx() {
  echo -e "\e[36m> Installing rtx-cli...\e[m\n"    

  if ! command -v rtx > /dev/null 2>&1; then
    cargo install rtx-cli
    echo -e "\e[36m>>> Installed rtx-cli!\e[m\n"    
  else
    echo -e "\e[34m>>> rtx-cli has been already installed.\e[m\n"    
  fi
  rtx --version
  export RTX_DATA_DIR=$HOME/.rtx
  export RTX_CACHE_DIR=$RTX_DATA_DIR/cache
}

function install_deno_via_rtx() {
  echo -e "\e[36m> Installing Deno...\e[m\n"    

  if ! command -v deno > /dev/null 2>&1; then
    rtx install deno@latest
    rtx global deno@latest
    echo -e "\e[36m>>> Installed Deno!\e[m\n"    
  else
    echo -e "\e[34m>>> Deno has been already installed.\e[m\n"    
  fi
  deno --version
}

function run_deno_script() {
  echo -e "\e[36m> Executing Deno script...\e[m\n"    
  if [ ! -e $HOME/dotfiles-alliana/setup.ts ]; then
    git clone -b rework https://github.com/Allianaab2m/dotfiles $HOME/dotfiles-alliana
  fi
  cd $HOME/dotfiles-alliana
  deno run --allow-net --allow-read=. --allow-write=$HOME/.config/,. setup.ts
}

init
