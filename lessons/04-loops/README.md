# Lesson 4 — Patrol Patterns

**Mission:** Scan city zones and repeat work safely.<br>
**Learn:** `foreach`, `for`, `while`, counters, trace tables, off-by-one errors, `break`, and `continue`.<br>
**Recharge:** an `if` chooses a path once; a loop can revisit a block many times.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–10 | Trace a `foreach` loop |
| 10–20 | Build and trace a counting `for` loop |
| 20–30 | Control a `while` loop safely |
| 30–44 | Countdown-and-scan challenge |
| 44–52 | Off-by-one and loop-control tests |
| 52–58 | Bonus bite: VS Code debugger |
| 58–60 | Exit ticket |

## Choose the loop that matches the problem

### `foreach`: visit existing items

```powershell
foreach ($zone in @('Harbour', 'Market', 'Gardens')) {
    Write-Host "Scanning $zone"
}
```

On each iteration, `$zone` refers to the next item. Use `foreach` when the collection already exists.

### `for`: count predictably

```powershell
for ($count = 5; $count -ge 1; $count--) {
    Write-Host $count
}
```

The three sections mean: initialize once; continue while the condition is true; update after each iteration. Confusing `-gt` with `-ge` often creates an **off-by-one error**.

| Iteration | `$count` | `$count -ge 1` | Output |
|---:|---:|---|---:|
| 1 | 5 | True | 5 |
| 5 | 1 | True | 1 |
| next check | 0 | False | stop |

### `while`: repeat until a condition changes

```powershell
$attempt = 1
while ($attempt -le 3) {
    Write-Host "Attempt $attempt"
    $attempt++
}
```

Something inside must eventually make the condition false. Use `Ctrl+C` to stop an accidental infinite loop.

## Controlling a loop

- `continue` skips the rest of the current iteration and starts the next.
- `break` exits the nearest loop immediately.

Use them when they make intent clearer, but avoid many exits that make control flow difficult to trace.

## Guided build

Run `examples/patrol-scanner.ps1`. Predict the alert count, change a strength, and trace `$alerts` after every iteration. Then run `examples/loop-lab.ps1` to see all three loop types.

## Challenge — Countdown and patrol scan

The starter provides a countdown and zone readings.

**Core:** complete the `for` countdown, use `foreach` to display each zone, and count weak signals.<br>
**Power-up:** use `continue` to skip a zone marked `Offline`.<br>
**Power-up:** use `break` after the first critical strength of 1.<br>
**Mission specialist:** use a `while` loop for up to three interactive rescan attempts.<br>
**Team-up:** one student traces variables in a table while the other executes. Swap roles.

## Tests

Test an empty list, one item, all strong, all weak, and a critical reading at the beginning versus the end. Explain how `break` changes the number of processed items.

For a grid extension, nest one `for` loop inside another and print coordinates such as `A1`, `A2`, `B1`, and `B2`.

## Checkpoint

You can choose a loop type, identify its stopping condition, trace a counter, and explain one off-by-one error.

## Bonus bite — Debug line by line

Set a breakpoint with `F9`, run with `F5`, inspect variables, and use `F10` to step. A conditional breakpoint such as `$signal.Strength -le 3` pauses only when its expression is true.

## Exit ticket

Why is `foreach` usually clearer than `for` for an existing list of district names?

**Previous:** [Lesson 3](../03-decisions/README.md) · **Next:** [Team Rosters](../05-collections/README.md)

