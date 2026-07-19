[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$DiffPath
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $DiffPath -PathType Leaf)) {
    throw "Diff file not found: $DiffPath"
}

$diff = Get-Content -LiteralPath $DiffPath -Raw
$rules = @(
    @{
        Name = 'credential assignment'
        Pattern = '(?im)\b(api[_-]?key|secret|password|passwd)\b\s*[:=]\s*[^#\s]+'
    },
    @{
        Name = 'private key'
        Pattern = '-----BEGIN [A-Z ]*PRIVATE KEY-----'
    },
    @{
        Name = 'GitHub token'
        Pattern = '\bghp_[0-9A-Za-z]{36}\b'
    },
    @{
        Name = 'AWS access key'
        Pattern = '\bAKIA[0-9A-Z]{16}\b'
    },
    @{
        Name = 'email address'
        Pattern = '(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b'
    },
    @{
        Name = 'US Social Security number'
        Pattern = '\b[0-9]{3}-[0-9]{2}-[0-9]{4}\b'
    }
)

$hits = foreach ($rule in $rules) {
    if ([regex]::IsMatch($diff, $rule.Pattern)) {
        $rule.Name
    }
}

if ($hits) {
    Write-Error ("Safety scan failed: " + ($hits -join ', '))
    exit 1
}

Write-Output 'Safety scan passed.'
