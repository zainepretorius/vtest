# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2204"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3389, host: 53389, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 1880, host: 51880, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 58080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vram = 128
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
$provision_script = <<SCRIPT
export DEBIAN_FRONTEND=noninteractive
sudo add-apt-repository --yes "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
add-apt-repository ppa:ondrej/php -y
wget -qO - https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo curl -fsSL https://code-server.dev/install.sh | sh
apt-get update 
apt-get install -y apache2 software-properties-common apt-transport-https ubuntu-desktop net-tools xrdp code nodejs firefox php7.4 python3
sudo npm install -g --unsafe-perm node-red node-red-admin

echo [Unit] >/etc/systemd/system/node-red.service
echo "Description=Node-RED" >>/etc/systemd/system/node-red.service
echo "After=syslog.target network.target" >>/etc/systemd/system/node-red.service
echo "" >>/etc/systemd/system/node-red.service
echo "[Service]" >>/etc/systemd/system/node-red.service
echo "ExecStart=/usr/local/bin/node-red-pi --max-old-space-size=128 -v" >>/etc/systemd/system/node-red.service
echo "Restart=on-failure" >>/etc/systemd/system/node-red.service
echo "KillSignal=SIGINT" >>/etc/systemd/system/node-red.service
echo "" >>/etc/systemd/system/node-red.service 
echo "# log output to syslog as ‘node-red’" >>/etc/systemd/system/node-red.service
echo "SyslogIdentifier=node-red" >>/etc/systemd/system/node-red.service
echo "StandardOutput=syslog" >>/etc/systemd/system/node-red.service
echo "" >>/etc/systemd/system/node-red.service 
echo "# non-root user to run as" >>/etc/systemd/system/node-red.service
echo "WorkingDirectory=/home/vagrant/" >>/etc/systemd/system/node-red.service
echo "User=vagrant" >>/etc/systemd/system/node-red.service
echo "Group=vagrant" >>/etc/systemd/system/node-red.service
echo "" >>/etc/systemd/system/node-red.service
echo "[Install]" >>/etc/systemd/system/node-red.service
echo "WantedBy=multi-user.target" >>/etc/systemd/system/node-red.service

sudo systemctl start node-red
systemctl --user enable --now code-server

SCRIPT

  config.vm.provision "shell", inline: $provision_script

end