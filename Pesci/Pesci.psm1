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

Export-ModuleMember Connect-Commerce
Export-ModuleMember Invoke-Bootstrap
Export-ModuleMember Invoke-InitializeEnvironment
Export-ModuleMember Invoke-CleanEnvironment
Export-ModuleMember Invoke-CleanEnvironmentCache
Export-ModuleMember Invoke-CheckLongRunningCommand
Export-ModuleMember Invoke-RunMinion
Export-ModuleMember Invoke-EnsureSyncDefaultContentPaths
Export-ModuleMember Get-Entity






