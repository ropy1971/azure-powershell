
##### FUNCTIONS #####
function Init {
    Clear-Host
    $TenantId = ""
    $SubscriptionId = ""
    Set-AzContext -Tenant $TenantId -Subscription $SubscriptionId | Out-Null
    GetResourceGroup
}

function GetResourceGroup {    
    $ResourceGroupId = Read-Host "Please enter the Id for Resource Group: "
    Write-Host ""
    Write-Host "*** Resource Group will be tagged. *** "
    Write-Host ""
    if ($ResourceGroupId -ne "") {
        $ResourceGroup = Get-AzResourceGroup -ResourceId $ResourceGroupId -ErrorAction SilentlyContinue
        if ($ResourceGroup) {
            $ResourceGroupName = $ResourceGroup.ResourceGroupName
            $RessourceGroupId = $ResourceGroup.ResourceId
            Write-Host "[info] Resource Group $ResourceGroupName has been found. "
            Set-AzResourceGroup -Id $RessourceGroupId -Tag @{ "Application"=""; "Cost center"=""; "Entity"=""; "Environment"=""; "Location"=""; "Owner"="" } | Out-Null
            Write-Host "[info] Resource Group $ResourceGroupName has been tagged. "
        }
        else {
            Write-Host "[error] Resource Group $ResourceGroupName has not been found. "
        }
    }
    else {
        Write-Host "[error] Resource Group Id cannot be empty. "
    }
}

##### INIT #####
Write-Host ""
Init
Write-Host ""
