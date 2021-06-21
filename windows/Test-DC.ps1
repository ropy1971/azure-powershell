
<# References



#>

<# #>
function Init {

    Clear-Host
   
    Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
    
    # $HostName = Get-Host hostname
    $ActiveDirectoryPorts = @('135','389','636','3268','3269')



    HostAlive

}

<# #>
function HostAlive {

    foreach ($Port in $ActiveDirectoryPorts) {
        
        Write-Host $Port

    }


    
}

<# #>
Init
Write-Host ""
