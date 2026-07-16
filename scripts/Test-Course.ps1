[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$failures = New-Object System.Collections.Generic.List[string]

$allScripts = @(Get-ChildItem -Path (Join-Path $repoRoot 'lessons') -Recurse -Filter '*.ps1')
$allScripts += Get-ChildItem -Path (Join-Path $repoRoot 'final-project') -Recurse -Filter '*.ps1'

Write-Host "Parsing $($allScripts.Count) PowerShell files..." -ForegroundColor Cyan
foreach ($script in $allScripts) {
    $tokens = $null
    $parseErrors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile(
        $script.FullName,
        [ref]$tokens,
        [ref]$parseErrors
    )
    foreach ($parseError in $parseErrors) {
        $failures.Add("$($script.FullName): $parseError")
    }
}

$scripts = Get-ChildItem -Path (Join-Path $repoRoot 'lessons') -Recurse -Filter '*.ps1' |
    Where-Object {
        $_.FullName -match '\\(examples|solution)\\' -and
        $_.FullName -notmatch '\\interactive\\' -and
        -not (Select-String -LiteralPath $_.FullName -Pattern '\bRead-Host\b' -Quiet)
    }
$scripts += Get-ChildItem -Path (Join-Path $repoRoot 'final-project') -Recurse -Filter '*.ps1' |
    Where-Object { $_.Name -notin @('Command-Centre.ps1', 'starter.ps1') }

foreach ($script in $scripts) {
    Write-Host "Testing $($script.FullName.Substring($repoRoot.Length + 1))" -ForegroundColor Cyan
    try {
        & $script.FullName *> $null
        if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
            throw "Exited with code $LASTEXITCODE"
        }
    }
    catch {
        $failures.Add("$($script.FullName): $($_.Exception.Message)")
    }
}

if ($failures.Count -gt 0) {
    Write-Host "`nCourse checks failed:" -ForegroundColor Red
    $failures | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host "`nAll $($allScripts.Count) scripts parsed and $($scripts.Count) non-interactive scripts ran successfully." -ForegroundColor Green
