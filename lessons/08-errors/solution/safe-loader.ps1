param([string]$Path = (Join-Path $PSScriptRoot 'missing-status.txt'))

try {
    $content = Get-Content -LiteralPath $Path -ErrorAction Stop
    [pscustomobject]@{ Source = $Path; UsedFallback = $false; Lines = @($content).Count }
}
catch [System.Management.Automation.ItemNotFoundException] {
    [pscustomobject]@{ Source = 'built-in fallback'; UsedFallback = $true; Lines = 0 }
}
catch {
    throw "Could not load status data: $($_.Exception.Message)"
}
finally {
    Write-Verbose 'Status load attempt complete'
}
