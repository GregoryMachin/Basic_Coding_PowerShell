$roster = @(
    [pscustomobject]@{ Name = 'River Byte'; Skill = 'Logistics'; Level = 2 }
    [pscustomobject]@{ Name = 'Solar Finch'; Skill = 'Aerial survey'; Level = 4 }
    # TODO: Add a third original member.
)

# TODO: Filter members whose Level is at least 3.
$qualified = $roster
$qualified | Format-Table -AutoSize

