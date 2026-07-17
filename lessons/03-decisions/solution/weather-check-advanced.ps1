param(
    [ValidateRange(0, 300)][int]$WindSpeed = 31,
    [ValidateRange(0, 100)][int]$VisibilityKm = 10,
    [bool]$Lightning = $false
)

if ($Lightning) { $status = 'DO NOT LAUNCH'; $reason = 'Lightning is present' }
elseif ($WindSpeed -gt 60) { $status = 'DO NOT LAUNCH'; $reason = 'Wind is above 60 km/h' }
elseif ($VisibilityKm -lt 5) { $status = 'DO NOT LAUNCH'; $reason = 'Visibility is below 5 km' }
elseif ($WindSpeed -ge 31) { $status = 'CAUTION'; $reason = 'Wind requires review' }
else { $status = 'CLEAR'; $reason = 'Conditions meet the rules' }

[pscustomobject]@{ Status = $status; Reason = $reason; Wind = $WindSpeed; Visibility = $VisibilityKm }

