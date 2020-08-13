Get-AzRoleDefinition | ? {$_.IsCustom -eq $true} | Format-Table Name, IsCustom
