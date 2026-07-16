# Lesson 10 — Hero Command Centre

**Mission:** Plan, build, test, and present an interactive final program.  
**Learn:** decomposition, integration, manual tests, iteration, and explanation.  
**Recharge:** you now have output, values, input, decisions, loops, collections, functions, files, validation, and structured data.

## Flight plan

| Minutes | Activity |
|---:|---|
| 0–5 | Pick a user and mission |
| 5–10 | Sketch menu/input/output |
| 10–20 | Read and run the starter |
| 20–42 | Build one core feature, then a second |
| 42–50 | Test normal, boundary, and invalid paths |
| 50–55 | Pair review and improve one name/message |
| 55–58 | Publish bonus |
| 58–60 | Demo and reflection |

## Design before code

Complete these sentences:

- My user is ...
- They need to ...
- My smallest useful version can ...
- It receives ... and produces ...
- One thing that could go wrong is ...

Then open `../../final-project/starter.ps1`. It provides a safe loop and menu with TODOs. A completed reference is at `../../final-project/Command-Centre.ps1`; do not read it until your design is sketched.

Run the starter:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\final-project\starter.ps1
```

## Core success criteria

Your program should:

1. show a menu until the user chooses quit;
2. store at least three structured records;
3. use at least two functions;
4. use a decision and a loop;
5. validate at least one input;
6. save or load data from a file;
7. use original fictional content and no personal information.

## Extensions

- Add a roster-search screen.
- Calculate a mission readiness score.
- Save an export as JSON as well as CSV.
- Create a new feature proposed by a classmate, documenting its expected behavior first.

## Manual test checklist

| Test | Input | Expected |
|---|---|---|
| View | `1` | all missions display |
| Add normal | `2`, valid answers | new record appears |
| Add invalid | non-number risk | clear message, app continues |
| Summary | `3` | counts match records |
| Quit | `Q` | friendly closing message |

Record actual results. A failed test is information, not a failed student.

## Bonus bite — Publish responsibly

Review `git diff`, run `scripts/Test-Course.ps1`, and check for secrets/private data. Then, if class policy allows:

```powershell
git add final-project
git commit -m "Build hero command centre"
git push -u origin your-branch-name
```

On GitHub, open a pull request and explain what works, how to run it, and what you tested. Use screenshots only if they contain no private details.

## Final reflection

Explain one design choice, one bug you solved, and one feature you would build next. You have not merely learned commands—you have practised breaking a problem into testable instructions.

**Previous:** [Lesson 9](../09-data/README.md) · **Course home:** [README](../../README.md)

