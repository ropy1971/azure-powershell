
##### FUNCTIONS #####
function Init {

    #Connect-AzAccount | Out-Null
    
    Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
    
    $SubscriptionId = ""
    $Location = "westeurope"
    $Count = 0
    
    Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
    Write-Host "[info] AzContext has been set. "
    
    GetPublishers

}

function GetPublishers {

    $AllPublishers = Get-AzVMImagePublisher -Location $Location | Sort-Object -Property PublisherName

    if ($AllPublishers) {

        Write-Host "[info] Publishers have been found. "

        foreach ($Publisher in $AllPublishers) {

            $Publisher.PublisherName

        }

    }
    else {

        Write-Host "[error] Publishers have not been found. "

        Return

    }

}

##### INIT #####
Clear-Host
Init
