# Lesson 5 — Team Rosters

**Mission:** Represent a team and find the right member for a task.  
**Learn:** arrays, hashtables, custom objects, properties, filtering, and sorting.  
**Recharge:** `foreach` can inspect every item; `if` can select matching items.

## Flight plan

0–5 roster hook; 5–15 collection types; 15–30 build objects; 30–45 challenge; 45–52 query contest; 52–58 Git branch; 58–60 exit.

## Choose a collection

```powershell
$skills = @('Navigation', 'First aid')       # ordered list
$hero = @{ Name = 'Patch'; Level = 4 }       # key/value lookup
$member = [pscustomobject]@{                  # record with properties
    Name  = 'Patch'
    Skill = 'First aid'
    Level = 4
}
```

Run `examples/rescue-roster.ps1`. The pipeline `|` passes objects from one command to the next. PowerShell pipelines pass structured objects, not merely displayed text.

## Challenge — Build and query a roster

Open `challenge/starter.ps1`.

**Core:** add a third original member and use `Where-Object` to show members whose level is at least 3.  
**Power-up:** sort by level descending and select the first member.  
**Team-up:** design a fair rule for selecting a team; discuss what useful information your data leaves out.

Useful patterns:

```powershell
$roster | Where-Object { $_.Level -ge 3 }
$roster | Sort-Object Level -Descending
```

`$_` means “the current pipeline object.” Formatting commands belong at the end because they turn useful objects into display instructions.

## Bonus bite — Safe experiments with branches

```powershell
git status
git switch -c roster-experiment
# On older Git: git checkout -b roster-experiment
git branch
```

A branch is a movable label for a line of snapshots. Commit your experiment before switching back. Your teacher can demonstrate merging; you do not need it for the next lesson.

## Exit ticket

When would an array be a better choice than one hashtable?

**Previous:** [Lesson 4](../04-loops/README.md) · **Next:** [Reusable Mission Tools](../06-functions/README.md)

