$heroName = 'Nova Quill'
[int]$missionsCompleted = 3
[double]$flightTimeMinutes = 7.5
[bool]$beaconReady = $true
[array]$equipment = @('Map', 'Beacon', 'First-aid kit')
[hashtable]$profile = @{ Name = 'Nova Quill'; Level = 2 }

$values = @(
    [pscustomobject]@{ Variable = 'heroName'; Value = $heroName; Type = $heroName.GetType().Name }
    [pscustomobject]@{ Variable = 'missionsCompleted'; Value = $missionsCompleted; Type = $missionsCompleted.GetType().Name }
    [pscustomobject]@{ Variable = 'flightTimeMinutes'; Value = $flightTimeMinutes; Type = $flightTimeMinutes.GetType().Name }
    [pscustomobject]@{ Variable = 'beaconReady'; Value = $beaconReady; Type = $beaconReady.GetType().Name }
    [pscustomobject]@{ Variable = 'equipment'; Value = ($equipment -join ', '); Type = $equipment.GetType().Name }
    [pscustomobject]@{ Variable = 'profile'; Value = $profile.Name; Type = $profile.GetType().Name }
)

Write-Host '=== VARIABLE TYPE SCANNER ===' -ForegroundColor Cyan
$values | Format-Table -AutoSize

$summary = "$heroName completed $missionsCompleted missions in $flightTimeMinutes minutes."
$nextMission = $missionsCompleted + 1
Write-Host $summary
Write-Host "Next mission number: $nextMission"
