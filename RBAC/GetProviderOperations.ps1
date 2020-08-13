Clear-Host
 
$Provider = "Microsoft.Network/*"
 
Write-Host ""
Write-Host "Provider:" $Provider
Write-Host ""
 
$ProviderOperations = Get-AzProviderOperation $Provider | Select-Object -Property ResourceName,Operation,OperationName | Sort-Object ResourceName,OperationName
foreach ($Op in $ProviderOperations) {
    Write-Host "ResourceName:" $Op.ResourceName
    Write-Host "Operation   :" $Op.Operation
    Write-Host "Description :" $Op.OperationName    
    Write-Host ""
}
