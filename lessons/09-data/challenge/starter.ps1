$path = Join-Path $PSScriptRoot '..\data\city-status.json'
$city = Get-Content -Path $path -Raw | ConvertFrom-Json

# TODO: Select zones with alertLevel >= 3.
# TODO: Sort by alertLevel descending.
$shortlist = $city.zones

$shortlist | Select-Object name, alertLevel, @{ Name = 'Lead'; Expression = { $_.lead.name } } |
    Format-Table -AutoSize

