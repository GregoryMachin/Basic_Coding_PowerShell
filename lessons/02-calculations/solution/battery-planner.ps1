# Interactive core solution
[double]$startingEnergy = Read-Host 'Starting energy'
[double]$minutes = Read-Host 'Mission duration in minutes'
[double]$energyPerMinute = Read-Host 'Energy used per minute'
[double]$boostCost = Read-Host 'Additional boost cost (enter 0 for none)'

$runningEnergy = $minutes * $energyPerMinute
$totalEnergyUsed = $runningEnergy + $boostCost
$remainingEnergy = $startingEnergy - $totalEnergyUsed
$percentRemaining = ($remainingEnergy / $startingEnergy) * 100
$displayPercent = '{0:N1}' -f $percentRemaining

Write-Host "`n=== BATTERY PLAN ===" -ForegroundColor Cyan
Write-Host "Running energy: $minutes * $energyPerMinute = $runningEnergy energy units"
Write-Host "Boost cost: $boostCost energy units"
Write-Host "Total energy used: $totalEnergyUsed energy units"
Write-Host "Remaining energy: $remainingEnergy energy units"
Write-Host "Remaining percentage: $displayPercent%"

# Optional realistic-limit power-up
$safeRemaining = [Math]::Max(0, $remainingEnergy)
$safePercent = ($safeRemaining / $startingEnergy) * 100
Write-Host "Clamped remaining energy: $safeRemaining energy units"
Write-Host ('Clamped percentage: {0:N1}%' -f $safePercent)

# Optional Lesson 3 decision preview
if ($safePercent -ge 20) {
    Write-Host 'Status: SAFE' -ForegroundColor Green
}
else {
    Write-Host 'Status: RECHARGE' -ForegroundColor Yellow
}
