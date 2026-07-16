[double]$startingEnergy = Read-Host 'Starting energy'
[double]$minutes = Read-Host 'Mission duration in minutes'
[double]$energyPerMinute = Read-Host 'Energy used per minute'
[double]$boostCost = Read-Host 'Additional boost cost (enter 0 for none)'

# TODO: Multiply minutes by energy per minute.
$runningEnergy = 0

# TODO: Add the running energy and boost cost.
$totalEnergyUsed = 0

# TODO: Subtract total energy used from starting energy.
$remainingEnergy = 0

# TODO: Divide remaining energy by starting energy, then multiply by 100.
$percentRemaining = 0

Write-Host "`n=== BATTERY PLAN ===" -ForegroundColor Cyan
Write-Host "Running energy: $runningEnergy energy units"
Write-Host "Boost cost: $boostCost energy units"
Write-Host "Total energy used: $totalEnergyUsed energy units"
Write-Host "Remaining energy: $remainingEnergy energy units"
Write-Host "Remaining percentage: $percentRemaining%"

