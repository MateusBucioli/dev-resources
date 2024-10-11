for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt remove $pkg; done

sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo bash -c 'echo "[network]" > /etc/wsl.conf'
sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo chattr +i /etc/resolv.conf

sudo apt update -y && sudo apt upgrade -y

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy 
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo service docker start

# Para testar a instalação utilize o comando abaixo
  # sudo docker run hello-world

# Caso queira instale o portainer https://docs.portainer.io/start/install-ce/server/docker/wsl
  # docker volume create portainer_data
  # docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Configurando docker sem sudo
# Execute o comando `sudo visudo`
# No arquivo aberto insira `<USUARIO> ALL=(ALL) NOPASSWD: /usr/bin/dockerd` alterando <USUARIO> para seu usuario do linux
# Salve e feche o arquivo
# Execute o comando `sudo usermod -a -G docker $USER`
# Reinicie o wsl (saindo com exit e no Windows execute `wsl --shutdown`

# Caso queira que o Docker inicie com o wsl, execute as instrucoes abaixo (caso esteja usando zsh, troque o bashrc por zshrc)
  # echo  >> ~/.bashrc  
  # echo '# Start Docker daemon automatically when logging in if not running.' >> ~/.bashrc
  # echo 'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.bashrc
  # echo 'if [ -z "$RUNNING" ]; then' >> ~/.bashrc
  # echo '    sudo dockerd > /dev/null 2>&1 &' >> ~/.bashrc
  # echo '    disown' >> ~/.bashrc
  # echo 'fi' >> ~/.bashrc
