$codename = Read-Host 'Enter your hero codename'
$district = Read-Host 'Enter the home district'
$specialSkill = 'Listens for people who need help'
$motto = 'A clear signal brings us together.'
[int]$missionsCompleted = Read-Host 'How many missions have you completed'
$nextMilestone = $missionsCompleted + 1
$assignment = "$codename is assigned to $district."

Write-Host '=== HERO CARD ===' -ForegroundColor Cyan
Write-Host "Codename: $codename"
Write-Host "District: $district"
Write-Host "Special skill: $specialSkill"
Write-Host "Motto: $motto"
Write-Host "Missions completed: $missionsCompleted"
Write-Host "Next milestone: complete mission $nextMilestone"
Write-Host $assignment
