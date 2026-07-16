$dataPath = Join-Path $PSScriptRoot '..\data\signals.csv'
$signals = Import-Csv $dataPath
$weakSignals = $signals | Where-Object { [int]$_.Strength -lt 5 }
$average = ($signals | Measure-Object -Property Strength -Average).Average

Write-Host "Readings: $($signals.Count)"
Write-Host ('Average strength: {0:N1}' -f $average)
Write-Host 'Weak readings:' -ForegroundColor Yellow
$weakSignals | Format-Table Zone, Strength, Clue -AutoSize

