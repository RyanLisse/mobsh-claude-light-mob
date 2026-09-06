# mob.sh cheat sheet (one page)

**Tool:** [mob.sh](https://mob.sh) — remotemobprogramming/mob (Go binary). **Not npm mob-coordinator.**

```
  GETTING-STARTED.md ──▶  non-technical walkthrough
  README.md            ──▶  full story + mermaid
  DRY-RUN.md           ──▶  15-min rotate script
  scripts/setup-mob.sh ──▶  install + timer room
         ▲
         │  you are here (commands + steal-share)
  CHEATSHEET.md
```

---

## Install

- Run `scripts/setup-mob.sh` (idempotent)
- Or brew formula `mob` when Homebrew exists (setup warns if brew missing)
- Verify: `mob version`
- Official docs: https://mob.sh

---

## Session

| Step | Command | Notes |
| --- | --- | --- |
| Start | `mob start [minutes]` | Light mob default: **15**. WIP from base. |
| Start + room | `mob start 15 --room ROOM` | timer.mob.sh room once |
| Next | `mob next` | Push WIP; next driver runs `mob start` |
| Done | `mob done` | Squash WIP to base index; **human** commits/pushes |
| Status | `mob status` | Current session |
| Goal | `mob goal [text]` | timer.mob.sh room goal |

Short: `mob s` / `mob n` / `mob d`

Claude slash: `/mob-start` · `/mob-next` · `/mob-done` · `/mob-status`

---

## Timer (timer.mob.sh)

- Env: `MOB_TIMER_ROOM` (also `~/.mob`). Snippet: `~/.mob-claude.env`
- Open: `https://timer.mob.sh/ROOM` — paste in Teams chat
- Do-not-assume firewall allows timer.mob.sh — verify once
- `mob timer 15 --room ROOM` / `mob timer open`

---

## Teams rotation (steal screenshare)

1. Driver shares **VS Code window** (not full desktop)
2. On rotate: `mob next` — **keep share up**
3. Next driver **steals** screenshare (do not end share)
4. Next driver runs `mob start`
5. Say commands out loud

---

## Co-authored-by via mob done

`mob done` squashes WIP and carries `Co-authored-by` from WIP committers (GitLab shows co-authors when emails match). Human writes final commit message, reviews, pushes.

---

## Non-negotiables

- **No secrets** in chat, commits, or git
- **Humans review** before protected / prod push
- Tool is **mob.sh** Go binary only — **not npm mob-coordinator**
- **No Live Share** — Teams steal-share is the path
- Researcher / tester = facilitation, not software
