$path = Join-Path $PSScriptRoot '..\data\city-status.json'
$city = Get-Content -Path $path -Raw | ConvertFrom-Json

Write-Host "=== $($city.city.ToUpper()) STATUS ===" -ForegroundColor Cyan
Write-Host "Snapshot: $($city.updated)"
$city.zones |
    Sort-Object alertLevel -Descending |
    Select-Object name, alertLevel, @{ Name = 'Lead'; Expression = { $_.lead.name } } |
    Format-Table -AutoSize

