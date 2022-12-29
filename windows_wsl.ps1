#
# Powershell script to setup remainders on windwos and run ubuntu-setup script
#

#############
# Variables #
#############
$TerminalFont = "DejaVu Sans Mono for Powerline"
$MemoryLimit = "6GB"

##################################################

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

Write-Host "Install fonts..." -ForegroundColor Green
$fontSourceFolder = ".\fonts\"
foreach($FontFile in Get-ChildItem $fontSourceFolder -Include '*.ttf','*.ttc','*.otf' -recurse ) {
	$targetPath = Join-Path $SystemFontsPath $FontFile.Name
	if(Test-Path -Path $targetPath){
		$FontFile.Name + " already installed"
	}
	else {
		"Installing font " + $FontFile.Name
		
		#Extract Font information for Reqistry 
		$ShellFolder = (New-Object -COMObject Shell.Application).Namespace($fontSourceFolder)
		$ShellFile = $ShellFolder.ParseName($FontFile.name)
		$ShellFileType = $ShellFolder.GetDetailsOf($ShellFile, 2)

		#Set the $FontType Variable
		If ($ShellFileType -Like '*TrueType font file*') {$FontType = '(TrueType)'}
			
		#Update Registry and copy font to font directory
		$RegName = $ShellFolder.GetDetailsOf($ShellFile, 21) + ' ' + $FontType
		New-ItemProperty -Name $RegName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $FontFile.name -Force | out-null
		Copy-item $FontFile.FullName -Destination $SystemFontsPath
		"Done"
	}
}

Write-Host "Set Windows Terminal default font to ${TerminalFont}..." `
    -ForegroundColor Green

$TerminalFolder = `
    $(Get-ChildItem -Path $(Join-Path ${env:LOCALAPPDATA} "Packages") `
    -Directory -Name `
    | findstr WindowsTerminal)

$JsonFile = Join-Path "${env:LOCALAPPDATA}\Packages\${TerminalFolder}" `
    "LocalState/settings.json"
Write-Host ${JsonFile} -ForegroundColor Green

$JsonObj = Get-Content $JsonFile -raw | ConvertFrom-Json
$JsonObj.profiles.defaults.font.face = ${TerminalFont}

$JsonObj | ConvertTo-Json -depth 32 | set-content $JsonFile

Write-Host "Set wsl2 memory limit to ${MemoryLimit}" `
    -ForegroundColor Green
$WslConf = Join-Path ${env:UserProfile} ".wslconfig"

if(Test-Path -Path $WslConf) {
    Write-Host ".wslconfig already exists. Overwriting content..." `
        -ForegroundColor Red
}
else {
    Write-Host "Create .wslconfig in ${env:UserProfile}..." `
        -ForegroundColor Green
        New-Item $WslConf
}

Set-Content $WslConf `
@"
[wsl2]
memory=${MemoryLimit}
swap=0
"@


Write-host "Downloading Ubuntu package..." -ForegroundColor Green
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
