# Lesson 8 — Safe Operations

**Mission:** Make input and file operations fail safely and explain what went wrong.<br>
**Learn:** expected invalid input, `TryParse`, retry loops, exceptions, terminating errors, typed catches, `throw`, `finally`, and useful error records.<br>
**Recharge:** `if` handles anticipated states; `try`/`catch` handles operations that throw.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–10 | Classify validation failures and exceptions |
| 10–22 | Parse input without throwing |
| 22–32 | Catch a failed file operation |
| 32–45 | Three-attempt signal challenge |
| 45–52 | Build and run a failure-test matrix |
| 52–58 | Bonus bite: conditional breakpoints |
| 58–60 | Exit ticket |

## Two kinds of failure

**Expected invalid input** is something the program can anticipate: blank input, a word where a number is required, or a value outside a range. Use parsing and conditions so the user can correct it.

**An exception** reports an operation that could not complete: a missing file, denied access, or malformed data. Use `try`/`catch` around the smallest operation that may throw.

Programmer mistakes also produce errors, but catching everything is not a substitute for finding and fixing a bug.

## Parse without throwing

```powershell
$answer = Read-Host 'Strength from 0 to 10'
$strength = 0
$isNumber = [int]::TryParse($answer, [ref]$strength)
```

`TryParse` returns a Boolean. `[ref]` lets the method place the parsed value into `$strength`. Check parsing first, then the allowed range.

```powershell
if (-not $isNumber) { Write-Warning 'Enter a whole number.' }
elseif ($strength -notin 0..10) { Write-Warning 'Use 0 through 10.' }
```

## Exceptions and error action

Some cmdlets report non-terminating errors and continue. `-ErrorAction Stop` turns that operation's error into one `catch` can handle:

```powershell
try {
    $data = Get-Content -LiteralPath $path -ErrorAction Stop
}
catch [System.Management.Automation.ItemNotFoundException] {
    Write-Warning "File not found: $path"
}
catch {
    Write-Warning "Load failed: $($_.Exception.Message)"
}
finally {
    Write-Verbose 'Load attempt finished'
}
```

A typed catch handles a known exception; the final generic catch handles others. `finally` runs whether the operation succeeds or fails, which is useful for cleanup. `throw` creates or rethrows a terminating error when the caller cannot safely continue.

Avoid hiding every error with `SilentlyContinue`. A useful message says what failed, where, and what the user can do.

## Guided build

Run `examples/safe-dispatcher.ps1`. Add `$_.Exception.GetType().Name` inside `catch`, then compare the missing-file failure with a valid file.

## Challenge — Three-attempt signal reader

**Core:** implement `TryParse`, range checking, and a clear message for each invalid case.<br>
**Power-up:** place it in `Read-SignalStrength` and allow three attempts with `while`.<br>
**Power-up:** return the valid number; throw a clear error after all attempts fail.<br>
**Mission specialist:** catch that error in a caller and choose a safe default.<br>
**Team-up:** run a failure matrix while recording expected and actual messages.

| Input | Expected |
|---|---|
| blank | whole-number message |
| `fast` | whole-number message |
| `-1` | range message |
| `0` | accepted boundary |
| `10` | accepted boundary |
| `11` | range message |

The interactive solution includes the retry loop. `solution/validate-strength.ps1` remains parameterized for repeatable automated checks, and `solution/safe-loader.ps1` demonstrates exceptions and fallback data.

## Checkpoint

You can distinguish validation from an exception, explain `[ref]`, make a cmdlet error terminating, inspect an error record, and decide where retry belongs.

## Bonus bite — Conditional breakpoint

Set a breakpoint inside the retry loop and give it condition `$attempt -eq 3`. Debugging lets you observe state; it does not repair the program automatically.

## Exit ticket

Why is a non-numeric answer usually validation, while a missing required file is usually handled as an exception?

**Previous:** [Lesson 7](../07-files/README.md) · **Next:** [City Data Network](../09-data/README.md)
