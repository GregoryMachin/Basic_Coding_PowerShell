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

function New-MissionPlan {
    param([double]$DistanceKm, [double]$SpeedKmh, [int]$BatteryPercent, [int]$TeamSize)
    [pscustomobject]@{
        TravelMinutes = ConvertTo-TravelMinutes $DistanceKm $SpeedKmh
        Ready = Test-MissionReady $BatteryPercent $TeamSize
        BatteryPercent = $BatteryPercent
        TeamSize = $TeamSize
    }
}

New-MissionPlan -DistanceKm 12 -SpeedKmh 24 -BatteryPercent 80 -TeamSize 3 |
    Format-List

