function Read-SignalStrength {
    $attempt = 1
    while ($attempt -le 3) {
        $answer = Read-Host "Attempt $attempt of 3: signal strength from 0 to 10"
        $strength = 0
        # TODO: Use [int]::TryParse($answer, [ref]$strength).
        # TODO: Explain parsing and range failures, then increment $attempt.
        # TODO: Return $strength when it is valid.
        $attempt++
    }
    throw 'No valid signal strength was entered after three attempts.'
}

try {
    $strength = Read-SignalStrength
    Write-Host "Accepted signal strength: $strength"
}
catch {
    Write-Warning $_.Exception.Message
}

