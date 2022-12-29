#
# Powershell script for presiquites set-up for WSL2 on windows
#

# Enable linux subsystem for windows
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable virtual machine platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

$Prompt = Read-Host -Prompt "Do you want to reboot now? [Y/n] "

if (($Prompt -eq "Y") -or ($Prompt -eq "y") -or ($Prompt -eq "")) {
    Restart-Computer -Confirm:$true
}
else {
    Write-Host "You have to manually reboot to execute remainders!" `
        -ForegroundColor Red -BackgroundColor Gray
}