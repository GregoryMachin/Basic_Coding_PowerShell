function ConvertTo-TravelMinutes {
    param(
        [ValidateRange(0, 10000)][double]$DistanceKm,
        [ValidateRange(0.1, 1000)][double]$SpeedKmh
    )
    ($DistanceKm / $SpeedKmh) * 60
}

function Test-MissionReady {
    param(
        [ValidateRange(0, 100)][int]$BatteryPercent,
        [ValidateRange(0, 100)][int]$TeamSize
    )
    $BatteryPercent -ge 25 -and $TeamSize -ge 2
}

$minutes = ConvertTo-TravelMinutes -DistanceKm 12 -SpeedKmh 24
$ready = Test-MissionReady -BatteryPercent 80 -TeamSize 3
Write-Host "Travel time: $minutes minutes"
Write-Host "Ready: $ready"

