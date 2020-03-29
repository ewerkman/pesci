function Invoke-EnsureSyncDefaultContentPaths {
    [CmdLetBinding()]
    param (
        [string] $ShopName,
        [string] $EnvironmentName = $env:SC_Environment,
        [switch] $WaitForCompletion,
        [string] $EngineHost = $env:SC_EngineHost,
        [int] $EnginePort = $env:SC_EnginePort
    )

    $Url = ("https://{0}:{1}/commerceops/EnsureSyncDefaultContentPaths(environment='$EnvironmentName',shopName='$ShopName')" -f $EngineHost, $EnginePort)
    Write-Verbose "Calling: $($Url)" 

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)
    $headers.Add("Content-Type", "application/json")

    $body = ""

    $result = Invoke-RestMethod $Url -TimeoutSec 1200 -Method PUT -Headers $headers -Body $body

    if($WaitForCompletion)
    {
        WaitForCompletion -TaskId $result.TaskId -EngineHost $EngineHost -EnginePort $EnginePort
    }
    else
    {
        $result
    }
        
    Write-Verbose "Finished EnsureSyncDefaultContentPaths" 
}