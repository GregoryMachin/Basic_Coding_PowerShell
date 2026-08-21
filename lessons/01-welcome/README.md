# Lesson 1 — Welcome to Signal Academy

**Mission:** Create an interactive hero ID card.<br>
**Learn:** scripts, output, input, variables, common data types, strings, and calculations.<br>
**You need:** no previous coding knowledge.

## 60-minute flight plan

| Minutes | Activity |
|---:|---|
| 0–5 | Meet the academy and predict what code can automate |
| 5–15 | Run a first command and inspect an error safely |
| 15–32 | Explore variables and live-code `examples/hero-id.ps1` |
| 32–45 | Complete the core challenge |
| 45–52 | Power-up/team-up extensions and pair demo |
| 52–58 | Bonus bite: VS Code navigation |
| 58–60 | Exit ticket |

## Story hook

Signal Academy trains helpers who combine courage with careful thinking. Your first task is to create an ID card for a new recruit. Code is a list of precise instructions; PowerShell runs those instructions from top to bottom.

## Why are we using PowerShell?

PowerShell is already included with standard Windows 10 and 11 computers, so you can begin coding without first installing a separate programming language. It also has extensive documentation and a built-in help system.

The aim of this course is not to memorise every PowerShell command. You are using PowerShell to learn how programs store information, make decisions, repeat work, organise data, handle mistakes, and solve larger problems one step at a time. Those ideas also appear in languages such as Python, JavaScript, and C#. If you choose another language later, its punctuation and command names will look different, but much of the thinking will transfer.

## Launch

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\01-welcome\examples\hero-id.ps1
```

The script asks you to enter a hero name in the terminal. Run it again with a different name and observe which parts of the output change.

## What is a variable?

A **variable** is a named place where a program stores a value while it is running. Giving useful names to values lets us reuse them, change them in one place, and explain what they mean.

```powershell
# A comment is a note for humans.
$heroName = "Nova Quill"
Write-Host "Recruit: $heroName"
```

- PowerShell variable names start with `$`.
- `=` assigns the value on its right to the name on its left.
- `$heroName` is the variable's name; `"Nova Quill"` is its current value.
- A value can change later: `$heroName = "Echo Lantern"` replaces the old value.

Variables exist in memory while the script runs. They are not automatically saved for next time. Later lessons use files when information needs to persist.

Choose names that describe the stored information, such as `$batteryLevel`, rather than vague names such as `$x`.

## Common variable types

A value's **type** tells PowerShell what kind of data it represents and what operations make sense.

| Type | Example | Used for |
|---|---|---|
| String (`[string]`) | `'Nova Quill'` | names, messages, and other text |
| Integer (`[int]`) | `12` | whole numbers and counters |
| Decimal (`[double]`) | `7.5` | measurements and calculations with fractions |
| Boolean (`[bool]`) | `$true` | yes/no or on/off states |

### String: text

A string is a sequence of characters: letters, numbers, spaces, or punctuation treated as text. Use strings for information such as a hero's name, a district, a description, or a message shown to the user.

```powershell
[string]$heroName = 'Nova Quill'
[string]$welcomeMessage = "Welcome, $heroName!"
```

Even if a string contains digits, PowerShell treats them as text. For example, `'12'` may be part of an ID such as `'Mission-12'`, but it should normally be converted to a numeric type before doing maths with it.

### Integer: whole numbers

An integer stores a positive or negative whole number with no decimal part. Use integers for counts, levels, scores, menu choices, and other values where fractions do not make sense.

```powershell
[int]$missionsCompleted = 3
[int]$nextMission = $missionsCompleted + 1
```

### Double: numbers with decimal places

A double stores numbers that may have a fractional part. Use doubles for distances, speeds, times, averages, and measurements.

```powershell
[double]$distanceKm = 12.5
[double]$travelTimeHours = $distanceKm / 25
```

`[double]` is suitable for the measurements in this course. Some decimal values cannot be represented perfectly by a computer, so financial software often uses the separate `[decimal]` type when exact base-10 calculations matter.

### Boolean: true or false

A Boolean stores one of two values: `$true` or `$false`. Use it for questions with a yes/no answer, such as whether a beacon is ready or a mission is complete. Booleans are especially useful in decisions, which Lesson 3 explores.

```powershell
[bool]$beaconReady = $true
[bool]$missionComplete = $false
```

Do not put quotes around `$true` or `$false`; quoted values are strings instead of Booleans.

PowerShell can usually infer a type from the value:

```powershell
$district = 'Harbour Ward' # PowerShell infers String
$level = 2                 # PowerShell infers Int32
```

You can require a particular type with a **type constraint**:

```powershell
[int]$missionsCompleted = 3
[bool]$beaconReady = $true
```

Inspect a value's type with:

```powershell
$missionsCompleted.GetType().Name
```

Run `examples/variable-types.ps1` to see these types in action.

## Combining and calculating values

Variables become useful when a program combines them to create new information.

```powershell
$heroName = 'Nova Quill'
$district = 'Harbour Ward'
$introduction = "$heroName is assigned to $district."

[int]$trainingMissions = 3
[int]$rescueMissions = 2
$totalMissions = $trainingMissions + $rescueMissions
```

The first example uses **string interpolation** to insert variable values into a new string. The second adds numeric values. The result can be stored in another variable and reused.

Text inside quotes is a **string**.

- Double quotes replace `$heroName` with its value; single quotes display the characters literally.
- `Write-Host` displays a message. Its console colour is decoration, not the data itself.

Try `Write-Host 'Recruit: $heroName'`. Why is the result different?

## Getting input with `Read-Host`

Hard-coded values are useful while learning, but input lets the same script respond to different users:

```powershell
$heroName = Read-Host 'Enter your hero name'
Write-Host "Welcome to Signal Academy, $heroName!"
```

`Read-Host` displays a prompt, waits for the user to type, and returns what they entered as a string. When you need a number, convert or constrain it:

```powershell
[int]$missionsCompleted = Read-Host 'How many missions have you completed'
$nextMilestone = $missionsCompleted + 1
```

Entering text where `[int]` expects a whole number produces an error. That is useful evidence about the program's assumptions; Lesson 8 teaches how to validate input and recover calmly.

## Challenge — Your hero card

Open `challenge/starter.ps1`. Replace every `TODO`, then run it.

**Core:** use `Read-Host` to ask for a codename and home district; store and display a special skill and motto.<br>
**Power-up:** ask for a numeric `$missionsCompleted`, calculate the next milestone, and display both values.<br>
**Team-up:** swap files with a partner and identify the name, value, and type of each variable.

Compare behaviour with `solution/hero-card.ps1` only after your own attempt.

## Checkpoint

You are ready when you can:

- explain what a variable stores;
- name the four value types introduced in this lesson;
- combine strings and perform a calculation using variables;
- collect input with `Read-Host`;
- predict which line prints first;
- change the output by editing one value.

## Bonus bite — VS Code navigator

1. Use `Ctrl+P`, type `starter.ps1`, and press Enter.
2. Use `Ctrl+S` to save.
3. Use ``Ctrl+` `` to show/hide the terminal.
4. Use `Ctrl+/` to turn the current line into a comment.

These shortcuts change editor speed, not program behaviour.

## Exit ticket

In one sentence: what is the difference between a variable name and its value?

**Next:** [Power-Up Calculations](../02-calculations/README.md)
