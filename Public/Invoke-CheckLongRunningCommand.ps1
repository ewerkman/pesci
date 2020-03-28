function Invoke-CheckLongRunningCommand {
param (
    [int] $TaskId,
    [string] $EngineHostName = $env:SC_EngineHost,
    [int] $EnginePort = $env:SC_EnginePort
)

    $Url = ("https://{0}:{1}/commerceops/CheckCommandStatus(taskId=$TaskId)" -f $EngineHostName, $EnginePort)
    Write-Information "Calling: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method GET -Headers $headers
    Write-Information "Initialize environment started" -ForegroundColor Green
}