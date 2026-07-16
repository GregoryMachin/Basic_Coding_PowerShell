$checklist = @('Beacon ready', 'Map ready', 'First-aid kit ready')

for ($count = 5; $count -ge 1; $count--) {
    Write-Host $count
}
Write-Host 'Launch!'

$readyCount = 0
foreach ($item in $checklist) {
    Write-Host "[CHECK] $item"
    if ($item -match 'ready') {
        $readyCount++
    }
}
Write-Host "$readyCount of $($checklist.Count) items report ready."

