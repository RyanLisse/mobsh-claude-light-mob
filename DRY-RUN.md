# Dry-run: one 15-min rotate (Claude leading)

Facilitator walkthrough (non-technical): [GETTING-STARTED.md](GETTING-STARTED.md).

**Success criteria:** one clean rotate; Claude leading facilitation; no secrets; mob on GitLab.

Cite: https://mob.sh. Do not invent metrics. No custom Live Share app.

## Prep (once)

1. Copy .claude/ from this package into the GitLab project used for the dry-run.
2. On first driver machine: bash scripts/setup-mob.sh
3. Confirm mob version; git remote is real GitLab (do not invent remotes); timer URL opens or note if blocked.
4. Teams call open. Autosave on in VS Code.

## Script (one 15-min turn + rotate)

| # | Who | Action |
| --- | --- | --- |
| 1 | Human | Join Teams; first driver shares VS Code window |
| 2 | Human | Paste timer room URL in Teams chat |
| 3 | Claude | Name driver / navigator / optional researcher or tester |
| 4 | Claude + driver | /mob-start (15 min + room). Confirm WIP + timer |
| 5 | Mob | Work ~15 min on a safe scratch change (no secrets) |
| 6 | Claude | Timer end: teach-back one sentence |
| 7 | Claude + driver | /mob-next; keep screenshare up |
| 8 | Next driver | Steal screenshare; mob start |
| 9 | Claude | /mob-status — confirm handoff |
| 10 | Optional | /mob-done then human reviews, commits, pushes |

## Pass / fail

| Criterion | Pass looks like |
| --- | --- |
| One clean rotate | mob next then next person mob start gets the WIP change |
| Claude leading | Claude drove facilitation (roles, timer, teach-back, no secret paste) |
| No secrets | Nothing secret in chat, commits, or remote |
| mob on GitLab | Remote is GitLab; WIP branch push/fetch worked |

## Fail soft

- timer.mob.sh blocked → spoken phone timer; still use mob for git
- brew missing → setup falls back; not a failure
- Live Share unavailable → expected; Teams steal-share is the path

## After dry-run

Human decides if week-1 light mob is enough. Do not start a custom editor-collab build from this package.
