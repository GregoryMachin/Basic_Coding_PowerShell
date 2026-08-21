$heroName = 'Nova Quill'
[int]$missionsCompleted = 3
[double]$flightTimeMinutes = 7.5
[bool]$beaconReady = $true

$values = @(
    [pscustomobject]@{ Variable = 'heroName'; Value = $heroName; Type = $heroName.GetType().Name }
    [pscustomobject]@{ Variable = 'missionsCompleted'; Value = $missionsCompleted; Type = $missionsCompleted.GetType().Name }
    [pscustomobject]@{ Variable = 'flightTimeMinutes'; Value = $flightTimeMinutes; Type = $flightTimeMinutes.GetType().Name }
    [pscustomobject]@{ Variable = 'beaconReady'; Value = $beaconReady; Type = $beaconReady.GetType().Name }
)

Write-Host '=== VARIABLE TYPE SCANNER ===' -ForegroundColor Cyan
$values | Format-Table -AutoSize

$summary = "$heroName completed $missionsCompleted missions in $flightTimeMinutes minutes."
$nextMission = $missionsCompleted + 1
Write-Host $summary
Write-Host "Next mission number: $nextMission"
