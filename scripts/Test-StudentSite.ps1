[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$failures = New-Object System.Collections.Generic.List[string]

$expectedPages = @(
    'index.html'
    'setup.html'
    'references.html'
)
$expectedPages += Get-ChildItem -LiteralPath (Join-Path $repoRoot 'lessons') -Directory |
    Sort-Object Name |
    ForEach-Object { 'lessons\' + $_.Name + '\index.html' }

foreach ($relativePage in $expectedPages) {
    $pagePath = Join-Path $repoRoot $relativePage
    if (-not (Test-Path -LiteralPath $pagePath)) {
        $failures.Add("Missing page: $relativePage")
        continue
    }

    $content = Get-Content -LiteralPath $pagePath -Raw -Encoding UTF8
    if ($content -notmatch '<html lang="en-NZ">') {
        $failures.Add("Missing en-NZ language declaration: $relativePage")
    }
    if ($content -match 'â|&#226;') {
        $failures.Add("Possible text-encoding error: $relativePage")
    }

    foreach ($match in [regex]::Matches($content, '(?:href|src)="([^"]+)"')) {
        $target = $match.Groups[1].Value.Split('#')[0]
        if (-not $target -or $target -match '^(https?:|mailto:)') { continue }

        $decodedTarget = [uri]::UnescapeDataString($target)
        $resolvedTarget = [System.IO.Path]::GetFullPath((Join-Path (Split-Path $pagePath -Parent) $decodedTarget))
        if (-not (Test-Path -LiteralPath $resolvedTarget)) {
            $failures.Add("Broken local link in ${relativePage}: $target")
        }
    }
}

$referencePage = Get-Content -LiteralPath (Join-Path $repoRoot 'references.html') -Raw -Encoding UTF8
$linkedReferences = [regex]::Matches($referencePage, 'class="reference-card').Count
$finalImages = @(Get-ChildItem -LiteralPath (Join-Path $repoRoot 'Images\Final images') -Recurse -File -Filter '*.png').Count
if ($linkedReferences -ne $finalImages) {
    $failures.Add("Reference gallery links $linkedReferences of $finalImages final images.")
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host "Student site checks passed: $($expectedPages.Count) pages and $linkedReferences linked reference images." -ForegroundColor Green
