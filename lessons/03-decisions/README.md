# Lesson 3 — Mission Decisions

**Mission:** Build an interactive system that recommends a safe response.<br>
**Learn:** Boolean expressions, comparisons, compound conditions, branch order, decision tables, and boundary testing.<br>
**Recharge:** calculations create values; comparisons turn values into `$true` or `$false`.

## 60-minute flight plan

| Minutes | Activity |
|---:|---|
| 0–8 | Compare values and inspect Boolean results |
| 8–18 | Translate a decision table into conditions |
| 18–30 | Guided interactive mission selector |
| 30–44 | Weather-check challenge |
| 44–52 | Boundary and conflicting-condition tests |
| 52–58 | Bonus bite: first Git snapshot |
| 58–60 | Exit ticket |

## From questions to Booleans

A condition is an expression whose result is `$true` or `$false`:

```powershell
[int]$risk = 6
$isHighRisk = $risk -ge 8
Write-Host $isHighRisk # False
```

| Operator | Question | Example |
|---|---|---|
| `-eq` | equal? | `$status -eq 'Active'` |
| `-ne` | not equal? | `$status -ne 'Complete'` |
| `-gt` / `-ge` | greater than / at least? | `$risk -ge 8` |
| `-lt` / `-le` | less than / at most? | `$wind -le 30` |

PowerShell string comparisons are case-insensitive by default. Numeric comparisons should use numeric values, not numeric-looking strings.

## Combining conditions

```powershell
$launch = ($wind -le 30) -and (-not $lightning)
```

| A | B | `A -and B` | `A -or B` |
|---|---|---|---|
| `$false` | `$false` | `$false` | `$false` |
| `$false` | `$true` | `$false` | `$true` |
| `$true` | `$false` | `$false` | `$true` |
| `$true` | `$true` | `$true` | `$true` |

`-not` reverses one Boolean value. PowerShell also short-circuits: with `-and`, it does not evaluate the second condition when the first is already false; with `-or`, it stops once a condition is true.

## Decision tables before code

Write rules in a table so people can review them before translating them:

| Risk | People nearby | Response |
|---:|---|---|
| 8–10 | Yes | Full response team |
| 4–10 | Any other case | Scout team |
| 0–3 | Any | Remote monitoring |

Test the most specific or demanding rule first:

```powershell
if ($risk -ge 8 -and $peopleNearby) {
    $response = 'Full response team'
    $reason = 'High risk with people nearby'
}
elseif ($risk -ge 4) {
    $response = 'Scout team'
    $reason = 'Moderate or high risk'
}
else {
    $response = 'Remote monitoring'
    $reason = 'Low reported risk'
}
```

If `$risk -ge 4` appeared first, risk 9 would never reach the high-risk branch. Returning a reason makes the decision easier to inspect.

## Guided build

Run `examples/mission-selector.ps1`. Enter risk and whether people are nearby, then rerun it with a boundary value.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\03-decisions\examples\mission-selector.ps1
```

For now, enter the requested kind of value. Lesson 8 adds robust input validation.

## Challenge — Weather launch check

Open `challenge/starter.ps1` and implement this decision table:

| Lightning | Wind | Visibility | Result |
|---|---:|---:|---|
| Yes | Any | Any | `DO NOT LAUNCH` |
| No | Above 60 | Any | `DO NOT LAUNCH` |
| No | Any | Below 5 km | `DO NOT LAUNCH` |
| No | 31–60 | At least 5 km | `CAUTION` |
| No | 0–30 | At least 5 km | `CLEAR` |

**Core:** produce the correct status and a short reason.<br>
**Power-up:** calculate `$needsReview` using one compound Boolean expression.<br>
**Mission specialist:** add a `switch`-based recommendation for a separate text mission type such as `Rescue`, `Survey`, or `Delivery`.<br>
**Team-up:** one student supplies a test row while the other predicts the first matching branch. Swap roles.

The interactive solution mirrors the starter. The advanced solution uses repeatable script parameters and validation attributes; these are formally developed later.

## Test table

| Lightning | Wind | Visibility | Expected |
|---|---:|---:|---|
| No | 30 | 5 | `CLEAR` |
| No | 31 | 5 | `CAUTION` |
| No | 60 | 5 | `CAUTION` |
| No | 61 | 10 | `DO NOT LAUNCH` |
| Yes | 10 | 10 | `DO NOT LAUNCH` |
| No | 10 | 4 | `DO NOT LAUNCH` |

Boundary tests answer whether rules include or exclude their endpoints. Conflicting-condition tests confirm that the most important rule wins.

## Checkpoint

You can explain how a comparison produces a Boolean, combine conditions, translate a table into ordered branches, and justify a boundary test.

## Bonus bite — Your first Git snapshot

```powershell
git status
git add lessons/03-decisions/challenge/starter.ps1
git commit -m "Complete weather launch check"
```

A commit is a local named snapshot, not automatically a cloud upload. Review `git status` first and follow class identity/privacy policy.

## Exit ticket

Why should the most specific or highest-priority condition usually appear first?

**Previous:** [Lesson 2](../02-calculations/README.md) · **Next:** [Patrol Patterns](../04-loops/README.md)

