param(
    [int]$WindSpeed = 31,
    [bool]$Lightning = $false,
    [int]$VisibilityKm = 10
)

if ($Lightning -or $WindSpeed -gt 60 -or $VisibilityKm -lt 5) {
    $status = 'DO NOT LAUNCH'
}
elseif ($WindSpeed -ge 31) {
    $status = 'CAUTION'
}
else {
    $status = 'CLEAR'
}

Write-Host "Launch status: $status"

