$roster = @(
    [pscustomobject]@{ Name = 'River Byte'; Skill = 'Logistics'; Level = 2; Available = $true }
    [pscustomobject]@{ Name = 'Solar Finch'; Skill = 'Aerial survey'; Level = 4; Available = $true }
    # TODO: Add a third original member with the same four properties.
)

# TODO: Keep members whose Level is at least 3.
$qualified = $roster
# TODO: Sort by Level descending, then Name.
$ranked = $qualified
# TODO: Select the first ranked member as $lead.
$lead = $null

$ranked | Format-Table -AutoSize
Write-Host "Suggested lead: $($lead.Name)"

