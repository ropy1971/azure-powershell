##### FUNCTIONS #####
function Init {
    $SubscriptionName = ""
    $Location = "francecentral"
    $PublisherName = "Infoblox"

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
            GetImageOffers
        }
        else {
            Write-Host "[error] Subscription $SubscriptionId Id has not been set. "
        }
    }
    else {
        Write-Host "[error] Subscription $Subscription has been found. "
    }
}

function GetImageOffers {
    $ImageOffers = Get-AzVMImageOffer -Location $Location -PublisherName $PublisherName | Select-Object -Property Offer,PublisherName | Sort-Object -Property Offer
    if($ImageOffers) {
        Write-Host "[info] Offers for $PublisherName have been found. "
        $FileName = $PublisherName + "_Image_Offers.txt"
        $ImageOffers | Out-File $FileName
        Write-Host "[info] Offers for $PublisherName have been saved in $FileName "
    }
    else {
        Write-Host "[error] Offers for $PublisherName have not been found. "
    }
}

##### INIT #####
Clear-Host
Write-Host " "
Init
Write-Host " "
