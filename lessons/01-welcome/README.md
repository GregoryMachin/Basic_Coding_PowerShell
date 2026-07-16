# Lesson 1 — Welcome to Signal Academy

**Mission:** Create a hero ID card.  
**Learn:** scripts, output, comments, variables, strings, and interpolation.  
**You need:** no previous coding knowledge.

## 60-minute flight plan

| Minutes | Activity |
|---:|---|
| 0–5 | Meet the academy and predict what code can automate |
| 5–15 | Run a first command and inspect an error safely |
| 15–30 | Live-code `examples/hero-id.ps1` |
| 30–45 | Complete the core challenge |
| 45–52 | Power-up/team-up extensions and pair demo |
| 52–58 | Bonus bite: VS Code navigation |
| 58–60 | Exit ticket |

## Story hook

Signal Academy trains helpers who combine courage with careful thinking. Your first task is to create an ID card for a new recruit. Code is a list of precise instructions; PowerShell runs those instructions from top to bottom.

## Launch

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\01-welcome\examples\hero-id.ps1
```

Open the script beside the terminal. Change `$heroName`, save, and rerun it.

## Decode the example

```powershell
# A comment is a note for humans.
$heroName = "Nova Quill"
Write-Host "Recruit: $heroName"
```

- A **variable** is a named storage box. PowerShell variable names start with `$`.
- `=` assigns the value on its right to the name on its left.
- Text inside quotes is a **string**.
- Double quotes replace `$heroName` with its value; single quotes display the characters literally.
- `Write-Host` displays a message. Its console color is decoration, not the data itself.

Try `Write-Host 'Recruit: $heroName'`. Why is the result different?

## Challenge — Your hero card

Open `challenge/starter.ps1`. Replace every `TODO`, then run it.

**Core:** store and display a codename, home district, special skill, and motto.  
**Power-up:** add a numeric `$missionsCompleted` variable and display it.  
**Team-up:** swap files with a partner and explain each other's variables.

Compare behavior with `solution/hero-card.ps1` only after your own attempt.

## Checkpoint

You are ready when you can:

- explain what a variable stores;
- predict which line prints first;
- change the output by editing one value.

## Bonus bite — VS Code navigator

1. Use `Ctrl+P`, type `starter.ps1`, and press Enter.
2. Use `Ctrl+S` to save.
3. Use ``Ctrl+` `` to show/hide the terminal.
4. Use `Ctrl+/` to turn the current line into a comment.

These shortcuts change editor speed, not program behavior.

## Exit ticket

In one sentence: what is the difference between a variable name and its value?

**Next:** [Power-Up Calculations](../02-calculations/README.md)

