function Get-MissionScore {
    param(
        [int]$PeopleHelped,
        [int]$Minutes
    )
    ($PeopleHelped * 10) - $Minutes
}

function Get-RankLabel {
    param([int]$Score)
    if ($Score -ge 60) { return 'Gold Signal' }
    if ($Score -ge 30) { return 'Silver Signal' }
    return 'Training Signal'
}

$score = Get-MissionScore -PeopleHelped 8 -Minutes 20
$rank = Get-RankLabel -Score $score
Write-Host "Mission score: $score ($rank)"

