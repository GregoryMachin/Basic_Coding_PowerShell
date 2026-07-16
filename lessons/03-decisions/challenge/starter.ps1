param(
    [int]$WindSpeed = 31,
    [bool]$Lightning = $false
)

# TODO: Apply the three weather rules from the lesson.
$status = 'UNKNOWN'

Write-Host "Wind: $WindSpeed km/h"
Write-Host "Lightning: $Lightning"
Write-Host "Launch status: $status"

