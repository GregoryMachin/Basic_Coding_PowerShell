$roster = @(
    [pscustomobject]@{ Name = 'River Byte'; Skill = 'Logistics'; Level = 2 }
    [pscustomobject]@{ Name = 'Solar Finch'; Skill = 'Aerial survey'; Level = 4 }
    [pscustomobject]@{ Name = 'Quartz Kite'; Skill = 'Engineering'; Level = 3 }
)

$qualified = $roster | Where-Object { $_.Level -ge 3 }
$qualified | Format-Table -AutoSize

$lead = $qualified | Sort-Object Level -Descending | Select-Object -First 1
Write-Host "Suggested lead: $($lead.Name)"
