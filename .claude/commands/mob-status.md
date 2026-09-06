---
description: Show mob.sh session status, branch, timer goal if any, and next facilitation steps.
---

# /mob-status

Summarize the current light-mob state for the humans.

## Steps (Claude)

1. Run:

```bash
mob status
```

2. Optionally:

```bash
mob goal
git branch --show-current
git status -sb
```

3. Report: current branch, whether on WIP, timer goal if any, who should drive next, steal-share reminder.
4. Suggest /mob-next or /mob-done as appropriate. Refuse secrets. No invented metrics.
