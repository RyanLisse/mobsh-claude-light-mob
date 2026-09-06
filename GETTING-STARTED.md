**Video walkthrough (setup/install):**

<video src="docs/video/mobsh-setup-install.webm" controls width="720">
  <a href="docs/video/mobsh-setup-install.webm">WebM</a> · <a href="docs/video/mobsh-setup-install.mp4">MP4</a>
</video>

[WebM (~1.1 MB)](docs/video/mobsh-setup-install.webm) · [MP4 (~0.9 MB)](docs/video/mobsh-setup-install.mp4)

# Getting started (for facilitators)

**Never done this? This page is for you.** You do not need to be a developer to run the call. Follow the steps in order. After each step, check the “You should see” line before moving on.

> Full technical story: [README.md](README.md) · Commands one-pager: [CHEATSHEET.md](CHEATSHEET.md) · Practice script: [DRY-RUN.md](DRY-RUN.md)

---

## What these tools are (one line each)

| Name | Plain English |
| --- | --- |
| **Teams** | The video call where everyone talks and watches the shared screen. |
| **VS Code** | The code editor the driver types in. |
| **Teams window share** | The driver shows *only* the VS Code window (not their whole desktop) so everyone can watch. |
| **Claude Code** | An AI helper in the project that leads the timer, roles, and handoff prompts via slash commands like `/mob-start`. |
| **GitLab** | The shared place on the internet where the team’s code lives (like a shared folder with history). |
| **mob.sh** | A small helper program that hands unfinished work from one driver to the next safely. |
| **timer.mob.sh** | A shared countdown webpage the whole team can watch. |

**Never paste passwords, tokens, or keys** into Teams chat, Claude, or the code.

---

## Two short paths

Pick one:

### Path A — “I only join the call”

1. Join the Teams meeting link you were sent.
   - **You should see:** other people on the call; someone sharing a VS Code window (or about to).
2. Mute when not speaking. Watch the shared screen. Follow the navigator’s direction out loud if you are navigating.
   - **You should see:** the driver’s editor changing as they type; a timer link in chat (if used).
3. When the timer ends, listen for a one-sentence “teach-back,” then the next driver takes over.
   - **You should see:** the shared screen continue (it should *not* go black); a new person typing.
4. You are done for this turn. Stay on the call for the next rotate unless the facilitator says otherwise.

*(Screenshot placeholder: Teams call with VS Code window share visible.)*

---

### Path B — “I am today’s first driver”

Do Path A’s join step first, then:

1. Open the project in **VS Code** (the folder your team uses on GitLab).
   - **You should see:** the project files in the left sidebar.
2. If this machine has never set up mob: ask a teammate who already can, *or* run the setup script from this package:
   ```bash
   bash scripts/setup-mob.sh
   ```
   - **You should see:** a line that prints a mob version (not an error that mob is missing).
3. Turn **Autosave** on in VS Code.
   - **You should see:** edits save without pressing Save every time.
4. In Teams, share **Window** → pick **VS Code** (not “Screen” / full desktop).
   - **You should see:** teammates confirm they can read the editor text.
5. Open **Claude Code** in the project. Paste the timer room link in Teams chat if you have one (`https://timer.mob.sh/YOUR-ROOM`).
   - **You should see:** Claude available; timer page opens *or* you note it is blocked (see Fail-soft below).
6. Ask Claude to run **`/mob-start`** (default 15 minutes). Say roles out loud: driver (you), navigator, optional researcher.
   - **You should see:** work starts on a temporary handoff branch; Claude confirms the session.
7. When the timer ends: one-sentence teach-back → Claude **`/mob-next`** → **keep your share on** → next driver **steals** the share → they run `mob start`.
   - **You should see:** share stays up; next person is typing; Claude can run `/mob-status` to confirm.

*(Screenshot placeholder: VS Code shared in Teams + Claude `/mob-start` confirmation.)*

When the session is finished, Claude runs **`/mob-done`**. A **human** reviews the change, writes the commit message, and pushes. Claude does not push to protected or production branches.

---

## Fail-soft (plain English)

| Problem | What to do |
| --- | --- |
| **Timer webpage blocked** by company network | Use a phone timer or anyone’s spoken countdown. Keep using mob for handing off code. |
| **Cannot steal screenshare** | Old driver stops share; new driver starts sharing their VS Code window. A bit bumpier — still fine. |
| **“brew” / Homebrew missing** on a laptop | Not a failure. `scripts/setup-mob.sh` falls back to another install path. If stuck, another driver hosts. |
| **Someone pastes a secret** | Stop. Do not repeat it in chat. Ask them to rotate/change that secret. Continue without putting it in git. |
| **Live Share unavailable** | Expected. This package uses Teams steal-share, not Live Share. |

---

## After your first practice

Run the short practice in [DRY-RUN.md](DRY-RUN.md) once. Pass looks like: one clean handoff, Claude leading the facilitation, no secrets, and mob working with your real GitLab project.

Then keep [CHEATSHEET.md](CHEATSHEET.md) open during real sessions.
