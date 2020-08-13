# désactivation IESC 
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

# désactivation de Server Manager console à l'ouverture de session 
Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask 

# désactivation de UAC 
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000

# modification du service NET TCP Port sharing et démarrage 
Set-Service -Name NetTcpPortSharing -StartupType Automatic 
Start-Service -Name NetTcpPortSharing 

# ajout des ports Firewall 
New-NetFirewallRule -DisplayName "Allow inbound Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 1433" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 4515" -Direction Inbound -LocalPort 4515 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 4520" -Direction Inbound -LocalPort 4520 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow inbound Port 20000" -Direction Inbound -LocalPort 20000 -Protocol TCP -Action Allow 

# Initialisation du disque de données
$disks = Get-Disk | Where-Object partitionstyle -eq 'raw' | Sort-Object number
$letters = 70..89 | ForEach-Object { [char]$_ }
$count = 0
$labels = "Data01","Data02"

foreach ($disk in $disks) {
    $driveLetter = $letters[$count].ToString()
    $disk | 
    Initialize-Disk -PartitionStyle MBR -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $driveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel $labels[$count] -Confirm:$false -Force
    $count++
}

# création du répertoire pour copier les sources en local 
New-Item -Path "C:\" -Name "Sources" -ItemType "directory"
New-Item -Path "C:\Sources" -Name "SQLEXPRESS2017" -ItemType "directory"
New-Item -Path "C:\Sources" -Name "SSSMS" -ItemType "directory"

# montage du Azure File Share

# copie des sources
Copy-Item "S:\SQLEXPRESS2017\*.*" -Destination "C:\Sources\SQLEXPRESS2017" -Force
Copy-Item "S:\SSMS\*.*" -Destination "C:\Sources\SSMS" -Force
Copy-Item "S:\SCRIPTS\*.*" -Destination "C:\Sources" -Force
