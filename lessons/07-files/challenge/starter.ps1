$inputPath = Join-Path $PSScriptRoot '..\data\signals.csv'
$workspace = Join-Path $PSScriptRoot '..\workspace'
$outputPath = Join-Path $workspace 'alerts.csv'
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

# TODO: Import the CSV.
$signals = @()
# TODO: Keep signals with numeric Strength below 5.
$alerts = $signals
# TODO: Export $alerts to $outputPath with -NoTypeInformation.

Write-Host "Alert report: $outputPath"

