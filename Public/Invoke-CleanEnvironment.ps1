function Invoke-CleanEnvironment {
    param (
        [string] $EnvironmentName = $env:SC_EnvironmentName,
        [string] $EngineHostName = $env:SC_EngineHost,
        [int] $CommerceOpsPort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/CleanEnvironment()" -f $EngineHostName, $CommerceOpsPort)
    Write-Host "Calling: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = "{`"environment`": `"$EnvironmentName`"}"

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers -Body $body
    Write-Host "Clean environment started" -ForegroundColor Green
}