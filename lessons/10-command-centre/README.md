# Lesson 10 — Hero Command Centre

**Mission:** Plan, complete, test, and explain an interactive command-centre program.<br>
**Learn:** decomposition, integration, separation of concerns, persistence, iterative delivery, testing, and reflection.<br>
**Recharge:** every feature should connect to a concept practised in Lessons 1–9.

## A realistic 60-minute capstone

Finishing a smaller reliable level is success. Students should complete levels in order rather than attempting every possible feature.

| Minutes | Activity |
|---:|---|
| 0–8 | Choose a user and sketch one useful workflow |
| 8–15 | Run the scaffold and map its parts to earlier lessons |
| 15–32 | Complete the **Ready** level |
| 32–44 | Attempt the **Operational** level |
| 44–52 | Test normal, boundary, and invalid paths |
| 52–56 | Pair review and improve one behavior/message |
| 56–58 | Publish bonus |
| 58–60 | Demo and reflection |

The project can extend into a second session for persistence internals, hardening, or specialist features.

## Design before code

Complete:

- My user is ...
- They need to ...
- My smallest useful version can ...
- It receives ... and produces ...
- One thing that could go wrong is ...
- I will know it works when ...

## Concept map

| Course concept | Command-centre use |
|---|---|
| Variables/input | menu choice and mission details |
| Calculations | summary counts and readiness score |
| Decisions | validation and menu routing |
| Loops | keep showing the menu |
| Collections/objects | mission records |
| Functions | view, summarize, create, load, save |
| Files | persistent CSV log |
| Error handling | safe load/save and invalid input |
| JSON | optional export |

## Program architecture

The completed reference separates three responsibilities:

```text
Interface (prompts/menu)
        ↓ calls
Logic (create, summarize, identify)
        ↓ reads/writes
Storage (CSV or optional JSON)
```

Keeping these concerns separate makes logic easier to test without typing through the menu. The reference dot-sources `CommandCentre.Core.ps1`; dot-sourcing loads its function definitions into the current script:

```powershell
. (Join-Path $PSScriptRoot 'CommandCentre.Core.ps1')
```

The starter keeps more code together so students can enter at a familiar level, while providing working load/save scaffolding.

## Run the starter

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\final-project\starter.ps1
```

The first run copies versioned seed data to the ignored `mission-log.csv`. Experiments therefore leave the original seed intact.

## Completion levels

### 1. Ready — expected one-hour core

- Complete `Show-Missions` so records are sorted and displayed.
- Complete `Get-MissionSummary` so total, active, and high-risk counts are correct.
- Confirm the menu repeats and quits.
- Run the supplied manual tests.

### 2. Operational — interactive creation

- Ask for zone, risk, status, and lead.
- Validate risk with `TryParse` and range 0–5.
- Reject blank zone/lead and unknown status.
- Create a consistent object and add it to the collection.
- Confirm it appears in view and summary.

### 3. Persistent — data survives restart

- Trace the supplied import and export scaffold.
- Add a mission, quit, reopen, and confirm it remains.
- Explain why seed and working-log files are separate.

### 4. Hardened — failures are safe

- Catch missing/malformed data with an actionable message.
- Permit retry instead of abandoning a partially entered mission.
- Verify a save by re-importing it.
- Consider writing to a temporary file before replacing the live log.

### 5. Specialist — choose one

- Search by zone, lead, status, or minimum risk.
- Edit or close a mission.
- Delete only after confirmation.
- Export a nested JSON dashboard.
- Calculate readiness or status statistics.
- Add an automated test for a new logic function.

## Menu and `switch`

The menu's `while` loop repeats until `$running` becomes false. `switch` compares one value against several labelled cases and is clearer here than a long chain of equality checks:

```powershell
switch ($choice.ToUpper()) {
    '1' { Show-Missions $missions }
    'Q' { $running = $false }
    default { Write-Warning 'Choose a listed option.' }
}
```

`continue` starts the next menu iteration after invalid feature input.

## Manual test record

Record actual output as well as pass/fail.

| Test | Input | Expected |
|---|---|---|
| View | `1` | all records sorted |
| Summary | `3` | counts match visible data |
| Add normal | valid mission | new consistent record |
| Risk boundaries | `0`, `5` | accepted |
| Risk invalid | word, `-1`, `6` | message; app continues |
| Blank zone | spaces | rejected |
| Unknown menu | `X` | menu guidance; app continues |
| Persistence | add, quit, restart | record remains |
| Quit | `Q` | save and friendly close |

The completed reference includes lightweight automated tests in `final-project/tests`. Its `Assert-Equal` helper throws when actual behavior differs from expected behavior.

## Reading the completed reference

Some reference constructs are ceiling material:

- `[Parameter(Mandatory)]` and `[ValidateSet()]` declare function contracts.
- regex `^M(\d+)$` and `$Matches` extract the numeric portion of an ID.
- `$ErrorActionPreference = 'Stop'` makes uncaught operation errors terminating in that script.
- dot-sourcing separates reusable logic from the interactive interface.
- temporary test paths and GUIDs keep automated tests isolated.

Students do not need to reproduce every construct to complete the Ready or Operational levels.

## Review and rubric

Use 20 points: correct behavior 8, appropriate concepts 5, clarity 3, testing 2, explanation/demo 2. Prefer a small dependable application the author understands over a large copied application.

## Bonus bite — Publish responsibly

Review `git diff`, run `scripts/Test-Course.ps1`, and check for secrets/private data. If class policy allows, commit on a focused branch and open a pull request explaining behavior and tests.

## Final reflection

Explain one design choice, one bug you investigated, one test that changed your thinking, and one feature you would build next.

**Previous:** [Lesson 9](../09-data/README.md) · **Course home:** [README](../../README.md)

