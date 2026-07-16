$roster = @(
    [pscustomobject]@{ Name = 'Echo Lantern'; Skill = 'Communications'; Level = 4 }
    [pscustomobject]@{ Name = 'Nova Quill'; Skill = 'Navigation'; Level = 3 }
    [pscustomobject]@{ Name = 'Moss Circuit'; Skill = 'Engineering'; Level = 5 }
)

Write-Host '=== AVAILABLE TEAM ===' -ForegroundColor Green
$roster | Sort-Object Level -Descending | Format-Table -AutoSize

$engineers = $roster | Where-Object { $_.Skill -eq 'Engineering' }
Write-Host "Engineering matches: $($engineers.Count)"

