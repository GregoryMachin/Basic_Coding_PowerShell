[int]$windSpeed = Read-Host 'Wind speed in km/h'
[int]$visibilityKm = Read-Host 'Visibility in kilometres'
$lightningAnswer = (Read-Host 'Is lightning present? Y/N').Trim()
[bool]$lightning = $lightningAnswer -eq 'Y'

# TODO: Apply the decision table from the lesson.
$status = 'UNKNOWN'
$reason = 'TODO'

Write-Host "`n=== LAUNCH CHECK ===" -ForegroundColor Cyan
Write-Host "Wind: $windSpeed km/h"
Write-Host "Visibility: $visibilityKm km"
Write-Host "Lightning: $lightning"
Write-Host "Launch status: $status"
Write-Host "Reason: $reason"

