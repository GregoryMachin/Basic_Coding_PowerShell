param(
    [string]$InputValue = '7'
)

$strength = 0
if (-not [int]::TryParse($InputValue, [ref]$strength)) {
    Write-Host 'Invalid input: enter a whole number.'
    return
}

if ($strength -lt 0 -or $strength -gt 10) {
    Write-Host 'Invalid input: strength must be from 0 to 10.'
    return
}

Write-Host "Accepted signal strength: $strength"

