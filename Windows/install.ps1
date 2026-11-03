param(
    [Parameter(Mandatory=$true)][string]$BaseDirectory,
    [Parameter(Mandatory=$true)][string]$StatusFile,
    [Parameter(Mandatory=$true)][string]$GamePathFile,
    [Parameter(Mandatory=$true)][string]$Locale,
    [Parameter(Mandatory=$true)][string]$PayloadSha256,
    [Parameter(Mandatory=$true)][string]$CodecSha256,
    [string]$GamePath
)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)
function Write-Status([string]$Message) {
    [System.IO.File]::WriteAllText($StatusFile, $Message, $utf8)
}
function Resolve-Game([string]$Path) {
    if ($Path -and (Test-Path -LiteralPath (Join-Path $Path 'The Forest of Love.exe') -PathType Leaf)) {
        return [System.IO.Path]::GetFullPath($Path)
    }
    return $null
}
function Find-Game {
    # The folder picker always wins. Never silently install to another copy.
    if ($GamePath) { return Resolve-Game $GamePath }
    $candidates = New-Object 'System.Collections.Generic.List[string]'
    $candidates.Add($BaseDirectory)
    $parent = Split-Path -Parent $BaseDirectory
    if ($parent) { $candidates.Add($parent) }
    $steamRoots = New-Object 'System.Collections.Generic.List[string]'
    foreach ($key in @('HKCU:\Software\Valve\Steam', 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam', 'HKLM:\SOFTWARE\Valve\Steam')) {
        if (Test-Path $key) {
            $properties = Get-ItemProperty $key
            foreach ($name in @('SteamPath', 'InstallPath')) {
                $value = $properties.PSObject.Properties[$name]
                if ($value -and $value.Value) { $steamRoots.Add([string]$value.Value) }
            }
        }
    }
    foreach ($programs in @(${env:ProgramFiles(x86)}, $env:ProgramFiles)) {
        if ($programs) { $steamRoots.Add((Join-Path $programs 'Steam')) }
    }
    foreach ($steam in @($steamRoots | Select-Object -Unique)) {
        $libraries = New-Object 'System.Collections.Generic.List[string]'
        $libraries.Add($steam)
        $vdf = Join-Path $steam 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $vdf -PathType Leaf) {
            foreach ($match in [regex]::Matches([System.IO.File]::ReadAllText($vdf), '"path"\s+"([^"]+)"')) {
                $libraries.Add($match.Groups[1].Value.Replace('\\', '\'))
            }
        }
        foreach ($library in $libraries) {
            $candidates.Add((Join-Path $library 'steamapps\common\The Forest of Love'))
        }
    }
    $found = @($candidates | ForEach-Object { Resolve-Game $_ } | Where-Object { $_ } | Select-Object -Unique)
    if ($found.Count -eq 1) { return $found[0] }
    if ($found.Count -gt 1) { Write-Status 'Several game copies were found. Choose the game folder to use.' }
    else { Write-Status 'The Forest of Love was not found. Choose the folder containing The Forest of Love.exe.' }
    return $null
}
try {
    $resolved = Find-Game
    if (!$resolved) {
        if ($GamePath) { Write-Status 'Choose the folder containing The Forest of Love.exe.' }
        exit 2
    }
    Write-Status 'Checking the game and language package…'
    $resources = Join-Path $BaseDirectory 'Resources'
    Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem, System.Runtime.Serialization
    Add-Type -Path (Join-Path $resources 'ForestInstaller.cs') -ReferencedAssemblies @(
        'System.dll', 'System.Core.dll', 'System.IO.Compression.dll', 'System.IO.Compression.FileSystem.dll', 'System.Runtime.Serialization.dll'
    )
    $callback = [System.Action[string]] { param($message) Write-Status $message }
    [VNRevival.Forest.Installer]::Apply($resolved, (Join-Path $resources 'ForestLanguages.forestpack'), $PayloadSha256, $Locale,
        (Join-Path $resources 'forest-bundle.exe'), $CodecSha256, $callback)
    [System.IO.File]::WriteAllText($GamePathFile, $resolved, $utf8)
    exit 0
} catch {
    $message = $_.Exception.GetBaseException().Message
    Write-Status $message
    exit 1
}
