$HOMEDRIVE = "C:\"
$HOMEPATH = "Users\" + $env:username
$VAGRANTPATH = "\DEV_VM"

# Install chocolatey if it isn't installed yet
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Git VirtualBox and Vagrant
choco install vcredist virtualbox vagrant cyg-get

# Refresh environment variables
refreshenv

# Install Vagrant Plugins
vagrant plugin install vagrant-winnfsd
vagrant plugin install vagrant-vbguest

# Set and force overwrite of the $HOME variable
Set-Variable HOME "$HOMEDRIVE$HOMEPATH$VAGRANTPATH" -Force

Write-Output $HOME

# Create Vagrant VM Directory - DEV_VM
New-Item -ItemType Directory -Force -Path $HOME

# cd $HOME
Set-Location $HOME

# Download Vagrant File
Invoke-WebRequest -Uri "https://github.com/zainepretorius/vtest/Vagrant" -OutFile "$HOME\VagrantFile"

# Provision VM
vagrant init
