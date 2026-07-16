# Lesson 8 — Safe Operations

**Mission:** Make a dispatcher that handles incorrect input calmly.  
**Learn:** validation, terminating errors, `try`/`catch`/`finally`, and useful messages.  
**Recharge:** conditions handle expected choices; error handling deals with operations that fail.

## Flight plan

0–5 failure-as-information; 5–15 error anatomy; 15–30 safe dispatcher; 30–45 challenge; 45–52 failure tests; 52–58 breakpoints; 58–60 exit.

## Read errors like clues

Start with the first error, then locate the file and line. Separate user input problems from programmer bugs. Do not hide every error with `SilentlyContinue`; provide an actionable message.

```powershell
try {
    $data = Get-Content $path -ErrorAction Stop
}
catch [System.IO.FileNotFoundException] {
    Write-Warning "Could not find: $path"
}
finally {
    Write-Verbose 'Attempt complete'
}
```

`-ErrorAction Stop` converts many non-terminating cmdlet errors into errors that `catch` can handle.

Run `examples/safe-dispatcher.ps1`, which deliberately checks one valid and one missing file.

## Challenge — Validate a signal strength

Open `challenge/starter.ps1`.

**Core:** use `[int]::TryParse()` to accept only whole numbers, then check range 0–10. Display a helpful message for each invalid case.  
**Power-up:** put parsing in `Read-SignalStrength` and allow up to three attempts.  
**Team-up:** create a failure-test table containing blank, word, negative, boundary, and too-large inputs.

The solution accepts a parameter for repeatable automated testing. The starter is interactive and belongs in `interactive/`, so the course test intentionally skips it.

## Bonus bite — Conditional breakpoint

In VS Code, add a breakpoint in a loop. Right-click the red dot, choose **Edit Breakpoint**, and use a condition such as `$attempt -eq 3`. Debugging pauses the program so you can observe it; it does not repair it automatically.

## Exit ticket

When would you use an `if` statement instead of a `catch` block?

**Previous:** [Lesson 7](../07-files/README.md) · **Next:** [City Data Network](../09-data/README.md)

