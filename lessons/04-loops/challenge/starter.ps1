$signals = @(
    [pscustomobject]@{ Zone = 'Harbour'; Strength = 8; Status = 'Online' }
    [pscustomobject]@{ Zone = 'Market'; Strength = 3; Status = 'Online' }
    [pscustomobject]@{ Zone = 'Gardens'; Strength = 6; Status = 'Offline' }
    [pscustomobject]@{ Zone = 'Station'; Strength = 1; Status = 'Online' }
)

# TODO: Count down from 5 to 1 with a for loop.
Write-Host 'Launch!'

$weakCount = 0
# TODO: Visit every signal with foreach.
# TODO: Count online signals with Strength <= 3.
# POWER-UP: continue past Offline records.
# POWER-UP: break after the first Strength of 1.

Write-Host "Weak signals found: $weakCount"

