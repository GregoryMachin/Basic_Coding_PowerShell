# Signal Academy final project starter
$missions = @(
    [pscustomobject]@{ Id = 'M001'; Zone = 'Harbour'; Risk = 2; Status = 'Monitoring' }
    [pscustomobject]@{ Id = 'M002'; Zone = 'Market'; Risk = 4; Status = 'Active' }
    [pscustomobject]@{ Id = 'M003'; Zone = 'Gardens'; Risk = 1; Status = 'Complete' }
)

function Show-Missions {
    param([object[]]$MissionList)
    # TODO: Sort and display the mission records.
    $MissionList | Format-Table -AutoSize
}

function Get-MissionSummary {
    param([object[]]$MissionList)
    # TODO: Return a custom object containing Total, Active, and HighRisk counts.
    [pscustomobject]@{ Total = 0; Active = 0; HighRisk = 0 }
}

$running = $true
while ($running) {
    Write-Host "`n=== SIGNAL ACADEMY COMMAND CENTRE ===" -ForegroundColor Cyan
    Write-Host '1. View missions'
    Write-Host '2. Add a mission'
    Write-Host '3. View summary'
    Write-Host 'Q. Quit'
    $choice = Read-Host 'Choose an option'

    switch ($choice.ToUpper()) {
        '1' { Show-Missions -MissionList $missions }
        '2' {
            # TODO: Ask for zone, risk, status, and lead.
            # TODO: Validate risk with [int]::TryParse and range 0..5.
            # TODO: Create a [pscustomobject] and add it with $missions += ...
            Write-Host 'Build this feature next.' -ForegroundColor Yellow
        }
        '3' { Get-MissionSummary -MissionList $missions | Format-List }
        'Q' { $running = $false }
        default { Write-Host 'Choose 1, 2, 3, or Q.' -ForegroundColor Yellow }
    }
}

Write-Host 'Command centre closed. Keep the signal clear!'

