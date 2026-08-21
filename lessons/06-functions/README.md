# Lesson 6 — Reusable Mission Tools

**Mission:** Turn calculations and rules into a reusable toolkit.<br>
**Learn:** functions, parameters, defaults, validation, output streams, structured results, scope, composition, and simple tests.<br>
**Recharge:** a loop repeats now; a function packages behaviour to call whenever it is needed.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–10 | Name, define, and call a function |
| 10–20 | Design typed parameters and output |
| 20–30 | Compose two functions |
| 30–44 | Mission-toolkit challenge |
| 44–52 | Test normal, boundary, and invalid calls |
| 52–58 | Bonus bite: useful README instructions |
| 58–60 | Exit ticket |

## Function anatomy

```powershell
function Get-MissionScore {
    param(
        [int]$PeopleHelped,
        [int]$Minutes
    )
    ($PeopleHelped * 10) - $Minutes
}

$score = Get-MissionScore -PeopleHelped 8 -Minutes 20
```

PowerShell prefers approved verb-noun names such as `Get-`, `Test-`, and `ConvertTo-`. `Get-Verb` lists approved verbs. Script parameters and function parameters use the same `param()` syntax, but function parameters receive values for one function call.

## Designing parameters

Parameters can have a type, default, requirement, and validation rule:

```powershell
param(
    [Parameter(Mandatory = $true)]
    [ValidateRange(0, 100)]
    [int]$BatteryPercent,

    [int]$TeamSize = 2
)
```

Mandatory and validation failures occur before the function body begins. Use friendly interactive validation when the program should let a user retry.

## PowerShell function output

Every value written to PowerShell's success stream becomes function output; `return` is not required:

```powershell
function Get-Double { param([int]$Number); $Number * 2 }
```

This also means an accidental command result can become unwanted output. Use `Out-Null`, assign the result, or `[void]` when a helper command should not return data. Prefer returning data and letting the caller decide how to display it.

Return one structured object when several related results belong together:

```powershell
[pscustomobject]@{ Minutes = 30; Ready = $true; Reason = 'Checks passed' }
```

## Scope and composition

Variables created inside a function normally belong to that function's local scope. Avoid changing global variables invisibly; accept input through parameters and return output instead.

A function can call another function. Small functions composed together are easier to explain and test than one large function that reads input, calculates, saves, and displays everything.

Run `examples/mission-tools.ps1` and identify which function calculates, which decides, and which combines their results.

## Challenge — Distance and readiness toolkit

**Core:** finish `ConvertTo-TravelMinutes` and `Test-MissionReady`, then call both.<br>
**Power-up:** add `[ValidateRange()]` rules that prevent zero speed and impossible percentages.<br>
**Power-up:** create `New-MissionPlan` that calls both helpers and returns a custom object.<br>
**Mission specialist:** add comment-based help or `[CmdletBinding()]` and inspect the function with `Get-Help`.<br>
**Team-up:** write three calls before coding and predict their exact outputs.

## Simple tests

A test compares expected and actual behaviour:

```powershell
$actual = ConvertTo-TravelMinutes -DistanceKm 12 -SpeedKmh 24
if ($actual -ne 30) { throw "Expected 30, got $actual" }
```

Test zero distance, fractional distance, the minimum ready battery, one-person team, and invalid zero speed. A good test failure explains what was expected and why.

## Checkpoint

You can describe parameters and output, avoid accidental output, explain local scope, compose functions, and write one repeatable test.

## Bonus bite — Write a useful README

A project README should state purpose, requirements, how to run it, expected input/output, and help. Add a short “How to run” section and preview Markdown with `Ctrl+Shift+V`.

## Exit ticket

Why is returning data usually more reusable than displaying it inside every function?

**Previous:** [Lesson 5](../05-collections/README.md) · **Next:** [Clue Files](../07-files/README.md)
