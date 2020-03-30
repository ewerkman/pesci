function Invoke-Bootstrap {
    [CmdLetBinding()]
    param (
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/Bootstrap()" -f $EngineHost, $EnginePort)
    Write-Verbose "BootStrapping Commerce Services: $($Url)" 

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers

    Write-Verbose "Commerce Services BootStrapping completed" 
}