function Invoke-InitializeEnvironment {
    [CmdLetBinding()]
    param (
        [string] $EnvironmentName = $env:SC_EnvironmentName,
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/InitializeEnvironment()" -f $EngineHost, $EnginePort)
    Write-Verbose "Calling: $($Url)" 

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = "{`"environmentName`": `"$EnvironmentName`"}"

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers -Body $body
    
    Write-Verbose "Initialize environment started" 
}