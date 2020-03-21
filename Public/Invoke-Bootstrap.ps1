#Requires -RunAsAdministrator
#Requires -Modules WebAdministration

Set-StrictMode -Version 2.0

function Invoke-Bootstrap {
    param (
        [Parameter(Mandatory)] [string] $engineHostName,
        [int] $CommerceOpsPort = 443
    )

    $Url = ("https://{0}:{1}/commerceops/Bootstrap()" -f $engineHostName, $CommerceOpsPort)
    Write-Host "BootStrapping Commerce Services: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method PUT -Headers $headers 
    Write-Host "Commerce Services BootStrapping completed" -ForegroundColor Green
}