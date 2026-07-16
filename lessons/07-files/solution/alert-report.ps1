$inputPath = Join-Path $PSScriptRoot '..\data\signals.csv'
$workspace = Join-Path $PSScriptRoot '..\workspace'
$outputPath = Join-Path $workspace 'alerts.csv'
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

$alerts = Import-Csv $inputPath |
    Where-Object { [int]$_.Strength -lt 5 } |
    Select-Object Zone, Strength, Clue, @{ Name = 'Priority'; Expression = {
            if ([int]$_.Strength -le 2) { 'High' } else { 'Medium' }
        } }

$alerts | Export-Csv -Path $outputPath -NoTypeInformation
Write-Host "Wrote $($alerts.Count) alerts to $outputPath"

