$Prompt = Read-Host -Prompt "Do you want to reboot now? [Y/n] "

if (($Prompt -eq "Y") -or ($Prompt -eq "y") -or ($Prompt -eq "")) {
    Write-Host "True"
}
else {
    Write-Host "False" `
        -ForegroundColor Red -BackgroundColor Gray
}