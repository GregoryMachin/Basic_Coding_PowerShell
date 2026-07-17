$inputPath = Join-Path $PSScriptRoot '..\data\signals.csv'
$workspace = Join-Path $PSScriptRoot '..\workspace'
$outputPath = Join-Path $workspace 'alerts.csv'
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

if (-not (Test-Path -LiteralPath $inputPath)) { throw "Signal data not found: $inputPath" }

$signals = Import-Csv -LiteralPath $inputPath
$required = @('Zone', 'Strength', 'Clue')
foreach ($column in $required) {
    if ($signals.Count -gt 0 -and $column -notin $signals[0].PSObject.Properties.Name) {
        throw "Required CSV column missing: $column"
    }
}

$alerts = $signals |
    Where-Object { [int]$_.Strength -lt 5 } |
    Select-Object Zone, Strength, Clue, @{ Name = 'Priority'; Expression = {
            if ([int]$_.Strength -le 2) { 'High' } else { 'Medium' }
        } }

$alerts | Export-Csv -LiteralPath $outputPath -NoTypeInformation
$roundTrip = @(Import-Csv -LiteralPath $outputPath)
if ($roundTrip.Count -ne @($alerts).Count) { throw 'Export verification count did not match.' }
Write-Host "Wrote and verified $($roundTrip.Count) alerts at $outputPath"

