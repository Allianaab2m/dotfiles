# dotfiles

## Using tools

- [chezmoi](https://chezmoi.io) for managing dotfiles
- [Sheldon](https://sheldon.cli.rs) for managing zsh plugin, configs
- [mise](https://mise.jdx.dev) for managing programming language versions
- [starship](https://starship.rs) for prompt decoration
- [Rust](https://rust-lang.org)

Sheldon managing:

- [starship](https://starship.rs) init hook
- [mise](https://mise.jdx.dev) init hook
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- Other zsh configs(alias, path, etc...)

mise managing:

- [Node.js](https://nodejs.org/) v20 LTS
- [Deno](https://deno.com/) latest
- [Bun](https://bun.sh/) latest
- [Go](https://go.dev/) latest
- [ghq](https://github.com/x-motemen/ghq) latest

Rust(cargo install/binstall) managing:

- [bat](https://github.com/sharkdp/bat) for replace `cat`
- [eza](https://github.com/eza-community/eza) for replace `ls`
- [ripgrep](https://github.com/BurntSushi/ripgrep) for replace `grep`
- [delta](https://github.com/dandavision/delta) for replace `git diff` view
- [starship](https://starship.rs)

## Installation

### 1. Install zsh

Ubuntu/Debian

```sh
sudo apt install zsh
chsh -s $(which zsh)
```
Arch

```sh
sudo pacman -S zsh
chsh -s $(which zsh)
```

### 2. Install necessary tools

chezmoi
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
~/.local/bin/chezmoi init --apply Allianaab2m
```

Rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-binstall
```

Sheldon

```sh
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

```

mise
```sh
curl https://mise.run | sh
```

### 3. Install other tools

```sh
cargo binstall bat
cargo binstall ripgrep
cargo binstall eza
cargo binstall delta
cargo binstall starship

```

### 4. (Optional) Build Neovim

See also: [neovim/BUILD.md](https://github.com/neovim/neovim/blob/master/BUILD.md)

Ubuntu/Debian
```sh
sudo apt install ninja-build gettext cmake unzip curl build-essential
```

Arch
```sh
sudo pacman -S base-devel cmake unzip ninja curl
```

```sh
ghq get neovim/neovim
cd ghq/github.com/neovim/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```
