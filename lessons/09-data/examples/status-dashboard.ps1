$path = Join-Path $PSScriptRoot '..\data\city-status.json'
$city = Get-Content -Path $path -Raw | ConvertFrom-Json

if ($null -eq $city.city -or $null -eq $city.zones) { throw 'Required city or zones data is missing.' }
[datetimeoffset]$updated = $city.updated
$highest = $city.zones | Sort-Object alertLevel -Descending | Select-Object -First 1

Write-Host "=== $($city.city.ToUpper()) STATUS ===" -ForegroundColor Cyan
Write-Host "Snapshot: $($city.updated)"
Write-Host "Zones: $($city.zones.Count); highest alert: $($highest.name) ($($highest.alertLevel))"
$city.zones |
    Sort-Object alertLevel -Descending |
    Select-Object name, alertLevel, @{ Name = 'Lead'; Expression = { $_.lead.name } },
        @{ Name = 'Channel'; Expression = { $_.lead.channel } } |
    Format-Table -AutoSize
