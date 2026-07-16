# Lesson 4 — Patrol Patterns

**Mission:** Scan several city zones without repeated code.  
**Learn:** `foreach`, `for`, `while`, counters, and avoiding infinite loops.  
**Recharge:** `if` selects a path; a loop repeats a path.

## Flight plan

0–5 repetition game; 5–15 loop types; 15–30 patrol scanner; 30–45 challenge; 45–52 trace/debug; 52–58 VS Code bonus; 58–60 exit.

## Three loop tools

- `foreach` visits every item in a collection—best when the items already exist.
- `for` counts with a known start and finish.
- `while` repeats while a condition remains true—best when the repeat count is unknown.

Run `examples/patrol-scanner.ps1`, then change one signal strength.

```powershell
foreach ($zone in $zones) {
    Write-Host "Scanning $zone"
}
```

Never run a `while` loop unless something inside can eventually make its condition false. Use `Ctrl+C` if a loop will not stop.

## Challenge — Countdown and scan

Open `challenge/starter.ps1`.

**Core:** use a `for` loop to count from 5 down to 1, print `Launch!`, then use `foreach` to display every checklist item.  
**Power-up:** count how many checklist items contain the word `ready`.  
**Team-up:** one person traces variable values on paper while the other runs the code.

## Bonus bite — Debug line by line

1. Open the challenge in VS Code and press `F9` on a code line to add a breakpoint.
2. Press `F5` and choose **PowerShell** if asked.
3. When execution pauses, inspect variables in the Run and Debug panel.
4. Press `F10` to step over one line and `F5` to continue.
5. Press `Shift+F5` to stop.

## Exit ticket

Which loop would you choose for a list of five districts, and why?

**Previous:** [Lesson 3](../03-decisions/README.md) · **Next:** [Team Rosters](../05-collections/README.md)

