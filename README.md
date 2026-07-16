# Signal Academy: PowerShell Hero Training

An original, beginner-friendly coding course for ages 13+ using the Windows PowerShell already installed on Windows.

Over ten one-hour lessons, recruits join **Signal Academy**, a fictional team that helps their city through planning, communication, science, and code. No existing comic-book characters, logos, stories, or catchphrases are used.

## Why PowerShell?

PowerShell was chosen because Windows PowerShell is included with standard Windows 10 and 11 installations. Students can write and run their first program without installing a separate programming language, configuring a compiler, or creating an online account. This removes much of the setup that can get in the way of a first coding experience.

PowerShell is also well documented by Microsoft and the wider technical community. Students therefore have access to extensive help, examples, and reference material when they are ready to explore beyond the course.

VS Code is the recommended editor because it makes scripts easier to read, run, and debug, but the programming examples themselves use the PowerShell already available on Windows.

## The real goal: learning to program

This is not primarily a course about memorising PowerShell commands. PowerShell is the tool used to explore the fundamental building blocks shared by many programming languages:

- values, variables, and data types;
- input, output, and calculations;
- decisions and Boolean logic;
- loops and collections;
- functions and reusable code;
- files and structured data;
- validation, errors, debugging, and testing;
- breaking a larger problem into smaller steps.

By the end, students should be able to read a small program, explain how information moves through it, change its behaviour, find common mistakes, and design a simple program of their own. These skills provide a foundation for continuing with PowerShell or moving to languages such as Python, JavaScript, C#, or others. The syntax will change, but the underlying ways of thinking will be familiar.

## What students build

Students begin with tiny scripts and finish with an interactive **Hero Command Centre**. Along the way they create a hero profile, gadget calculator, patrol decision system, rescue roster, mission toolkit, clue analyser, city map, and mission log.

## Course map

| # | Lesson | Programming focus | Build | Bonus bite |
|---|---|---|---|---|
| 1 | [Welcome to Signal Academy](lessons/01-welcome/README.md) | output, comments, variables | Hero ID card | VS Code basics |
| 2 | [Power-Up Calculations](lessons/02-calculations/README.md) | numbers, input, operators, types | Power rating calculator | Terminal shortcuts |
| 3 | [Mission Decisions](lessons/03-decisions/README.md) | Boolean logic, `if`/`elseif`/`else` | Mission selector | Git snapshots |
| 4 | [Patrol Patterns](lessons/04-loops/README.md) | `foreach`, `for`, `while` | Patrol scanner | Debugging in VS Code |
| 5 | [Team Rosters](lessons/05-collections/README.md) | arrays, hashtables, objects | Rescue roster | Git branches |
| 6 | [Reusable Mission Tools](lessons/06-functions/README.md) | functions, parameters, scope | Mission toolkit | README writing |
| 7 | [Clue Files](lessons/07-files/README.md) | files, CSV, paths, pipelines | Clue analyser | Git diffs |
| 8 | [Safe Operations](lessons/08-errors/README.md) | validation, errors, `try`/`catch` | Resilient dispatcher | VS Code breakpoints |
| 9 | [City Data Network](lessons/09-data/README.md) | JSON, web concepts, sorting | Status dashboard | GitHub collaboration |
| 10 | [Hero Command Centre](lessons/10-command-centre/README.md) | planning, integration, testing | Final interactive app | Publish with GitHub |

## Quick start

1. Install [Visual Studio Code](https://code.visualstudio.com/) and its **PowerShell** extension.
2. Download this repository with **Code > Download ZIP**, then extract it. If Git is installed, cloning also works:

   ```powershell
   git clone <your-course-repository-url>
   cd <repository-folder>
   ```

3. Open the folder in VS Code. Open `lessons/01-welcome/README.md` and follow the lesson.
4. Run scripts in a VS Code PowerShell terminal:

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\01-welcome\examples\hero-id.ps1
   ```

`-ExecutionPolicy Bypass` applies only to that new process; it does not permanently change the computer's policy. Only run scripts from sources you trust.

## Repository guide

- `lessons/` — student lesson notes, examples, challenges, and solutions
- `final-project/` — final project starter and completed reference version
- `teacher-guide.md` — pacing, facilitation, accessibility, and answer guidance
- `setup.md` — detailed Windows and VS Code setup/troubleshooting
- `scripts/Test-Course.ps1` — automated check for non-interactive course scripts
- `CONTRIBUTING.md` — safe contribution workflow

Start at [Lesson 1](lessons/01-welcome/README.md), or read the [teacher guide](teacher-guide.md).

## Requirements

- Windows 10 or 11
- Windows PowerShell 5.1 (included with Windows)
- VS Code recommended; Notepad also works
- Git is optional until the bonus activities
- Internet is not required for the main lessons

## Licensing

The course text is licensed under [CC BY 4.0](LICENSE-CONTENT), and code is licensed under the [MIT License](LICENSE-CODE). “Signal Academy” and all characters in the course are original fictional teaching material.
