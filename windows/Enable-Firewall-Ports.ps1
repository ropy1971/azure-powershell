New-NetFirewallRule -DisplayName "Allow inbound Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 4515" -Direction Inbound -LocalPort 4515 -Protocol TCP -Action Allow 
New-NetFirewallRule -DisplayName "Allow inbound Port 4520" -Direction Inbound -LocalPort 4520 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow inbound Port 20000" -Direction Inbound -LocalPort 20000 -Protocol TCP -Action Allow 
 