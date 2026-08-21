$roster = @(
    [pscustomobject]@{ Name = 'Echo Lantern'; Skill = 'Communications'; Level = 4; Available = $true }
    [pscustomobject]@{ Name = 'Nova Quill'; Skill = 'Navigation'; Level = 3; Available = $true }
    [pscustomobject]@{ Name = 'Moss Circuit'; Skill = 'Engineering'; Level = 5; Available = $false }
    [pscustomobject]@{ Name = 'Quartz Kite'; Skill = 'Engineering'; Level = 3; Available = $true }
)

$qualified = $roster | Where-Object { $_.Level -ge 3 -and $_.Available }
$ranked = $qualified | Sort-Object @{ Expression = 'Level'; Descending = $true }, Name

Write-Host '=== AVAILABLE QUALIFIED TEAM ===' -ForegroundColor Green
$ranked | Format-Table -AutoSize

Write-Host '=== SKILL COUNTS ===' -ForegroundColor Cyan
$roster | Group-Object Skill | Sort-Object Count -Descending |
    Select-Object Name, Count | Format-Table -AutoSize

$average = ($roster | Measure-Object Level -Average).Average
Write-Host ('Average roster level: {0:N1}' -f $average)
