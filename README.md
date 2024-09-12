# dotfiles

Ubuntu
```sh
apt update
apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply Allianaab2m
```

## 1Password
```sh
eval $(op signin)
```

## Docker
```sh
# Add Docker's official GPG Key:
sudo apt update
sudo apt install ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
    "dev [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER
```
