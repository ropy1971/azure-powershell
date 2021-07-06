Clear-Host
$InputsFile = ".\express_route_operator.json"
New-AzRoleDefinition -InputFile $InputsFile
