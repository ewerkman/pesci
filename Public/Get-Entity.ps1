function Get-Entity {
    param (
        [string] $EntityId,
        [string] $EnvironmentName,
        [string] $EngineHostName = $env:SC_EngineHost,
        [int] $CommerceOpsPort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/GetRawEntity()" -f $EngineHostName, $CommerceOpsPort)
    Write-Host "Calling: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = "{`"entityId`": `"$EntityId`",`"environmentName`": `"$EnvironmentName`"`n}"

    $response = Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers -Body $body
    $response | ConvertTo-Json
    Write-Host "Initialize environment started" -ForegroundColor Green
}