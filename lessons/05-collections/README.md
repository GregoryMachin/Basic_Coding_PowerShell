# Lesson 5 — Team Rosters

**Mission:** Model a rescue team and query it fairly.<br>
**Learn:** arrays, hashtables, custom objects, properties, pipelines, filtering, sorting, selecting, grouping, and aggregation.<br>
**Recharge:** loops inspect items one at a time; collections keep related items together.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–10 | Compare arrays, hashtables, and objects |
| 10–20 | Build consistent roster records |
| 20–32 | Trace objects through a pipeline |
| 32–45 | Roster-query challenge |
| 45–52 | Group, count, and review selection rules |
| 52–58 | Bonus bite: Git branches |
| 58–60 | Exit ticket |

## Three useful structures

### Array: ordered items

```powershell
$skills = @('Navigation', 'First aid', 'Engineering')
Write-Host $skills[0]
Write-Host $skills.Count
```

Arrays answer “which item is at this position?” Positions begin at zero.

### Hashtable: values by key

```powershell
$hero = @{ Name = 'Patch'; Level = 4 }
Write-Host $hero['Name']
```

Hashtables are flexible key/value lookups. They are useful for settings and quick records, but property order and display are not their main purpose.

### Custom object: a consistent record

```powershell
$member = [pscustomobject]@{
    Name  = 'Patch'
    Skill = 'First aid'
    Level = 4
}
Write-Host $member.Skill
```

Use an array of custom objects for table-like records. Give every roster member the same properties so later commands can treat them consistently.

## Objects through a pipeline

PowerShell's pipeline passes structured objects, not merely displayed text:

```powershell
$qualified = $roster |
    Where-Object { $_.Level -ge 3 } |
    Sort-Object Level -Descending
```

- `|` passes output to the next command.
- `$_` is the current pipeline object inside the script block.
- `Where-Object` keeps matching objects.
- `Sort-Object` changes their order.
- `Select-Object` chooses or calculates properties.
- `Group-Object` groups equal property values.
- `Measure-Object` counts or calculates numeric summaries.

Keep `Format-Table` at the display boundary. Formatting instructions are difficult to filter, export, or calculate with afterward.

## Guided build

Run `examples/rescue-roster.ps1`. Pause after each pipeline stage and inspect:

```powershell
$roster
$qualified
$qualified | Select-Object Name, Skill, Level
```

Add one consistent property, such as `Available`, to every object and update the filter.

## Challenge — Build and query a roster

**Core:** add a third member, filter level 3 or higher, sort descending, and select a suggested lead.<br>
**Power-up:** require both sufficient level and availability.<br>
**Power-up:** group members by skill and display each group count.<br>
**Mission specialist:** calculate average level and create a calculated `Readiness` property.<br>
**Team-up:** design a selection rule, then list important information the data does not capture. A program can apply a rule consistently without proving that the rule is fair.

Calculated property pattern:

```powershell
$roster | Select-Object Name, @{ Name = 'Readiness'; Expression = { $_.Level * 20 } }
```

## Tests

Try no matching members, tied levels, one unavailable high-level member, and a missing skill. Decide whether `Select-Object -First 1` needs a tie-breaking rule.

## Checkpoint

You can choose a collection type, access an item/property, explain `$_`, trace a multi-stage pipeline, and keep formatting at the end.

## Bonus bite — Safe experiments with branches

```powershell
git status
git switch -c roster-experiment
git branch
```

On older Git use `git checkout -b roster-experiment`. Commit before switching branches, and merge only with teacher guidance.

## Exit ticket

Why is an array of consistent custom objects useful for a roster?

**Previous:** [Lesson 4](../04-loops/README.md) · **Next:** [Reusable Mission Tools](../06-functions/README.md)

