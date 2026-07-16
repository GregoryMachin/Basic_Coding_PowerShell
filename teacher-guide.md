# Teacher guide

## Course approach

Signal Academy teaches transferable programming ideas through Windows PowerShell 5.1. The heroic framing is about community help, calm decisions, teamwork, and responsible technology. Every character and organisation is original so teachers can adapt them without relying on licensed franchises.

PowerShell is the course vehicle rather than the final destination. It was chosen because Windows PowerShell is included with standard Windows 10 and 11 installations, requires little setup for the first lesson, and is supported by extensive Microsoft and community documentation. The teaching emphasis should remain on values, control flow, collections, decomposition, debugging, testing, and other concepts that transfer to additional programming languages.

The course assumes no coding experience. Typing examples is encouraged: small typing errors become useful debugging practice. Students should work locally and need GitHub only when the class is ready to publish or collaborate.

## Standard 60-minute rhythm

| Time | Activity |
|---:|---|
| 0–5 min | Story hook and recap |
| 5–15 min | Instructor live-code |
| 15–30 min | Guided build |
| 30–45 min | Independent challenge |
| 45–52 min | Test, pair review, and extension |
| 52–58 min | Bonus bite (VS Code/Git/GitHub) |
| 58–60 min | Exit ticket |

The bonus can be skipped without breaking the programming sequence. Challenges include “Core,” “Power-up,” and “Team-up” options so students can choose an appropriate stretch.

## Teaching safely

- Use invented names and fictional city data. Do not put student personal information in repositories.
- Public GitHub accounts and repositories should follow school policy and guardian consent.
- Do not teach students to weaken machine-wide execution policy. The launch command in this course changes only one child process.
- Lesson 9 uses a local JSON file so the main course works offline and avoids unknown web content.
- Normalize mistakes: read the first red error line, identify the file and line, form one hypothesis, then test it.

## Lesson dependencies

Each lesson starts with a two-minute “recharge” that restates the needed concepts and provides a complete example. A learner can join late by running that lesson's example. The final project deliberately reuses patterns from all lessons.

## Assessment

Use the same four checks each week:

1. **Runs:** the script completes for normal input.
2. **Reads:** names and layout make its purpose understandable.
3. **Responds:** at least one input changes the result.
4. **Explains:** the student can describe one choice they made.

Suggested final rubric (20 points): correct behavior 8, use of programming concepts 5, clarity 3, testing 2, explanation/demo 2. Reward a small reliable program over a large copied one.

## Solutions and tests

Challenge solutions are included for instructor support and self-checking. Encourage students to compare behavior before comparing code—multiple solutions can be correct.

From the repository root, verify all non-interactive reference scripts:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\Test-Course.ps1
```

Interactive scripts are designed for manual testing because they teach input and validation.

## Accessibility and inclusion

- Read code aloud as intent (“put the value 3 in attempts”) rather than punctuation alone.
- Use paired roles: navigator explains; driver types; swap every 8–10 minutes.
- Permit copy/paste for motor or spelling needs, then ask the learner to change one value and predict the result.
- Avoid color as the only signal; scripts include text labels as well as console colors.
- Offer the extension tasks to fast finishers without making speed the measure of success.

## Before each class

Run the course test, open the lesson example, and check that students start in the repository root. For lessons 7–10, confirm the supplied `data` folders are present. No administrator access or cloud service is required.
