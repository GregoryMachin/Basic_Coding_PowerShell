$roster = @(
    [pscustomobject]@{ Name = 'River Byte'; Skill = 'Logistics'; Level = 2; Available = $true }
    [pscustomobject]@{ Name = 'Solar Finch'; Skill = 'Aerial survey'; Level = 4; Available = $true }
    [pscustomobject]@{ Name = 'Quartz Kite'; Skill = 'Engineering'; Level = 3; Available = $true }
    [pscustomobject]@{ Name = 'Moss Circuit'; Skill = 'Engineering'; Level = 5; Available = $false }
)

$ranked = $roster |
    Where-Object { $_.Level -ge 3 -and $_.Available } |
    Sort-Object Level, Name -Descending
$lead = $ranked | Select-Object -First 1

$ranked | Select-Object Name, Skill, Level, Available,
    @{ Name = 'Readiness'; Expression = { $_.Level * 20 } } | Format-Table -AutoSize
Write-Host "Suggested lead: $($lead.Name)"

$roster | Group-Object Skill | Select-Object Name, Count | Format-Table -AutoSize
$average = ($roster | Measure-Object Level -Average).Average
Write-Host ('Average level: {0:N1}' -f $average)
