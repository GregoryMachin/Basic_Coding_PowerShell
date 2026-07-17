$signals = @(
    [pscustomobject]@{ Zone = 'Harbour'; Strength = 8; Status = 'Online' }
    [pscustomobject]@{ Zone = 'Market'; Strength = 3; Status = 'Online' }
    [pscustomobject]@{ Zone = 'Gardens'; Strength = 6; Status = 'Offline' }
    [pscustomobject]@{ Zone = 'Station'; Strength = 1; Status = 'Online' }
)

for ($count = 5; $count -ge 1; $count--) { Write-Host $count }
Write-Host 'Launch!'

$weakCount = 0
foreach ($signal in $signals) {
    if ($signal.Status -eq 'Offline') { Write-Host "Skipping $($signal.Zone)"; continue }
    Write-Host "Scanning $($signal.Zone): $($signal.Strength)/10"
    if ($signal.Strength -le 3) { $weakCount++ }
    if ($signal.Strength -eq 1) { Write-Host 'Critical signal found; ending scan.'; break }
}
Write-Host "Weak signals found: $weakCount"
