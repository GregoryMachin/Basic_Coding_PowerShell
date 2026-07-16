# Lesson 3 — Mission Decisions

**Mission:** Recommend the right response team.  
**Learn:** comparisons, Boolean values, and `if`/`elseif`/`else`.  
**Recharge:** variables can contain numbers or strings; operators create new values.

## Flight plan

0–5 ethical decision hook; 5–15 comparisons; 15–30 guided selector; 30–45 challenge; 45–52 boundary tests; 52–58 Git bonus; 58–60 exit.

## Story hook

A dispatcher must make consistent decisions. A decision tree makes the rules visible so humans can review them. The program recommends; a responsible person remains in charge.

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\03-decisions\examples\mission-selector.ps1
```

## Decision anatomy

```powershell
if ($risk -ge 8) {
    'Send the full response team'
}
elseif ($risk -ge 4) {
    'Send a scout team'
}
else {
    'Monitor the signal'
}
```

Conditions evaluate to `$true` or `$false`. Useful operators are `-eq`, `-ne`, `-gt`, `-ge`, `-lt`, and `-le`. Combine conditions using `-and` or `-or`; reverse one with `-not`.

Order matters: test the most demanding condition first. If `$risk -ge 4` came first, risk 9 would never reach the higher branch.

## Challenge — Weather launch check

Open `challenge/starter.ps1`.

Rules:

- `DO NOT LAUNCH` when lightning is present or wind is above 60.
- `CAUTION` when wind is 31–60 inclusive.
- `CLEAR` otherwise.

**Power-up:** also require visibility of at least 5 km.  
**Team-up:** write boundary tests for wind 30, 31, and 60 before running them.

## Bonus bite — Your first Git snapshot

If Git is installed, run from the repository root:

```powershell
git status
git add lessons/03-decisions/challenge/starter.ps1
git commit -m "Complete weather launch check"
```

A commit is a named snapshot, not a cloud upload. `git status` is safe to run often. If identity is not configured, follow your teacher's class policy; do not invent personal details for a public repository.

## Exit ticket

Why should boundary values such as 30 and 31 be tested?

**Previous:** [Lesson 2](../02-calculations/README.md) · **Next:** [Patrol Patterns](../04-loops/README.md)

