##### FUNCTIONS #####
function Init {
    $SubscriptionName = "LVMH_IT"
    $ResourceGroupName = ""
    $Location = "francecentral"
    
    CheckSubscription
}

function CheckSubscription {
    $Subscription = Get-AzSubscription -Name $SubscriptionName
    if($Subscription) {
        Write-Host "[info] Subscription $SubscriptionName has been found. "
        $SubscriptionId = $Subscription.Id
        if($SubscriptionId) {
            Write-Host "[info] Subscription Id has been set. "
            Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
            Write-Host "[info] Azure context has been set. "
        }
        else {
            Write-Host "[error] Subscription Id has not been set. "
        }
    }
    else {
        Write-Host "[error] Subscription $Subscription has been found. "
    }
}

function GetPublishers {
    Get-AzVMImagePublisher -Location $Location | Sort-Object -Property PublisherName     
}

##### INIT #####
Clear-Host
Write-Host " "
Init
Write-Host " "
