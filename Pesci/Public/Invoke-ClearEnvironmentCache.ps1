function Invoke-CleanEnvironmentCache {
    [CmdLetBinding()]
    param (
        [string] $EnvironmentName = $env:SC_Environment,
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/ClearEnvironmentCache()" -f $EngineHost, $EnginePort)
    Write-Verbose "Calling: $($Url)" 

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = "{`"environmentName`": `"$EnvironmentName`"}"

    try {
        $result = Invoke-RestMethod $Url -TimeoutSec 1200 -Method POST -Headers $headers -Body $body 
        $result
    } catch {
        Write-Host "Code:" $_.Exception.Response.StatusCode.value__ 
        Write-Host "Description:" $_.Exception.Response.StatusDescription
    }
    
    Write-Verbose "Clean environment cache" 
}