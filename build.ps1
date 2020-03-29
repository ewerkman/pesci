$Settings = @{
    ManifestPath = '{0}\{1}\{1}.psd1' -f $PSScriptRoot, 'Pesci'
    Version = $env:APPVEYOR_BUILD_VERSION
    VersionRegex = "ModuleVersion\s+=\s+'(?<ModuleVersion>\S+)'" -as [regex]
}

$ManifestContent = Get-Content -Path $Settings.ManifestPath
$CurrentVersion = $Settings.VersionRegex.Match($ManifestContent).Groups['ModuleVersion'].Value
"Current module version in the manifest : $CurrentVersion"

$ManifestContent -replace $CurrentVersion,$Settings.Version | Set-Content -Path $Settings.ManifestPath -Force -Encoding Unicode
$NewManifestContent = Get-Content -Path $Settings.ManifestPath 
$NewVersion = $Settings.VersionRegex.Match($NewManifestContent).Groups['ModuleVersion'].Value
"Updated module version in the manifest : $NewVersion"

If ( $NewVersion -ne $Settings.Version ) {
    Throw "Module version was not updated correctly to $($Settings.Version) in the manifest."
}

Publish-Module -Path Pesci -NuGetApiKey $ENV:NugetApiKey -Verbose