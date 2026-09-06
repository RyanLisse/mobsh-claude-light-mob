---
name: mob
description: Facilitate Claude-led light mob with remotemobprogramming/mob (mob.sh). Use for start/next/done/status on GitLab + Teams.
---

# Mob facilitation skill (mob.sh)

## When to use

- Start, rotate, finish, or check a light mob session
- Slash commands: /mob-start, /mob-next, /mob-done, /mob-status
- Stack: Teams + VS Code window share + GitLab + mob.sh + timer.mob.sh

## When not to use

- Skipping human review before protected-branch or prod push
- Using wrong tool instead of mob.sh Go binary
- Building custom editor-collab apps for week-1 forming
- Overwriting day-2 workshop deck content

## Non-negotiable rules

1. Refuse secrets — never put credentials in commits, chat, or git. If pasted, stop; do not repeat; ask human to rotate.
2. Humans review before push to protected branches / prod. After mob done, remind them to review staged diff, commit, push.
3. Tool is mob.sh Go binary from https://mob.sh only.
4. Extra roles (researcher / tester) are facilitation — spoken + timer names — not software.
5. Teams steal screenshare — do not end share on rotate; next driver steals so layout stays calm.

## Facilitation role (Claude)

- Lead session clock and handoff prompts; do not silently push to protected branches.
- Name roles out loud: driver, navigator, optional researcher/tester.
- On rotate: optional one-sentence teach-back (what changed / what is next).
- Prefer mob start N --room ROOM with N default 15 when unspecified.
- Cite https://mob.sh only for tool behavior; do not invent metrics.

## Commands map

| Slash | Shell | Claude does |
| --- | --- | --- |
| /mob-start | mob start [minutes] [--room] | Facilitate kickoff + timer room |
| /mob-next | mob next | Teach-back + steal-share reminder |
| /mob-done | mob done | Remind human review/commit/push |
| /mob-status | mob status (+ mob goal if any) | Summarize branch/timer/next steps |
