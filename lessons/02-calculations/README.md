# Lesson 2 — Power-Up Calculations

**Mission:** Build a gadget energy calculator.  
**Learn:** input, integers, arithmetic, conversion, and formatted output.  
**Recharge:** variables store values; `Write-Host` displays them.

## 60-minute flight plan

0–5 story/recap; 5–15 types demo; 15–30 guided calculator; 30–45 challenge; 45–52 testing; 52–58 bonus; 58–60 exit ticket.

## Story hook

The academy's Beacon Pack must have enough energy for a mission without being overloaded. Computers calculate quickly, but only when we give them the right kind of data.

Run the complete example:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\02-calculations\examples\power-rating.ps1
```

## Decode the example

```powershell
[int]$batteryUnits = 8
[int]$boost = 3
$totalPower = ($batteryUnits * 10) + ($boost * 5)
```

- `[int]` means whole-number integer.
- `+`, `-`, `*`, and `/` perform arithmetic.
- Parentheses make the intended order clear.
- `Read-Host` always returns text. Convert numeric answers with `[int]` when appropriate.
- `$number.GetType().Name` reveals a value's type.

Try predicting `10 + 2 * 3`, then compare it with `(10 + 2) * 3`.

## Challenge — Beacon battery planner

Open `challenge/starter.ps1`.

**Core:** calculate energy used as `minutes * 4`, then remaining energy from a starting value of 100.  
**Power-up:** calculate the percent remaining and display `SAFE` when it is at least 20; you may preview Lesson 3 with `if`.  
**Team-up:** invent three test cases: normal, boundary, and extreme.

The solution uses parameters instead of prompts so the automated course test can run it. Try:

```powershell
.\lessons\02-calculations\solution\battery-planner.ps1 -Minutes 18
```

## Test table

| Minutes | Expected energy used | Expected remaining |
|---:|---:|---:|
| 0 | 0 | 100 |
| 10 | 40 | 60 |
| 25 | 100 | 0 |

What should happen above 25 minutes? For now the example clamps the answer at zero; Lesson 8 will validate it properly.

## Bonus bite — Terminal control

- Up arrow recalls the last command.
- `Tab` completes file and folder names.
- `Ctrl+C` stops a running script.
- `Clear-Host` clears visual clutter but not variables.
- `Get-History` shows recent commands in the current session.

## Exit ticket

Why does input from `Read-Host` sometimes need `[int]` before arithmetic?

**Previous:** [Lesson 1](../01-welcome/README.md) · **Next:** [Mission Decisions](../03-decisions/README.md)

