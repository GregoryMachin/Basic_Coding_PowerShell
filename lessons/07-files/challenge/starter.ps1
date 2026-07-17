$inputPath = Join-Path $PSScriptRoot '..\data\signals.csv'
$workspace = Join-Path $PSScriptRoot '..\workspace'
$outputPath = Join-Path $workspace 'alerts.csv'
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

# TODO: Check that $inputPath exists; throw a useful message if it does not.
# TODO: Import the CSV.
$signals = @()
# TODO: Keep signals with numeric Strength below 5.
$alerts = $signals
# TODO: Export $alerts to $outputPath with -NoTypeInformation.
# POWER-UP: Re-import $outputPath and compare its count with $alerts.Count.

Write-Host "Alert report: $outputPath"
