$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'CommandCentre.Core.ps1')

$seedPath = Join-Path $PSScriptRoot 'data\missions.seed.csv'
$logPath = Join-Path $PSScriptRoot 'data\mission-log.csv'

try {
    if (-not (Test-Path -LiteralPath $logPath)) {
        Copy-Item -LiteralPath $seedPath -Destination $logPath
    }
    $missions = @(Import-MissionData -Path $logPath)
}
catch {
    Write-Host "Could not start the command centre: $($_.Exception.Message)" -ForegroundColor Red
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
        '1' {
            $missions | Sort-Object Risk -Descending |
                Format-Table Id, Zone, Risk, Status, Lead -AutoSize
        }
        '2' {
            $zone = (Read-Host 'Zone name').Trim()
            $riskText = Read-Host 'Risk from 0 to 5'
            $risk = 0
            if ([string]::IsNullOrWhiteSpace($zone)) {
                Write-Host 'Zone cannot be blank.' -ForegroundColor Yellow
                continue
            }
            if (-not [int]::TryParse($riskText, [ref]$risk) -or $risk -lt 0 -or $risk -gt 5) {
                Write-Host 'Risk must be a whole number from 0 to 5.' -ForegroundColor Yellow
                continue
            }
            $statusText = (Read-Host 'Status: Monitoring, Active, or Complete').Trim()
            $status = @('Monitoring', 'Active', 'Complete') |
                Where-Object { $_ -eq $statusText } |
                Select-Object -First 1
            if ($null -eq $status) {
                Write-Host 'Use Monitoring, Active, or Complete.' -ForegroundColor Yellow
                continue
            }
            $lead = (Read-Host 'Original hero lead name').Trim()
            if ([string]::IsNullOrWhiteSpace($lead)) {
                Write-Host 'Lead cannot be blank.' -ForegroundColor Yellow
                continue
            }

            $newMission = New-Mission -Id (Get-NextMissionId $missions) -Zone $zone `
                -Risk $risk -Status $status -Lead $lead
            $missions += $newMission
            Write-Host "Added $($newMission.Id)." -ForegroundColor Green
        }
        '3' {
            Get-MissionSummary -Missions $missions | Format-List
        }
        'Q' {
            try {
                Export-MissionData -Missions $missions -Path $logPath
                Write-Host "Saved $($missions.Count) missions." -ForegroundColor Green
                $running = $false
            }
            catch {
                Write-Host "Save failed: $($_.Exception.Message)" -ForegroundColor Red
            }
        }
        default { Write-Host 'Choose 1, 2, 3, or Q.' -ForegroundColor Yellow }
    }
}

Write-Host 'Command centre closed. Keep the signal clear!'
