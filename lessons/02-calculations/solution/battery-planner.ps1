param(
    [int]$Minutes = 18
)

$startingEnergy = 100
$energyUsed = $Minutes * 4
$remaining = [Math]::Max(0, $startingEnergy - $energyUsed)
$percentRemaining = ($remaining / $startingEnergy) * 100

Write-Host "Energy used: $energyUsed"
Write-Host "Energy remaining: $remaining ($percentRemaining%)"
if ($percentRemaining -ge 20) {
    Write-Host 'Status: SAFE'
}
else {
    Write-Host 'Status: RECHARGE'
}

