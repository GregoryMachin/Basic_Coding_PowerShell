$path = Join-Path $PSScriptRoot '..\data\city-status.json'
$city = Get-Content -Path $path -Raw | ConvertFrom-Json

# TODO: Check that city, updated, and zones exist.
# TODO: Select zones with alertLevel >= 3.
# TODO: Sort by alertLevel descending.
$shortlist = $city.zones

$shortlist | Select-Object name, alertLevel, @{ Name = 'Lead'; Expression = { $_.lead.name } },
    @{ Name = 'Channel'; Expression = { $_.lead.channel } } |
    Format-Table -AutoSize
