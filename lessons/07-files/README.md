# Lesson 7 — Clue Files

**Mission:** Save and analyse city sensor readings.  
**Learn:** paths, text files, CSV, importing/exporting, and pipelines.  
**Recharge:** objects hold related properties; pipelines pass those objects onward.

## Flight plan

0–5 persistence hook; 5–15 paths/files; 15–30 CSV analysis; 30–45 challenge; 45–52 inspect output; 52–58 Git diff; 58–60 exit.

## Why files?

Variables disappear when a PowerShell process ends. Files keep data for later. Use `Join-Path` and `$PSScriptRoot` so scripts work regardless of the terminal's current folder.

```powershell
$dataPath = Join-Path $PSScriptRoot '..\data\signals.csv'
$signals = Import-Csv $dataPath
```

CSV stores rows and columns as plain text. Imported numeric cells begin as strings, so convert when comparing or calculating: `[int]$_.Strength`.

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\07-files\examples\clue-analyser.ps1
```

## Challenge — Alert report

Open `challenge/starter.ps1`.

**Core:** import the supplied CSV, keep readings below 5, and export them to `workspace/alerts.csv`.  
**Power-up:** add a `Priority` calculated property (`High` at strength 2 or below, otherwise `Medium`).  
**Team-up:** open the output as text and explain header, row, and delimiter.

Use `-NoTypeInformation` with `Export-Csv` for clean PowerShell 5.1 output. Never treat an unknown downloaded file as trusted code.

## Bonus bite — Inspect a Git diff

```powershell
git status
git diff -- lessons/07-files/challenge/starter.ps1
git diff --word-diff
```

Red/removed and green/added lines describe a change; they do not mean the code is good or bad. Review generated files before committing and keep private data out of Git.

## Exit ticket

Why is `$PSScriptRoot` more reliable than assuming the terminal is in a particular folder?

**Previous:** [Lesson 6](../06-functions/README.md) · **Next:** [Safe Operations](../08-errors/README.md)

