param(
    [ValidateRange(0, 10)]
    [int]$Risk = 6,
    [bool]$PeopleNearby = $true
)

Write-Host '=== RESPONSE RECOMMENDATION ===' -ForegroundColor Magenta
if ($Risk -ge 8 -and $PeopleNearby) {
    $response = 'Full rescue and safety team'
}
elseif ($Risk -ge 4) {
    $response = 'Two-person scout team'
}
else {
    $response = 'Remote signal monitoring'
}

Write-Host "Risk: $Risk/10"
Write-Host "Recommendation: $response"

