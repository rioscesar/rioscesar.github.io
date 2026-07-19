$ErrorActionPreference = 'Stop'

$scan = Join-Path $PSScriptRoot '..\scripts\Invoke-SafetyScan.ps1'
$workspace = Join-Path ([System.IO.Path]::GetTempPath()) ("safety-scan-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $workspace | Out-Null

try {
    $cleanDiff = Join-Path $workspace 'clean.diff'
    Set-Content -LiteralPath $cleanDiff -Value '+Documentation-only change.' -NoNewline
    & pwsh -NoProfile -File $scan -DiffPath $cleanDiff
    if ($LASTEXITCODE -ne 0) {
        throw 'Negative control failed: a clean diff was flagged.'
    }

    $badDiff = Join-Path $workspace 'bad.diff'
    $badLine = '+api' + '_key=not-a-real-secret'
    Set-Content -LiteralPath $badDiff -Value $badLine -NoNewline
    & pwsh -NoProfile -File $scan -DiffPath $badDiff 2>$null
    if ($LASTEXITCODE -eq 0) {
        throw 'Positive control failed: a credential assignment was not flagged.'
    }

    Write-Output 'Safety scan controls passed.'
}
finally {
    Remove-Item -LiteralPath $workspace -Recurse -Force -ErrorAction SilentlyContinue
}

# The positive control intentionally invokes a failing child process. Return an
# explicit success code after asserting that failure so it cannot leak into CI.
exit 0
