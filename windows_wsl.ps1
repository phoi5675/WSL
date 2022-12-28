#
# Powershell script to setup remainders on windwos and run ubuntu-setup script
#

Write-Host "Install Terminal..." `
    -ForegroundColor Green
curl.exe -L -o terminal.msixbundle `
    https://github.com/microsoft/terminal/releases/download/v1.15.3465.0/Microsoft.WindowsTerminal_Win10_1.15.3465.0_8wekyb3d8bbwe.msixbundle
Add-AppxPackage -Path ./terminal.msixbundle

Write-host "Downloading wsl_update_x64.msi..." `
    -ForegroundColor Green
curl.exe -L -o wsl_update_x64.msi `
    https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

Write-host "Installing Linux kernel package..." -ForegroundColor Green
.\wsl_update_x64.msi

wsl --set-default-version 2

# Write-Host "Downloading Ubuntu.appx..."
# curl.exe -L -o ubuntu.appx `
#     https://aka.ms/wslubuntu
# Write-Host "Install ubuntu.appx..."
# Add-AppxPackage .\ubuntu.appx

Write-host "Downloading Ubuntu package..."
Write-host "You can download other images at https://cloud-images.ubuntu.com/wsl/" `
    -ForegroundColor Green
curl.exe -L -o ubuntu.tar.gz `
    https://cloud-images.ubuntu.com/wsl/jammy/current/ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz

Write-Host "Create directory for wsl disk..."
New-Item Dist -ItemType Directory

Write-host "Installing Ubuntu..." -ForegroundColor Green
wsl --import Ubuntu .\Dist\ .\ubuntu.tar.gz

Write-Host "Open ubuntu and execute setup script for ubuntu..."
wsl -d Ubuntu `
    -u root `
    bash ubuntu.sh
