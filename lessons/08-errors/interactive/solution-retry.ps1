function Read-SignalStrength {
    $attempt = 1
    while ($attempt -le 3) {
        $answer = Read-Host "Attempt $attempt of 3: signal strength from 0 to 10"
        $strength = 0
        if (-not [int]::TryParse($answer, [ref]$strength)) {
            Write-Warning 'Enter a whole number.'
        }
        elseif ($strength -lt 0 -or $strength -gt 10) {
            Write-Warning 'Use a value from 0 to 10.'
        }
        else { return $strength }
        $attempt++
    }
    throw 'No valid signal strength was entered after three attempts.'
}

try { Write-Host "Accepted: $(Read-SignalStrength)" }
catch { Write-Warning $_.Exception.Message }

