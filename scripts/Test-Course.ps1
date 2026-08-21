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

$testRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('signal-academy-course-' + [guid]::NewGuid())
try {
    New-Item -ItemType Directory -Path $testRoot | Out-Null
    Copy-Item -LiteralPath (Join-Path $repoRoot 'lessons') -Destination $testRoot -Recurse
    Copy-Item -LiteralPath (Join-Path $repoRoot 'final-project') -Destination $testRoot -Recurse

    foreach ($script in $scripts) {
        $relativePath = $script.FullName.Substring($repoRoot.Length + 1)
        $isolatedPath = Join-Path $testRoot $relativePath
        Write-Host "Testing $relativePath" -ForegroundColor Cyan
        try {
            & $isolatedPath *> $null
            if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
                throw "Exited with code $LASTEXITCODE"
            }
        }
        catch {
            $failures.Add("$($script.FullName): $($_.Exception.Message)")
        }
    }
}
finally {
    Remove-Item -LiteralPath $testRoot -Recurse -Force -ErrorAction SilentlyContinue
}

if ($failures.Count -gt 0) {
    Write-Host "`nCourse checks failed:" -ForegroundColor Red
    $failures | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host "`nAll $($allScripts.Count) scripts parsed and $($scripts.Count) non-interactive scripts ran successfully." -ForegroundColor Green
