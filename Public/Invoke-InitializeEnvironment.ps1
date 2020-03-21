function Invoke-InitializeEnvironment {
    param (
        [string] $EnvironmentName,
        [string] $EngineHostName,
        [int] $CommerceOpsPort = 443
    )

    $Url = ("https://{0}:{1}/commerceops/InitializeEnvironment()" -f $engineHostName, $CommerceOpsPort)
    Write-Host "BootStrapping Commerce Services: $($urlCommerceShopsServicesBootstrap)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)

    $body = "{`"environment`": `"$EnvironmentName`"`n}"

    Invoke-RestMethod $UrlCommerceShopsServicesBootstrap -TimeoutSec 1200 -Method PUT -Headers $headers 
    Write-Host "Commerce Services BootStrapping completed" -ForegroundColor Green
}