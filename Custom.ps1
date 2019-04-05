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

# installation de IIS (web-server) 
Install-WindowsFeature -Name Web-Server,Web-WebServer, `
                        Web-Common-Http,Web-Default-Doc,Web-Dir-Browsing,Web-Http-Errors, `
                        Web-Static-Content,Web-Health,Web-Http-Logging,Web-Performance,Web-Stat-Compression, `
                        Web-Security,Web-Filtering,Web-App-Dev,Web-Net-Ext,Web-Net-Ext45,Web-AppInit, `
                        Web-ASP,Web-Asp-Net,Web-Asp-Net45,Web-CGI,Web-ISAPI-Ext,Web-ISAPI-Filter, `
                        Web-Includes,Web-WebSockets,Web-Mgmt-Tools,Web-Mgmt-Compat,Web-Metabase

# ajout des ports Firewall 
New-NetFirewallRule -DisplayName "Allow inbound Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 1433" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 4515" -Direction Inbound -LocalPort 4515 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 4520" -Direction Inbound -LocalPort 4520 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow inbound Port 20000" -Direction Inbound -LocalPort 20000 -Protocol TCP -Action Allow 
                         