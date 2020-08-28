##### FUNCTIONS #####
function Init {
    $SubscriptionName = ""
    $Location = "francecentral"
    $PublisherName = "Infoblox"
    $OfferName = "infoblox-vnios-te-v1420"

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
            GetImageSkus
        }
        else {
            Write-Host "[error] Subscription $SubscriptionId Id has not been set. "
        }
    }
    else {
        Write-Host "[error] Subscription $Subscription has been found. "
    }
}

function GetImageSkus {
    $ImageSkus = Get-AzVMImageSku -Location $Location -PublisherName $PublisherName -Offer $OfferName | Select-Object -Property PublisherName,Offer,Skus | Sort-Object -Property Skus
    if($ImageSkus) {
        Write-Host "[info] Skus for $OfferName have been found. "
        $FileName = $PublisherName + "_Image_Skus_" + $OfferName + ".txt"
        $ImageSkus | Out-File $FileName
        Write-Host "[info] Skus for $OfferName have been saved in $FileName "
    }
    else {
        Write-Host "[error] Offers for $OfferName have not been found. "
    }
}

##### INIT #####
Clear-Host
Write-Host " "
Init
Write-Host " "
