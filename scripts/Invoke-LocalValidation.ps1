[CmdletBinding()]
param(
    [switch]$Serve
)

$ErrorActionPreference = 'Stop'

$bundle = Get-Command bundle -ErrorAction Stop
$ruby = Get-Command ruby -ErrorAction Stop

& $bundle.Source install
if ($LASTEXITCODE -ne 0) {
    throw 'Bundler dependency installation failed.'
}

$jekyllRoot = (& $bundle.Source show jekyll).Trim()
$jekyllExecutable = Join-Path $jekyllRoot 'exe\jekyll'

if (-not (Test-Path -LiteralPath $jekyllExecutable -PathType Leaf)) {
    throw "Jekyll executable not found at $jekyllExecutable"
}

$previousRubyOpt = $env:RUBYOPT

try {
    if ($env:OS -eq 'Windows_NT') {
        $timezoneRequires = '-rtzinfo -rtzinfo/data'
        $env:RUBYOPT = if ([string]::IsNullOrWhiteSpace($previousRubyOpt)) {
            $timezoneRequires
        }
        else {
            "$previousRubyOpt $timezoneRequires"
        }
    }

    & $ruby.Source $jekyllExecutable build --trace
    if ($LASTEXITCODE -ne 0) {
        throw 'Jekyll build failed.'
    }
}
finally {
    $env:RUBYOPT = $previousRubyOpt
}

& pwsh -NoProfile -File (Join-Path $PSScriptRoot '..\test\Test-SafetyScan.ps1')
if ($LASTEXITCODE -ne 0) {
    throw 'Safety-scan controls failed.'
}

Write-Output 'Local validation passed.'

if ($Serve) {
    & $ruby.Source $jekyllExecutable serve --trace
    if ($LASTEXITCODE -ne 0) {
        throw 'Jekyll preview server failed.'
    }
}
