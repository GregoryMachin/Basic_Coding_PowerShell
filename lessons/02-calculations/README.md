# Lesson 2 — Power-Up Calculations

**Mission:** Build an interactive gadget energy calculator.<br>
**Learn:** numeric input, conversion, arithmetic expressions, evaluation order, intermediate values, percentages, and formatted output.<br>
**Recharge:** variables store typed values; `Read-Host` collects text from the user.

## 60-minute flight plan

| Minutes | Activity |
|---:|---|
| 0–5 | Predict what happens when text and numbers are combined |
| 5–15 | Convert input and compare integer and decimal values |
| 15–28 | Build and trace the interactive power-rating calculator |
| 28–42 | Complete the core battery-planner challenge |
| 42–50 | Format results and run boundary tests |
| 50–52 | Choose a power-up extension |
| 52–58 | Bonus bite: control the terminal efficiently |
| 58–60 | Exit ticket |

## Story hook

The academy's Beacon Pack powers navigation, communications, and safety equipment. A mission planner must calculate whether the pack contains enough energy without confusing text, whole numbers, decimal values, or measurement units.

Computers calculate quickly and consistently, but they do exactly what the code says—not necessarily what its author intended. Clear variables, small calculation steps, and carefully chosen tests help us check that a result makes sense.

## Recharge — input begins as text

`Read-Host` always returns a string, even when the user types digits:

```powershell
$inputText = Read-Host 'Enter a number'
Write-Host $inputText.GetType().Name # String
```

The type affects what `+` means. With a string on the left, PowerShell combines text:

```powershell
$inputText = '7'
Write-Host ($inputText + 5) # Displays 75
```

Convert the text when it represents a number that will be used in a calculation:

```powershell
[int]$wholeNumber = $inputText
Write-Host ($wholeNumber + 5) # Displays 12
```

For this lesson, entering non-numeric text where `[int]` or `[double]` is required will stop the script with an error. Lesson 8 teaches how to validate input and recover without stopping.

## Choosing a numeric type

Use an integer when fractions do not make sense and a double when they might.

```powershell
[int]$batteryUnits = 8       # A count of complete battery units
[double]$distanceKm = 12.5   # A measurement that can contain a fraction
```

Division can produce a `Double` even when both starting values are integers:

```powershell
$average = 7 / 2
Write-Host $average                 # 3.5
Write-Host $average.GetType().Name  # Double
```

`[double]` is appropriate for measurements in this course. Software that requires exact base-10 arithmetic, such as financial software, often uses `[decimal]` instead.

## Arithmetic operators

| Operator | Meaning | Example | Result |
|---|---|---|---:|
| `+` | addition | `10 + 3` | 13 |
| `-` | subtraction | `10 - 3` | 7 |
| `*` | multiplication | `10 * 3` | 30 |
| `/` | division | `10 / 4` | 2.5 |
| `%` | remainder after division | `10 % 4` | 2 |

The remainder operator is useful for questions such as “is this number even?” or “how many units remain after filling complete groups?” It is optional in today's challenge.

## Evaluation order and intermediate variables

PowerShell normally evaluates multiplication and division before addition and subtraction. Parentheses make a different order explicit:

```powershell
10 + 2 * 3     # 16
(10 + 2) * 3   # 36
```

Long expressions can be divided into named intermediate results:

```powershell
$batteryPower = $batteryUnits * 10
$boostPower = $signalBoost * 5
$generatedPower = $batteryPower + $boostPower
```

This is equivalent to:

```powershell
$generatedPower = ($batteryUnits * 10) + ($signalBoost * 5)
```

The longer version is often easier to explain, inspect, and debug. The variable names also preserve the meaning of each value.

## Guided build — power-rating calculator

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\02-calculations\examples\power-rating.ps1
```

The script asks for the number of battery units and the signal-boost level. It keeps the shield load and number of systems fixed, so the first run remains manageable.

Before running it a second time:

1. Predict what will happen if the battery units increase by one.
2. Locate the intermediate variables for battery power and boost power.
3. Enter different values and compare the result with your prediction.
4. Change `$systemCount` from 3 to 4 and explain which output changes.

Notice that each numeric output includes a unit. A value such as `40` is ambiguous; `40 energy units` explains what the value represents.

## Formatting calculated output

Calculations can produce more decimal places than a report needs. PowerShell's `-f` format operator controls how a value is displayed:

```powershell
$averagePerSystem = 31 / 3
$displayAverage = '{0:N1}' -f $averagePerSystem
Write-Host "$displayAverage energy units"
```

- `{0}` means “insert the first supplied value here.”
- `N1` means display it as a number with one digit after the decimal point.
- `-f` connects the format string to the value.

Formatting does not change the original value stored in `$averagePerSystem`; it creates a display string. Confirm this with:

```powershell
Write-Host $averagePerSystem
Write-Host $averagePerSystem.GetType().Name
Write-Host $displayAverage.GetType().Name
```

## Challenge — Beacon battery planner

Open `challenge/starter.ps1`. The starter asks for:

- starting energy;
- mission duration in minutes;
- energy used per minute;
- optional boost cost.

Build the calculation one named step at a time:

```text
running energy = mission duration × energy per minute
total energy used = running energy + boost cost
remaining energy = starting energy − total energy used
percentage remaining = remaining energy ÷ starting energy × 100
```

Use positive starting energy so the percentage calculation does not divide by zero.

### Challenge levels

**Core:** complete all four calculations and display each result with its unit.

**Power-up — polished report:** format the percentage to one decimal place with `-f`.

**Power-up — realistic limit:** create `$safeRemaining` with `[Math]::Max(0, $remainingEnergy)` so the displayed battery cannot fall below zero. Keep `$remainingEnergy` as well so you can see the uncorrected calculation.

**Power-up — decision preview:** display `SAFE` when the clamped percentage is at least 20 and `RECHARGE` otherwise. This previews Lesson 3's `if` statement.

**Mission specialist:** calculate how many complete minutes the remaining energy can support. Decide what should happen when energy use per minute is zero.

**Team-up:** one student chooses inputs while the other predicts and traces every intermediate variable. Swap roles after each test.

The interactive core solution is `solution/battery-planner.ps1`. It mirrors the starter before showing the optional power-ups.

The separate `solution/battery-planner-advanced.ps1` demonstrates script parameters, validation attributes, `[Math]::Max()`, and an `if` decision. Those features are included as a preview; parameters are developed in Lesson 6, decisions in Lesson 3, and robust validation in Lesson 8.

Try the advanced version with repeatable command-line values:

```powershell
.\lessons\02-calculations\solution\battery-planner-advanced.ps1 `
    -StartingEnergy 100 -Minutes 18 -EnergyPerMinute 4 -BoostCost 5
```

## Test before trusting the result

Use starting energy `100`, energy per minute `4`, and boost cost `0` for these tests:

| Scenario | Minutes | Energy used | Raw remaining | Why test it? |
|---|---:|---:|---:|---|
| No use | 0 | 0 | 100 | lower boundary |
| Normal mission | 10 | 40 | 60 | typical behaviour |
| Exactly empty | 25 | 100 | 0 | exact boundary |
| Too long | 30 | 120 | −20 | reveals need for clamping |

Also discuss these inputs before trying them:

- `ten` for minutes: conversion fails because it is not numeric;
- `-5` minutes: the calculation runs, but the input does not make real-world sense;
- `0` starting energy: the percentage attempts to divide by zero;
- `2.5` minutes: `[double]` accepts it, but `[int]` would not preserve the fraction.

These are different kinds of problems. Arithmetic can be correct while the input or real-world assumption is invalid. Lesson 8 will make the program handle those situations safely.

## Teacher support prompts

- Ask “What is the value and type at this line?” rather than immediately correcting code.
- Have students say the units aloud while tracing a formula.
- If a long expression is confusing, split it into one intermediate variable per idea.
- Ask students to estimate first. A result of 6,000 instead of roughly 60 is easier to question when they have an expected range.
- Treat the advanced solution as an extension, not required knowledge for completing the lesson.

## Checkpoint

You are ready when you can:

- explain why numeric input from `Read-Host` needs conversion;
- choose `[int]` or `[double]` for a described value;
- trace an expression using its evaluation order;
- split a calculation into named intermediate variables;
- format a decimal for display;
- test a normal value and a boundary value.

## Bonus bite — Terminal control

- Up arrow recalls the previous command so you can change one input and rerun it.
- `Tab` completes file and folder names.
- `Ctrl+C` stops a running script.
- `Clear-Host` clears visual clutter but does not delete saved files.
- `Get-History` shows recent commands in the current terminal session.

Use the up arrow to rerun the advanced solution with one parameter changed. This creates a repeatable experiment: change one input, hold the others constant, and compare the result.

## Exit ticket

1. Why can `'7' + 5` behave differently from `[int]'7' + 5`?
2. Why might a programmer store part of a calculation in an intermediate variable?

**Previous:** [Lesson 1](../01-welcome/README.md) · **Next:** [Mission Decisions](../03-decisions/README.md)
