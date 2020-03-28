#Requires -RunAsAdministrator
#Requires -Modules WebAdministration

Set-StrictMode -Version 2.0

function Invoke-Bootstrap {
    param (
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/Bootstrap()" -f $EngineHostName, $EnginePort)
    Write-Information "BootStrapping Commerce Services: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers
    Write-Information "Commerce Services BootStrapping completed" -ForegroundColor Green
}