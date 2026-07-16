$paths = @(
    (Join-Path $PSScriptRoot 'safe-dispatcher.ps1'),
    (Join-Path $PSScriptRoot 'missing-signal.txt')
)

foreach ($path in $paths) {
    try {
        $lineCount = (Get-Content -Path $path -ErrorAction Stop).Count
        Write-Host "Loaded $(Split-Path $path -Leaf): $lineCount lines"
    }
    catch {
        Write-Warning "Could not load $(Split-Path $path -Leaf). Check that the file exists."
    }
}

