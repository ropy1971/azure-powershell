##### FUNCTIONS #####
function Init {
    $SubscriptionId = ""
    $ResourceGroupName = ""
    $Location = ""
    $StorageAccountName = ""
    $StorageAccountSku = "Standard_GRS"
    $StorageAccountKind = "StorageV2"
    $StorageContainerName = "prd"

    Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
    
    GenerateString
}

function GenerateString {
    $Number = Get-Random -Maximum 9999
    $StorageAccountName = $StorageAccountName + $Number
    Write-Host "[info] New Storage Account has been identified: $StorageAccountName "
    CheckResourceGroup
}

function CheckResourceGroup {
    $ResourceGroup = Get-AzResourceGroup -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
    if($ResourceGroup) {
        Write-Host "[info] Resource Group has been found. "
        CheckStorageAccount
    }
    else {
        Write-Host "[info] Resource Group has not been found. "
        Write-Host " "
        $CreateResourceGroup = Read-Host "Do you want to create Resource Group? (yes/no)"
        if($CreateResourceGroup -eq "yes"){
            New-AzResourceGroup -ResourceGroupName $ResourceGroupName -Location $Location | Out-Null
            Write-Host "[info] Resource Group has been created. "
            CheckStorageAccount
        }
        else {
            Write-Host "[info] Resource Group is not created (user choice). "
            Return
        }
    }
}

function CheckStorageAccount {
    $StorageAccount = Get-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
    if($StorageAccount) {
        Write-Host "[error] Storage Account has been found with name $StorageAccountName "
        Write-Host "[info] Storage Account must be changed. "
        GenerateString
    }
    else {
        Write-Host "[info] Storage Account has not been found. "
        Write-Host "[info] Storage Account can be created with name: $StorageAccountName "
        New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -Location $Location -SkuName $StorageAccountSku | Out-Null
        Write-Host "[info] Storage Account has been created. "
        $StorageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName)| Where-Object {$_.KeyName -eq "key1"} -ErrorAction SilentlyContinue
        if($StorageAccountKey) {
            Write-Host "[info] Storage Account Key has been found. "
            $StorageAccountKey = $StorageAccountKey.Value
            $StorageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey -ErrorAction SilentlyContinue
            if($StorageContext) {
                Write-Host "[info] Storage Context has been set. "
                New-AzStorageContainer -Name $StorageContainerName -Context $StorageContext -Permission Off | Out-Null
                Write-Host "[info] Storage Container has been created. "
            }
            else {
                Write-Host "[error] Storage Context has not been set. "
            }
        }
        else {
            Write-Host "[error] Storage Account Key has not been found. "
        }
    }    
}

##### INIT #####
Clear-Host
Write-Host " "
Init
Write-Host " "
