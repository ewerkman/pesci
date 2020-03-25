function Login-SC {
    param (
        [Parameter(Mandatory)] [string] $Username,
        [Parameter(Mandatory)] [securestring] $Password,
        [Parameter(Mandatory)] [string] $IdentityServerHost
    )

    $token = Get-IdServerToken $Username -SecurePassword $Password -identityServerHost $IdentityServerHost

    # Store the token in an environment variable
    $SecureToken = $token | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    $env:SC_TOKEN = $SecureToken
}