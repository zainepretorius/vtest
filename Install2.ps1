$HOMEDRIVE = "C:\"
$HOMEPATH = "Users\" + $env:username
$VAGRANTPATH = "\DEV_VM"

# Run script as Administrator
set-executionpolicy -scope CurrentUser -executionPolicy Bypass -Force
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

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
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zainepretorius/vtest/main/Vagrantfile" -OutFile "$HOME\VagrantFile"

# Provision VM
vagrant up