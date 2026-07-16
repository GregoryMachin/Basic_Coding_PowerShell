# Lesson 6 — Reusable Mission Tools

**Mission:** Turn repeated steps into a mission toolkit.  
**Learn:** functions, parameters, return values, scope, and single responsibility.  
**Recharge:** loops repeat immediately; functions package behavior to call when needed.

## Flight plan

0–5 toolkit hook; 5–15 function anatomy; 15–30 guided functions; 30–45 challenge; 45–52 test calls; 52–58 README bonus; 58–60 exit.

## Function anatomy

```powershell
function Get-MissionScore {
    param([int]$PeopleHelped, [int]$Minutes)
    return ($PeopleHelped * 10) - $Minutes
}

$score = Get-MissionScore -PeopleHelped 8 -Minutes 20
```

PowerShell uses approved verb-noun names such as `Get-`, `Test-`, and `ConvertTo-`. `Get-Verb` lists approved verbs. Parameters are a function's inputs; output is data written to the success stream. Prefer returning useful data and let the caller decide how to display it.

Run `examples/mission-tools.ps1`.

## Challenge — Distance and readiness tools

Open `challenge/starter.ps1`.

**Core:** finish `ConvertTo-TravelMinutes` (distance divided by speed, multiplied by 60) and `Test-MissionReady` (battery at least 25 and team size at least 2).  
**Power-up:** add validation attributes such as `[ValidateRange(1, 500)]`.  
**Team-up:** write three calls for each function and predict the output before running.

Keep each function focused on one job. This makes it easier to reuse and test.

## Bonus bite — Write a useful README

A project README should answer:

1. What does this do?
2. What is required?
3. How do I run it?
4. What input and output should I expect?
5. Where can I get help?

Add a three-line “How to run” section to a challenge folder. Markdown uses `#` for headings and triple backticks for code blocks. Preview with `Ctrl+Shift+V` in VS Code.

## Exit ticket

What is one advantage of returning data instead of printing inside every function?

**Previous:** [Lesson 5](../05-collections/README.md) · **Next:** [Clue Files](../07-files/README.md)

