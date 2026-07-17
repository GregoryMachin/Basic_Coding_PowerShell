. (Join-Path $PSScriptRoot 'mission-functions.ps1')

function Assert-Equal {
    param($Expected, $Actual, [string]$Because)
    if ($Expected -ne $Actual) { throw "Expected $Expected, got ${Actual}: $Because" }
}

Assert-Equal 30 (ConvertTo-TravelMinutes 12 24) '12 km at 24 km/h is half an hour'
Assert-Equal 0 (ConvertTo-TravelMinutes 0 24) 'zero distance takes zero minutes'
Assert-Equal $true (Test-MissionReady 25 2) 'boundary values are ready'
Assert-Equal $false (Test-MissionReady 24 2) 'battery below 25 is not ready'
Write-Host 'Mission function tests passed.' -ForegroundColor Green
