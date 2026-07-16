function Import-MissionData {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Mission data file not found: $Path"
    }

    @(Import-Csv -LiteralPath $Path | ForEach-Object {
            [pscustomobject]@{
                Id     = $_.Id
                Zone   = $_.Zone
                Risk   = [int]$_.Risk
                Status = $_.Status
                Lead   = $_.Lead
            }
        })
}

function Export-MissionData {
    param(
        [Parameter(Mandatory = $true)][object[]]$Missions,
        [Parameter(Mandatory = $true)][string]$Path
    )
    $Missions | Select-Object Id, Zone, Risk, Status, Lead |
        Export-Csv -LiteralPath $Path -NoTypeInformation
}

function Get-NextMissionId {
    param([object[]]$Missions)

    $largest = 0
    foreach ($mission in $Missions) {
        $number = 0
        if ($mission.Id -match '^M(\d+)$') {
            $number = [int]$Matches[1]
        }
        if ($number -gt $largest) { $largest = $number }
    }
    'M{0:D3}' -f ($largest + 1)
}

function New-Mission {
    param(
        [Parameter(Mandatory = $true)][string]$Id,
        [Parameter(Mandatory = $true)][string]$Zone,
        [ValidateRange(0, 5)][int]$Risk,
        [ValidateSet('Monitoring', 'Active', 'Complete')][string]$Status,
        [Parameter(Mandatory = $true)][string]$Lead
    )
    [pscustomobject]@{
        Id = $Id; Zone = $Zone; Risk = $Risk; Status = $Status; Lead = $Lead
    }
}

function Get-MissionSummary {
    param([object[]]$Missions)
    [pscustomobject]@{
        Total    = @($Missions).Count
        Active   = @($Missions | Where-Object Status -eq 'Active').Count
        HighRisk = @($Missions | Where-Object { [int]$_.Risk -ge 4 }).Count
    }
}

