function Get-Entity {
    param (
        [string] $EntityId,
        [string] $Environment = $env:SC_Environment,
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/GetRawEntity()" -f $EngineHostName, $EnginePort)
    Write-Information "Calling: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = "{`"entityId`": `"$EntityId`",`"environmentName`": `"$EnvironmentName`"`n}"

    $response = Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers -Body $body
    $response | ConvertTo-Json

    Write-Information "Initialize environment started" -ForegroundColor Green
}