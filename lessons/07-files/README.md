# Lesson 7 — Clue Files

**Mission:** Persist, inspect, analyse, and verify city sensor readings.<br>
**Learn:** text and CSV files, safe paths, schemas, importing/exporting, encoding, overwrite/append behaviour, and round trips.<br>
**Recharge:** an object has properties; a CSV row becomes a PowerShell object.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–10 | Compare memory, text files, and CSV |
| 10–20 | Build safe script-relative paths |
| 20–32 | Import and inspect typed CSV values |
| 32–45 | Alert-report challenge |
| 45–52 | Export, re-import, and verify |
| 52–58 | Bonus bite: inspect a Git diff |
| 58–60 | Exit ticket |

## From temporary variables to persistent files

Variables normally disappear when the process ends. Files preserve data. Plain text is suited to human-readable lines; CSV is suited to repeated records with the same columns.

```powershell
$path = Join-Path $PSScriptRoot '..\data\signals.csv'
if (-not (Test-Path -LiteralPath $path)) { throw "Missing data: $path" }
$signals = Import-Csv -LiteralPath $path
```

- `$PSScriptRoot` is the current script's folder.
- `Join-Path` constructs a path without assuming the terminal location.
- `-LiteralPath` treats wildcard characters as ordinary filename characters.
- `Test-Path` checks before an operation.

## CSV structure and types

The first row contains headers; later rows contain corresponding values. Delimiters separate fields, and quotes protect values containing delimiters. `Import-Csv` creates one custom object per row.

CSV does not preserve PowerShell types: imported values initially behave like strings. Convert numeric fields at the calculation boundary:

```powershell
$weak = $signals | Where-Object { [int]$_.Strength -lt 5 }
```

A **schema** is the expected set and meaning of columns. Check important columns before trusting a file.

## Reading and writing

- `Get-Content` reads text lines; `-Raw` returns one string.
- `Set-Content` replaces a text file.
- `Add-Content` appends text.
- `Export-Csv` normally replaces its destination; `-Append` adds rows.
- `-NoTypeInformation` avoids the PowerShell 5.1 type header.

Be deliberate about overwrite versus append. Re-running an idempotent report should produce the same result rather than duplicate rows.

## Guided build

Run `examples/clue-analyser.ps1`. Inspect the first imported object with `$signals[0] | Format-List *`, then inspect `Strength.GetType().Name` before conversion.

## Challenge — Alert report

**Core:** check the input path, import CSV, keep strengths below 5, and export `workspace/alerts.csv`.<br>
**Power-up:** add a calculated `Priority` property.<br>
**Power-up:** re-import the output and confirm its row count matches the exported alerts.<br>
**Mission specialist:** create a text summary with count, average strength, and generation time.<br>
**Team-up:** inspect raw CSV and identify header, row, delimiter, quoted value, and schema assumption.

Calculated property:

```powershell
Select-Object Zone, @{ Name = 'Priority'; Expression = {
    if ([int]$_.Strength -le 2) { 'High' } else { 'Medium' }
} }
```

## Tests and safety

Test an empty data file, one row, no alerts, missing `Strength`, non-numeric strength, and a destination that already exists. Use invented data only. Never execute an unknown downloaded file merely because it arrived beside a trusted CSV.

Encoding controls how characters become bytes. Windows PowerShell 5.1 and newer tools can have different defaults, so specify encoding when a receiving system requires one and test non-ASCII names if they are allowed.

## Checkpoint

You can explain persistence, build a script-relative path, describe a CSV schema, convert imported types, and verify an export by reading it back.

## Bonus bite — Inspect a Git diff

```powershell
git status
git diff -- lessons/07-files/challenge/starter.ps1
git diff --word-diff
```

Review generated files before committing and keep private data out of Git.

## Exit ticket

Why should a program re-import an exported report during testing?

**Previous:** [Lesson 6](../06-functions/README.md) · **Next:** [Safe Operations](../08-errors/README.md)
