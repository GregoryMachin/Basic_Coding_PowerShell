# Hero Command Centre

This folder contains the Lesson 10 capstone.

- `starter.ps1` — scaffold with a menu and guided TODOs
- `Command-Centre.ps1` — completed reference application
- `CommandCentre.Core.ps1` — reusable data and validation functions
- `data/missions.seed.csv` — original fictional starting data
- `tests/Test-CommandCentre.ps1` — small no-framework test script

Lesson 10 uses tiered completion levels: **Ready**, **Operational**, **Persistent**, **Hardened**, and **Specialist**. The starter supplies persistence scaffolding so a student can deliver a useful Ready-level program in one hour, then extend it without changing projects.

Run the starter or reference app from the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\final-project\starter.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\final-project\Command-Centre.ps1
```

The reference app creates `data/mission-log.csv` the first time it runs. That generated file is ignored by Git, so experiments do not change the seed data.

Run the focused tests:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\final-project\tests\Test-CommandCentre.ps1
```
