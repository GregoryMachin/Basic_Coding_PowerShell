# Lesson 9 — City Data Network

**Mission:** Turn nested JSON into a trustworthy status dashboard.<br>
**Learn:** JSON structure, object mapping, nested properties, conversion depth, schema checks, timestamps, freshness, and safe web-service patterns.<br>
**Recharge:** CSV represents repeated rows; JSON can represent nested objects and arrays.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–10 | Map JSON syntax to PowerShell values |
| 10–22 | Navigate nested status data |
| 22–32 | Filter, sort, and summarise |
| 32–45 | Dispatch-shortlist challenge |
| 45–52 | Validate fields and freshness |
| 52–58 | Bonus bite: GitHub collaboration |
| 58–60 | Exit ticket |

## JSON anatomy

- `{}` contains an object with named properties.
- `[]` contains an ordered array.
- Strings use quotes; numbers and Booleans do not.
- Objects may contain nested objects and arrays.

```powershell
$city = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
$firstZone = $city.zones[0]
Write-Host $firstZone.name
Write-Host $firstZone.lead.name
```

`ConvertFrom-Json` maps JSON objects to PowerShell objects and arrays to collections. `ConvertTo-Json` performs the reverse operation. Use sufficient `-Depth` when exporting nested objects; otherwise deeper values may be abbreviated.

## CSV or JSON?

CSV is compact and convenient when every record has the same flat columns. JSON is better when records contain nested structures or different kinds of values. Neither format proves that the data is correct or safe.

## Trust but verify

Before using external or local data, ask:

- Does the expected property exist?
- Is its value the expected type and range?
- When was the snapshot updated?
- What should happen when it is missing or malformed?
- Who produced the data, and is that source appropriate?

Parse a timestamp deliberately:

```powershell
[datetimeoffset]$updated = $city.updated
$age = [datetimeoffset]::Now - $updated
```

## Guided build

Run `examples/status-dashboard.ps1`. Trace one zone from raw JSON through sorting, property selection, and formatted output. Add a count and identify the highest alert.

## Challenge — Dispatch shortlist

**Core:** load JSON, keep alert level 3 or higher, sort descending, and display name, alert level, lead name, and channel.<br>
**Power-up:** calculate total zones, high-alert count, and highest-alert zone.<br>
**Power-up:** verify `city`, `updated`, and `zones` exist and every alert level is 0–5.<br>
**Power-up:** calculate snapshot age and warn when it exceeds a chosen limit.<br>
**Mission specialist:** export the shortlist with `ConvertTo-Json -Depth 4`, read it back, and compare counts.<br>
**Team-up:** alter a copied snapshot, predict the output, and identify whether the change is valid, stale, or malformed.

## Optional web-service extension

An API commonly returns JSON through HTTP. Concepts include endpoint, `GET`, status code, timeout, and authentication. If a teacher supplies an approved endpoint, fetch with `Invoke-RestMethod`, validate the result, and fall back to the versioned local snapshot. Never embed passwords or API keys in course code or public Git history.

The main lesson remains local so it is repeatable, private, and available offline.

## Tests

Try missing `zones`, an empty array, alert `9`, missing lead, invalid timestamp, and one-element shortlist. Check both what the program displays and whether exported JSON can be imported again.

## Checkpoint

You can navigate nested JSON, choose JSON versus CSV, explain `-Depth`, validate required fields, and describe a safe local fallback.

## Bonus bite — GitHub collaboration

An issue describes work; a pull request proposes a reviewable change. Use a focused branch, link the issue, explain tests, and review behaviour rather than the person. Follow class policy before creating accounts or pushing data.

## Exit ticket

Why can syntactically valid JSON still be unsafe or unsuitable for a program?

**Previous:** [Lesson 8](../08-errors/README.md) · **Next:** [Hero Command Centre](../10-command-centre/README.md)
