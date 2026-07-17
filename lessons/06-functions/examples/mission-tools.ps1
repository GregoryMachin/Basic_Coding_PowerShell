function Get-MissionScore {
    param([int]$PeopleHelped, [int]$Minutes)
    ($PeopleHelped * 10) - $Minutes
}

function Get-RankLabel {
    param([int]$Score)
    if ($Score -ge 60) { return 'Gold Signal' }
    if ($Score -ge 30) { return 'Silver Signal' }
    'Training Signal'
}

function New-ScoreReport {
    param([int]$PeopleHelped, [int]$Minutes)
    $score = Get-MissionScore -PeopleHelped $PeopleHelped -Minutes $Minutes
    [pscustomobject]@{
        Score = $score
        Rank = Get-RankLabel -Score $score
        PeopleHelped = $PeopleHelped
        Minutes = $Minutes
    }
}

$report = New-ScoreReport -PeopleHelped 8 -Minutes 20
$report | Format-List

