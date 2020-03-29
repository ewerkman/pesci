function Invoke-CheckLongRunningCommand {
    [CmdLetBinding()]
    param (
        [int] $TaskId,
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/CheckCommandStatus(taskId=$TaskId)" -f $EngineHost, $EnginePort)
    Write-Verbose "Calling: $($Url)" 

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method GET -Headers $headers
    Write-Verbose "Initialize environment started" 
}