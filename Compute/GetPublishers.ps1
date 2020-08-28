##### FUNCTIONS #####
function Init {
    $SubscriptionName = ""
    $Location = "francecentral"
    
    CheckSubscription
}

function CheckSubscription {
    $Subscription = Get-AzSubscription -SubscriptionName $SubscriptionName -ErrorAction SilentlyContinue
    if($Subscription) {
        Write-Host "[info] Subscription $SubscriptionName has been found. "
        $SubscriptionId = $Subscription.Id
        if($SubscriptionId) {
            Write-Host "[info] Subscription Id $SubscriptionId has been found. "
            Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
            Write-Host "[info] Azure context has been found. "
            GetPublishers
        }
        else {
            Write-Host "[error] Subscription $SubscriptionId Id has not been set. "
        }
    }
    else {
        Write-Host "[error] Subscription $Subscription has been found. "
    }
}

function GetPublishers {
    $ImagePublishers = Get-AzVMImagePublisher -Location $Location | Select-Object -Property PublisherName | Sort-Object -Property PublisherName
    if($ImagePublishers) {
        Write-Host "[info] Publishers have been "
    }
    
    $ImagePublishers | Out-File ImagePublishers.txt
}

##### INIT #####
Clear-Host
Write-Host " "
Init
Write-Host " "
