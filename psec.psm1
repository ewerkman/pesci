Set-StrictMode -Version 2.0

#Requires -RunAsAdministrator

# Get Functions
$private = Get-ChildItem -Path (Join-Path $PSScriptRoot Private) -Include *.ps1 -File -Recurse
$public = Get-ChildItem -Path (Join-Path $PSScriptRoot Public) -Include *.ps1 -File -Recurse

# Dot source to scope
# Private must be sourced first - usage in public functions during load
($private) | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}

($public) | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}

Export-ModuleMember Login-SC
Export-ModuleMember Invoke-Bootstrap
Export-ModuleMember Invoke-InitializeEnvironment
Export-ModuleMember Check-LongRunningCommand
Export-ModuleMember Get-Entity






