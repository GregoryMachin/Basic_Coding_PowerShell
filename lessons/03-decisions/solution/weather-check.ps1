[int]$windSpeed = Read-Host 'Wind speed in km/h'
[int]$visibilityKm = Read-Host 'Visibility in kilometres'
$lightningAnswer = (Read-Host 'Is lightning present? Y/N').Trim()
[bool]$lightning = $lightningAnswer -eq 'Y'

if ($lightning) {
    $status = 'DO NOT LAUNCH'
    $reason = 'Lightning is present'
}
elseif ($windSpeed -gt 60) {
    $status = 'DO NOT LAUNCH'
    $reason = 'Wind is above 60 km/h'
}
elseif ($visibilityKm -lt 5) {
    $status = 'DO NOT LAUNCH'
    $reason = 'Visibility is below 5 km'
}
elseif ($windSpeed -ge 31) {
    $status = 'CAUTION'
    $reason = 'Wind requires additional review'
}
else {
    $status = 'CLEAR'
    $reason = 'Conditions meet the launch rules'
}

$needsReview = $lightning -or $windSpeed -gt 30 -or $visibilityKm -lt 5
Write-Host "Launch status: $status"
Write-Host "Reason: $reason"
Write-Host "Needs review: $needsReview"

