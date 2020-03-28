Function Get-IdServerToken {
    param(
        [string] $adminUser,
        [securestring] $SecurePassword,
        [string] $identityServerHost
    )

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
    $adminPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    $UrlIdentityServerGetToken = ("https://{0}/connect/token" -f $identityServerHost)

    Write-Information "Retrieving token using $UrlIdentityServerGetToken..."

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
    Write-Information "Getting Identity Token From Sitecore.IdentityServer" -ForegroundColor Green
    $response = Invoke-RestMethod $UrlIdentityServerGetToken -Method Post -Body $body -Headers $headers -ErrorAction Stop

    $sitecoreIdToken = "Bearer {0}" -f $response.access_token

    return $sitecoreIdToken
}

function Get-IdServerTokenFromEnvironment {
    $secureToken = ConvertTo-SecureString $env:SC_TOKEN
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    return $token
}
