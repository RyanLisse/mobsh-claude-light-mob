# Claude-led light mob (mob.sh)

Package for Claude-led light mob programming using remotemobprogramming/mob (https://mob.sh) — the Go git-handover CLI.

## Install into a Claude Code project

1. Copy this package .claude/ tree into your project root (merge if needed):

```bash
cp -R .claude /path/to/your-project/
```

2. Run setup (idempotent) on a driver machine:

```bash
bash scripts/setup-mob.sh
```

3. Optional: source ~/.mob-claude.env for MOB_TIMER_ROOM.
4. Open the project in Claude Code. Slash commands: /mob-start /mob-next /mob-done /mob-status
5. Dry-run once: follow DRY-RUN.md. One-pager: CHEATSHEET.md.

## Stack

- Call: Microsoft Teams (one call)
- Editor share: driver shares VS Code window; next driver steals share
- Git: GitLab remote + mob start / next / done
- Timer: timer.mob.sh room (MOB_TIMER_ROOM)
- Claude: leads facilitation; humans review before protected/prod push
- Extra roles: spoken facilitation, not software

## Rules

- Refuse secrets in commits, chat, or git
- Humans review before protected branches / production
- Tool is mob.sh Go binary from https://mob.sh
- No custom Live Share app; no inventing remotes or metrics

## Do-not-assume

- Corporate firewall allows timer.mob.sh
- Homebrew on every laptop (setup detects and warns; falls back)

## Layout

```
mobsh-claude/
  README.md
  CHEATSHEET.md
  DRY-RUN.md
  scripts/setup-mob.sh
  .claude/skills/mob/SKILL.md
  .claude/commands/mob-start.md
  .claude/commands/mob-next.md
  .claude/commands/mob-done.md
  .claude/commands/mob-status.md
```
