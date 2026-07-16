$path = Join-Path $PSScriptRoot '..\data\city-status.json'
$workspace = Join-Path $PSScriptRoot '..\workspace'
$outputPath = Join-Path $workspace 'shortlist.json'
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

$city = Get-Content -Path $path -Raw | ConvertFrom-Json
$shortlist = $city.zones |
    Where-Object { [int]$_.alertLevel -ge 3 } |
    Sort-Object alertLevel -Descending

$shortlist | Select-Object name, alertLevel, @{ Name = 'Lead'; Expression = { $_.lead.name } } |
    Format-Table -AutoSize
$shortlist | ConvertTo-Json -Depth 4 | Set-Content -Path $outputPath
Write-Host "Saved shortlist: $outputPath"

