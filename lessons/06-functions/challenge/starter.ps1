function ConvertTo-TravelMinutes {
    param(
        [double]$DistanceKm,
        [double]$SpeedKmh
    )
    # TODO: Return travel time in minutes.
    return 0
}

function Test-MissionReady {
    param(
        [int]$BatteryPercent,
        [int]$TeamSize
    )
    # TODO: Return true when battery >= 25 and team size >= 2.
    return $false
}

Write-Host (ConvertTo-TravelMinutes -DistanceKm 12 -SpeedKmh 24)
Write-Host (Test-MissionReady -BatteryPercent 80 -TeamSize 3)

