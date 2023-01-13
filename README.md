Install Chocolatly/Vagrant and deploy Ubuntu Dev VM 

Paste the command below into a powershell prompt.

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/zainepretorius/vtest/main/Install1.ps1'))

The script will install the following:

chocolatey and required applications to make chocolatey run.
vcredist-all
virtualbox
vagrant
cyg-get

A reboot is required. After rebooting a second script is run automatically:

iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/zainepretorius/vtest/main/Install2.ps1'))

- Installs vagrant modules
- Creates DEV_VM folder (name of VM)
- Downloads Vagrant file
- Brings up VM


The Vagrant image consists of the following:

- Ubuntu 22.04 + Desktop
- Firefox Browser
- Xrdp
- Python3
- PHP7.4
- Node Red
- Visual Studio
- Ansible


Once installed, you can connect to your VM via RDP or SSH.
