$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..\CommandCentre.Core.ps1')

function Assert-Equal {
    param($Expected, $Actual, [string]$Because)
    if ($Expected -ne $Actual) {
        throw "Expected '$Expected' but got '$Actual': $Because"
    }
}

$missions = @(
    (New-Mission -Id M001 -Zone Harbour -Risk 2 -Status Monitoring -Lead 'Echo Lantern')
    (New-Mission -Id M009 -Zone Market -Risk 5 -Status Active -Lead 'Nova Quill')
)

Assert-Equal 'M010' (Get-NextMissionId $missions) 'IDs should increase from the largest ID'
$summary = Get-MissionSummary $missions
Assert-Equal 2 $summary.Total 'all missions should be counted'
Assert-Equal 1 $summary.Active 'active missions should be counted'
Assert-Equal 1 $summary.HighRisk 'risk 4 and 5 should be high risk'

$tempPath = Join-Path ([System.IO.Path]::GetTempPath()) ('signal-academy-' + [guid]::NewGuid() + '.csv')
try {
    Export-MissionData -Missions $missions -Path $tempPath
    $roundTrip = @(Import-MissionData -Path $tempPath)
    Assert-Equal 2 $roundTrip.Count 'exported missions should import again'
    Assert-Equal 5 $roundTrip[1].Risk 'numeric risk should survive the round trip'
}
finally {
    Remove-Item -LiteralPath $tempPath -ErrorAction SilentlyContinue
}

Write-Host 'Command Centre tests passed.' -ForegroundColor Green
