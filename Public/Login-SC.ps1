function Login-SC {
    param (
        [Parameter(Mandatory)] [string] $username,
        [Parameter(Mandatory)] [securestring] $password,
        [Parameter(Mandatory)] [string] $identityServerHost
    )

    $token = Get-IdServerToken $username -SecurePassword $password -identityServerHost $identityServerHost

    $SecureToken = $token | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    $env:SC_TOKEN = $SecureToken
    
}