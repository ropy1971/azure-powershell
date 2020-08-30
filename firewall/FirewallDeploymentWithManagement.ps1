##### FUNCTIONS #####
function Init {
    $SubscriptionId = ""
    $ResourceGroupName = ""
    $Location = "francecentral"
    $VirtualNetworkName = ""
    $FirewallPublicIpName = ""
    $KasperskyGatewayPublicIpName = ""
    $ManagementPublicIpName = ""
    $FirewallName = ""

    Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
    CheckResourceGroup
}

function CheckResourceGroup {
    $ResourceGroup = Get-AzResourceGroup -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
    if($ResourceGroup) {
        Write-Host "[info] Resource Group $ResourceGroupName has been found. "
        CheckVirtualNetwork
    }
    else {
        Write-Host "[error] Resource Group $ResourceGroupName has not been found. "
        Return
    }
}

function CheckVirtualNetwork {
    $VirtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName -ErrorAction SilentlyContinue
    if($VirtualNetwork) {
        Write-Host "[info] Virtual Network $VirtualNetworkName has been found. "  
        CheckFirewallPublicIp
    }
    else {
        Write-Host "[error] Virtual Network $VirtualNetworkName has not been found. "
        Return
    }
}

function CheckFirewallPublicIp {
    $FirewallPublicIp = Get-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name $FirewallPublicIpName -ErrorAction SilentlyContinue
    if($FirewallPublicIp) {
        Write-Host "[info] Firewall Public Ip $FirewallPublicIpName has been found. " 
        CheckKasperskyGatewayPublicIp
    }
    else {
        Write-Host "[error] Firewall Public Ip $FirewallPublicIpName has not been found. "
        Return
    }
}

function CheckKasperskyGatewayPublicIp {
    $KasperskyGatewayPublicIp = Get-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name $KasperskyGatewayPublicIpName -ErrorAction SilentlyContinue
    if($KasperskyGatewayPublicIp) {
        Write-Host "[info] Kaspersky Gateway Public Ip $KasperskyGatewayPublicIpName has been found. "
        CheckManagementPublicIp 
    }
    else {
        Write-Host "[error] Kaspersky Gateway Public Ip $KasperskyGatewayPublicIpName has not been found. "
        Return
    }
}

function CheckManagementPublicIp {
    $ManagementPublicIp = Get-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name $ManagementPublicIpName -ErrorAction SilentlyContinue
    if($ManagementPublicIp) {
        Write-Host "[info] Management Public Ip $ManagementPublicIpName has been found. "
        SetFirewall 
    }
    else {
        Write-Host "[error] Management Public Ip $ManagementPublicIpName has not been found. "
        Return
    }
}

function SetFirewall {
    Write-Host "[info] Deployment of Firewall $FirewallName is in progress. Please wait (<7min). "
    New-AzFirewall -Name $FirewallName -ResourceGroupName $ResourceGroupName -Location $Location -VirtualNetwork $VirtualNetwork -PublicIpAddress $FirewallPublicIp -ManagementPublicIpAddress $ManagementPublicIp | Out-Null
    Write-Host "[info] Firewall $FirewallName has been deployed. "
}

##### INIT #####
Clear-Host
Write-Host " "
Init
Write-Host " "
