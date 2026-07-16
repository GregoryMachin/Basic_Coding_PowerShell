# Ask for text, then explicitly convert it to numeric values.
$batteryText = Read-Host 'How many battery units are installed'
$boostText = Read-Host 'Enter the signal-boost level'

[int]$batteryUnits = $batteryText
[int]$signalBoost = $boostText

# These fixed values keep the first calculator focused.
[int]$shieldLoad = 12
[int]$systemCount = 3

# Named intermediate variables make the formula easier to trace.
$batteryPower = $batteryUnits * 10
$boostPower = $signalBoost * 5
$generatedPower = $batteryPower + $boostPower
$availablePower = $generatedPower - $shieldLoad
$averagePerSystem = $availablePower / $systemCount
$displayAverage = '{0:N1}' -f $averagePerSystem

Write-Host '=== BEACON PACK POWER ===' -ForegroundColor Yellow
Write-Host "Battery contribution: $batteryUnits * 10 = $batteryPower energy units"
Write-Host "Boost contribution: $signalBoost * 5 = $boostPower energy units"
Write-Host "Generated power: $generatedPower energy units"
Write-Host "After shield load: $availablePower energy units"
Write-Host "Average across $systemCount systems: $displayAverage energy units"

Write-Host "`nType check:" -ForegroundColor Cyan
Write-Host "Input started as: $($batteryText.GetType().Name)"
Write-Host "Converted battery value: $($batteryUnits.GetType().Name)"
Write-Host "Calculated average: $($averagePerSystem.GetType().Name)"
Write-Host "Formatted average: $($displayAverage.GetType().Name)"
