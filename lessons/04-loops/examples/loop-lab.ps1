$zones = @('Harbour', 'Market', 'Gardens')
foreach ($zone in $zones) { Write-Host "foreach visits: $zone" }

for ($count = 3; $count -ge 1; $count--) { Write-Host "for counts: $count" }

$attempt = 1
while ($attempt -le 3) {
    Write-Host "while attempt: $attempt"
    $attempt++
}

