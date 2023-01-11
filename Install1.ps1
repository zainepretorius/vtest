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

if (-not(Test-Path -Path $file -PathType Leaf)) {

# Install chocolatey if it isn't installed yet
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Git VirtualBox and Vagrant
choco install -y vcredist-all virtualbox vagrant cyg-get

# Refresh environment variables
refreshenv

# Download Vagrant install script

# Run the Vagrant script after restart
Write-Host "Changing RunOnce script." -foregroundcolor "magenta"
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\Users\test\test1.ps1")

# Restart Computer
$InputReboot = Read-Host "A Restart is required to continue, Do you wish to reboot now? [y/n]"

Switch ($InputReboot)  {
  'y'   {Restart-Computer}
  'n'   {exit}
}


