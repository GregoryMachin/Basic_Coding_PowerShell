param(
    [ValidateRange(0.1, 100000)]
    [double]$StartingEnergy = 100,

    [ValidateRange(0, 100000)]
    [double]$Minutes = 18,

    [ValidateRange(0.1, 100000)]
    [double]$EnergyPerMinute = 4,

    [ValidateRange(0, 100000)]
    [double]$BoostCost = 0
)

$runningEnergy = $Minutes * $EnergyPerMinute
$totalEnergyUsed = $runningEnergy + $BoostCost
$rawRemaining = $StartingEnergy - $totalEnergyUsed
$safeRemaining = [Math]::Max(0, $rawRemaining)
$percentRemaining = ($safeRemaining / $StartingEnergy) * 100

if ($percentRemaining -ge 20) {
    $status = 'SAFE'
}
else {
    $status = 'RECHARGE'
}

Write-Host '=== ADVANCED BATTERY PLAN ===' -ForegroundColor Cyan
Write-Host "Energy used: $totalEnergyUsed energy units"
Write-Host "Raw remaining: $rawRemaining energy units"
Write-Host "Safe remaining: $safeRemaining energy units"
Write-Host ('Remaining: {0:N1}%' -f $percentRemaining)
Write-Host "Status: $status"
