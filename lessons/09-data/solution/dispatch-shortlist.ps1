$path = Join-Path $PSScriptRoot '..\data\city-status.json'
$workspace = Join-Path $PSScriptRoot '..\workspace'
$outputPath = Join-Path $workspace 'shortlist.json'
New-Item -ItemType Directory -Path $workspace -Force | Out-Null

$city = Get-Content -Path $path -Raw | ConvertFrom-Json
foreach ($property in @('city', 'updated', 'zones')) {
    if ($property -notin $city.PSObject.Properties.Name) { throw "Required JSON property missing: $property" }
}
foreach ($zone in $city.zones) {
    if ([int]$zone.alertLevel -notin 0..5) { throw "Invalid alert level for $($zone.name)" }
}
$shortlist = $city.zones |
    Where-Object { [int]$_.alertLevel -ge 3 } |
    Sort-Object alertLevel -Descending

$shortlist | Select-Object name, alertLevel, @{ Name = 'Lead'; Expression = { $_.lead.name } },
    @{ Name = 'Channel'; Expression = { $_.lead.channel } } |
    Format-Table -AutoSize
$shortlist | ConvertTo-Json -Depth 4 | Set-Content -Path $outputPath
$roundTrip = @(Get-Content $outputPath -Raw | ConvertFrom-Json)
[datetimeoffset]$updated = $city.updated
$ageDays = [Math]::Floor(([datetimeoffset]::Now - $updated).TotalDays)
Write-Host "Saved and verified $($roundTrip.Count) records: $outputPath"
Write-Host "Snapshot age: $ageDays days"
