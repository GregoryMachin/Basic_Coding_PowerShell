[int]$batteryUnits = 8
[int]$signalBoost = 3
[int]$shieldLoad = 12

$generatedPower = ($batteryUnits * 10) + ($signalBoost * 5)
$availablePower = $generatedPower - $shieldLoad
$averagePerSystem = $availablePower / 3

Write-Host '=== BEACON PACK POWER ===' -ForegroundColor Yellow
Write-Host "Generated: $generatedPower units"
Write-Host "After shield load: $availablePower units"
Write-Host ('Average per system: {0:N1} units' -f $averagePerSystem)

