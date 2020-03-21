Function Get-IdServerToken {
    param(
        [string] $adminUser,
        [securestring] $SecurePassword,
        [string] $identityServerHost
    )

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
    $adminPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    $UrlIdentityServerGetToken = ("https://{0}/connect/token" -f $identityServerHost)

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", 'application/x-www-form-urlencoded')
    $headers.Add("Accept", 'application/json')

    $body = @{
        password   = "$adminPassword"
        grant_type = 'password'
        username   = ("sitecore\{0}" -f $adminUser)
        client_id  = 'postman-api'
        scope      = 'openid EngineAPI postman_api'
    }
    Write-Host "Getting Identity Token From Sitecore.IdentityServer" -ForegroundColor Green
    $response = Invoke-RestMethod $UrlIdentityServerGetToken -Method Post -Body $body -Headers $headers

    $sitecoreIdToken = "Bearer {0}" -f $response.access_token

    return $sitecoreIdToken
}

function Get-IdServerTokenFromEnvironment {
    $secureToken = ConvertTo-SecureString $env:SC_TOKEN 
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    return $token
}

function Login-SC {
    param (
        [string] $username,
        [securestring] $password,
        [string] $identityServerHost
    )

    $token = Get-IdServerToken $username -SecurePassword $password -identityServerHost $identityServerHost

    $SecureToken = $token | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    $env:SC_TOKEN = $SecureToken
    
}

function Invoke-Bootstrap {
    param (
        [string] $engineHostName,
        [int] $CommerceOpsPort = 443
    )

    $Url = ("https://{0}:{1}/commerceops/Bootstrap()" -f $engineHostName, $CommerceOpsPort)
    Write-Host "BootStrapping Commerce Services: $($Url)" -ForegroundColor Green

    $token = Get-IdServerTokenFromEnvironment

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", $token)

    Invoke-RestMethod $Url -TimeoutSec 1200 -Method PUT -Headers $headers 
    Write-Host "Commerce Services BootStrapping completed" -ForegroundColor Green
}

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

Export-ModuleMember -Function Login-SC
Export-ModuleMember -Function Invoke-Bootstrap
Export-ModuleMember -Function Invoke-InitializeEnvironment