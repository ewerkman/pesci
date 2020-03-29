function Get-Entity {
    [CmdLetBinding()]
    param (
        [string] $EntityId,
        [string] $EnvironmentName = $env:SC_Environment,
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/GetRawEntity()" -f $EngineHost, $EnginePort)
    Write-Verbose "Calling: $($Url)" 

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = "{`"entityId`": `"$EntityId`",`"environmentName`": `"$EnvironmentName`"`n}"

    $response = Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers -Body $body
    $response | ConvertTo-Json

    Write-Verbose "Initialize environment started" 
}