#
# Powershell script for presiquites set-up for WSL2 on windows
#

# Enable linux subsystem for windows
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable virtual machine platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Restart-Computer -Confirm:$true