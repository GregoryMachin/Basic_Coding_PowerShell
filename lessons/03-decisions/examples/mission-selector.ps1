[int]$risk = Read-Host 'Risk level from 0 to 10'
$nearbyAnswer = (Read-Host 'Are people nearby? Y/N').Trim()
[bool]$peopleNearby = $nearbyAnswer -eq 'Y'

if ($risk -ge 8 -and $peopleNearby) {
    $response = 'Full rescue and safety team'
    $reason = 'High risk with people nearby'
}
elseif ($risk -ge 4) {
    $response = 'Two-person scout team'
    $reason = 'Moderate or high risk requires investigation'
}
else {
    $response = 'Remote signal monitoring'
    $reason = 'Low reported risk'
}

Write-Host '=== RESPONSE RECOMMENDATION ===' -ForegroundColor Magenta
Write-Host "Risk: $risk/10"
Write-Host "People nearby: $peopleNearby"
Write-Host "Recommendation: $response"
Write-Host "Reason: $reason"

