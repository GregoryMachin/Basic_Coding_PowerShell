# Lesson 9 — City Data Network

**Mission:** Turn JSON status data into a useful dashboard.  
**Learn:** JSON, nested properties, sorting/filtering, web-service concepts, and data trust.  
**Recharge:** CSV is tabular; JSON can represent nested objects and lists.

## Flight plan

0–5 network hook; 5–15 JSON structure; 15–30 dashboard; 30–45 challenge; 45–52 verify data; 52–58 GitHub collaboration; 58–60 exit.

## Local-first data

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\lessons\09-data\examples\status-dashboard.ps1
```

```powershell
$city = Get-Content $path -Raw | ConvertFrom-Json
$city.zones | Sort-Object alertLevel -Descending
```

JSON uses `{}` for objects and `[]` for arrays. APIs commonly return JSON over the web. `Invoke-RestMethod` can request it, but network data may be unavailable, changed, wrong, or malicious. This lesson uses a versioned local snapshot so results are safe and repeatable.

## Challenge — Dispatch shortlist

Open `challenge/starter.ps1`.

**Core:** load JSON, select zones with `alertLevel` at least 3, sort descending, and display name, alert level, and lead contact.  
**Power-up:** use `ConvertTo-Json` to save the shortlist into `workspace/shortlist.json`. Use `-Depth 4` for nested data.  
**Team-up:** change one value in a copied data file, predict the new order, and verify.

Before trusting data, ask: Who produced it? When? What fields may be missing? What happens if a value has the wrong type?

## Bonus bite — GitHub collaboration

On GitHub, an **issue** describes work; a **pull request** proposes a change for review. A safe classroom flow is:

1. Create an issue without personal data.
2. Make a focused branch and commit.
3. Push only with teacher approval.
4. Open a pull request that links the issue.
5. Review behavior and clarity, not the person.

No GitHub account is needed for the main lesson.

## Exit ticket

Name one reason a program should not blindly trust data from an API.

**Previous:** [Lesson 8](../08-errors/README.md) · **Next:** [Hero Command Centre](../10-command-centre/README.md)

