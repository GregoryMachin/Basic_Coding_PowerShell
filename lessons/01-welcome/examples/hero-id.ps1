# Signal Academy recruit record
$heroName = Read-Host 'Enter your hero name'
$district = 'Harbour Ward'
$specialSkill = 'Turns confusing clues into clear maps'
[int]$academyLevel = 1
[int]$trainingPoints = 35
[int]$missionPoints = 15

$introduction = "$heroName protects $district."
$totalPoints = $trainingPoints + $missionPoints
$nextLevel = $academyLevel + 1

Write-Host '=== SIGNAL ACADEMY ID ===' -ForegroundColor Cyan
Write-Host "Recruit: $heroName"
Write-Host "District: $district"
Write-Host "Skill: $specialSkill"
Write-Host "Level: $academyLevel"
Write-Host $introduction
Write-Host "Total points: $trainingPoints + $missionPoints = $totalPoints"
Write-Host "Next level: $nextLevel"

