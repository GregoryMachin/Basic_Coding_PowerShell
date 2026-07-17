# Signal Academy final project starter
$ErrorActionPreference = 'Stop'
$seedPath = Join-Path $PSScriptRoot 'data\missions.seed.csv'
$logPath = Join-Path $PSScriptRoot 'data\mission-log.csv'

function Import-StarterMissions {
    param([string]$Path)
    @(Import-Csv -LiteralPath $Path | ForEach-Object {
            [pscustomobject]@{
                Id = $_.Id
                Zone = $_.Zone
                Risk = [int]$_.Risk
                Status = $_.Status
                Lead = $_.Lead
            }
        })
}

function Save-StarterMissions {
    param([object[]]$MissionList, [string]$Path)
    $MissionList | Select-Object Id, Zone, Risk, Status, Lead |
        Export-Csv -LiteralPath $Path -NoTypeInformation
}

function Show-Missions {
    param([object[]]$MissionList)
    # READY TODO: Sort Risk descending, then display Id, Zone, Risk, Status, Lead.
    $MissionList | Format-Table Id, Zone, Risk, Status, Lead -AutoSize
}

function Get-MissionSummary {
    param([object[]]$MissionList)
    # READY TODO: Replace zeros with Total, Active, and Risk >= 4 counts.
    [pscustomobject]@{ Total = 0; Active = 0; HighRisk = 0 }
}

function Get-StarterNextId {
    param([object[]]$MissionList)
    # Supplied scaffold: count-based IDs are adequate for this starter dataset.
    'M{0:D3}' -f (@($MissionList).Count + 1)
}

try {
    if (-not (Test-Path -LiteralPath $logPath)) {
        Copy-Item -LiteralPath $seedPath -Destination $logPath
    }
    $missions = @(Import-StarterMissions -Path $logPath)
}
catch {
    Write-Host "Could not load missions: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

$running = $true
while ($running) {
    Write-Host "`n=== SIGNAL ACADEMY COMMAND CENTRE ===" -ForegroundColor Cyan
    Write-Host '1. View missions'
    Write-Host '2. Add a mission'
    Write-Host '3. View summary'
    Write-Host 'Q. Save and quit'
    $choice = (Read-Host 'Choose an option').Trim().ToUpper()

    switch ($choice) {
        '1' { Show-Missions -MissionList $missions }
        '2' {
            # OPERATIONAL TODO 1: Read zone, risk text, status, and lead.
            # OPERATIONAL TODO 2: Validate risk with TryParse and range 0..5.
            # OPERATIONAL TODO 3: Reject blank zone/lead and unknown status.
            # OPERATIONAL TODO 4: Build a five-property custom object.
            # OPERATIONAL TODO 5: Add it with $missions += $newMission.
            Write-Host 'Complete the Operational TODOs to add missions.' -ForegroundColor Yellow
        }
        '3' { Get-MissionSummary -MissionList $missions | Format-List }
        'Q' {
            try {
                Save-StarterMissions -MissionList $missions -Path $logPath
                Write-Host "Saved $($missions.Count) missions." -ForegroundColor Green
                $running = $false
            }
            catch { Write-Host "Save failed: $($_.Exception.Message)" -ForegroundColor Red }
        }
        default { Write-Host 'Choose 1, 2, 3, or Q.' -ForegroundColor Yellow }
    }
}

Write-Host 'Command centre closed. Keep the signal clear!'

