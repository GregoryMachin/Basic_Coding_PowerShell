function ConvertTo-TravelMinutes {
    param([double]$DistanceKm, [double]$SpeedKmh)
    # TODO: Return distance / speed * 60.
    return 0
}

function Test-MissionReady {
    param([int]$BatteryPercent, [int]$TeamSize)
    # TODO: Return true when battery >= 25 and team size >= 2.
    return $false
}

function New-MissionPlan {
    param([double]$DistanceKm, [double]$SpeedKmh, [int]$BatteryPercent, [int]$TeamSize)
    # POWER-UP: Call both helpers and return a custom object.
}

$minutes = ConvertTo-TravelMinutes -DistanceKm 12 -SpeedKmh 24
$ready = Test-MissionReady -BatteryPercent 80 -TeamSize 3
Write-Host "Travel time: $minutes minutes"
Write-Host "Ready: $ready"

