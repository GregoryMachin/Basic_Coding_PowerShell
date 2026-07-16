$signals = @(
    @{ Zone = 'Harbour'; Strength = 8 }
    @{ Zone = 'Market'; Strength = 3 }
    @{ Zone = 'Gardens'; Strength = 6 }
)

$alerts = 0
foreach ($signal in $signals) {
    Write-Host "Scanning $($signal.Zone): $($signal.Strength)/10"
    if ($signal.Strength -le 3) {
        Write-Host '  Weak signal - investigate' -ForegroundColor Yellow
        $alerts++
    }
}

Write-Host "Scan complete. Alerts: $alerts"

