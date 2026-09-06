---
description: Start a mob.sh light-mob session (WIP branch + optional timer). Default 15 minutes. Claude leads facilitation.
---

# /mob-start

Lead a **Claude-facilitated** light mob kickoff using **mob.sh** (https://mob.sh).

## Arguments

- Optional minutes (default **15**)
- Optional timer room (from MOB_TIMER_ROOM or --room; default room name mob)

## Steps (Claude)

1. Refuse any secrets in chat; remind humans not to paste credentials.
2. Confirm Teams call is up; driver will share VS Code window (not full desktop).
3. Name roles out loud: driver, navigator, optional researcher/tester (facilitation only).
4. Resolve minutes: use argument or default 15.
5. Resolve room: MOB_TIMER_ROOM env, else mob.
6. Run in project repo:

```bash
mob start 15 --room "$MOB_TIMER_ROOM"
```

   (substitute minutes/room). Paste https://timer.mob.sh/ROOM in Teams. Warn if timer may be blocked.
7. Confirm WIP branch exists; say mob start out loud with the driver.
8. Remind: autosave on; next rotate uses steal-screenshare (do not end share).

Do not invent remotes. Do not push to protected/prod. Humans still own git credentials.
