#!/usr/bin/env bash
# setup-mob.sh — Idempotent setup for mob.sh (remotemobprogramming/mob)
# See https://mob.sh and CHEATSHEET.md in the repo root.

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
readonly CHEATSHEET="${REPO_ROOT}/CHEATSHEET.md"
readonly MOB_CLAUDE_ENV="${HOME}/.mob-claude.env"
readonly MOB_CONFIG="${HOME}/.mob"

info() { printf '==> %s\n' "$*"; }
warn() { printf 'WARNING: %s\n' "$*" >&2; }
die() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# Never print secrets from git remotes or env.
sanitize_git_remote() {
  local url="$1"
  # Strip embedded credentials (https://user:token@host/...)
  printf '%s' "${url}" | sed -E 's#(https?://)[^/@]+@#\1***@#g'
}

mob_installed() {
  command -v mob >/dev/null 2>&1
}

install_mob() {
  if mob_installed; then
    info "mob already on PATH — skipping install"
    return 0
  fi

  if command -v brew >/dev/null 2>&1; then
    info "Installing mob via Homebrew (brew install mob)..."
    if brew install mob; then
      return 0
    fi
    warn "Homebrew install failed; falling back to install.mob.sh"
  else
    warn "Homebrew not found — skipping brew install (this is OK)"
    info "Will install mob via https://install.mob.sh"
  fi

  local tmp_install
  tmp_install="$(mktemp "${TMPDIR:-/tmp}/mob-install.XXXXXX")"
  trap 'rm -f "${tmp_install}"' RETURN

  info "Downloading install script to temp file (download-then-run)..."
  if ! curl -fsSL "https://install.mob.sh" -o "${tmp_install}"; then
    die "Failed to download https://install.mob.sh"
  fi

  info "Running install script..."
  if ! sh "${tmp_install}"; then
    die "mob install script failed"
  fi
  export PATH="${HOME}/bin:/usr/local/bin:${PATH}"
}

verify_mob() {
  if ! mob_installed; then
    die "mob is not on PATH after install. Add mob to PATH and re-run this script."
  fi
  info "mob version:"
  mob version
}

check_git_repo() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    warn "Not inside a git work tree (run from your GitLab clone)"
    info "cd into your GitLab clone then re-run. Do not invent remotes."
    return 0
  fi

  info "Git repository: $(git rev-parse --show-toplevel)"
  local branch
  branch="$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)"
  info "Current branch: ${branch}"

  local remotes
  remotes="$(git remote 2>/dev/null || true)"
  if [[ -z "${remotes}" ]]; then
    warn "No git remotes configured."
    cat <<'EOF'

To add a GitLab remote (replace placeholders):

  git remote add origin git@gitlab.com:<group>/<project>.git
  # or HTTPS:
  git remote add origin https://gitlab.com/<group>/<project>.git
  git push -u origin main

mob requires a remote for handover (mob next pushes to origin).
EOF
    return 0
  fi

  info "Configured remotes:"
  while IFS= read -r remote; do
    [[ -z "${remote}" ]] && continue
    local fetch_url push_url
    fetch_url="$(git remote get-url "${remote}" 2>/dev/null || echo "(unknown)")"
    push_url="$(git remote get-url --push "${remote}" 2>/dev/null || echo "${fetch_url}")"
    printf '  %s  fetch: %s\n' "${remote}" "$(sanitize_git_remote "${fetch_url}")"
    if [[ "${fetch_url}" != "${push_url}" ]]; then
      printf '  %s  push:  %s\n' "${remote}" "$(sanitize_git_remote "${push_url}")"
    fi
  done <<< "${remotes}"
}

configure_timer_room() {
  local room="${MOB_TIMER_ROOM:-}"

  info "Timer room (optional): set MOB_TIMER_ROOM to share timer.mob.sh with your team."
  warn "Corporate firewalls may block https://timer.mob.sh — test in a browser if the timer does not load."

  # Document env file for Claude-led sessions (no secrets stored here).
  if [[ ! -f "${MOB_CLAUDE_ENV}" ]]; then
    cat > "${MOB_CLAUDE_ENV}" <<'EOF'
# mob-claude session defaults (sourced by humans before mob sessions)
# Optional: export a stable room name for timer.mob.sh
# export MOB_TIMER_ROOM="your-team-room"
#
# Source before sessions:
#   source ~/.mob-claude.env
EOF
    info "Created ${MOB_CLAUDE_ENV}"
  else
    info "Exists: ${MOB_CLAUDE_ENV}"
  fi

  if [[ -n "${room}" ]]; then
    # Validate room name is simple (no secrets-like content echoed elsewhere).
    if [[ ! "${room}" =~ ^[A-Za-z0-9._-]+$ ]]; then
      warn "MOB_TIMER_ROOM contains unusual characters; using as-is in ~/.mob"
    fi

    if [[ ! -f "${MOB_CONFIG}" ]]; then
      printf 'MOB_TIMER_ROOM="%s"\n' "${room}" > "${MOB_CONFIG}"
      info "Created ${MOB_CONFIG} with MOB_TIMER_ROOM"
    elif ! grep -q '^MOB_TIMER_ROOM=' "${MOB_CONFIG}" 2>/dev/null; then
      printf '\nMOB_TIMER_ROOM="%s"\n' "${room}" >> "${MOB_CONFIG}"
      info "Appended MOB_TIMER_ROOM to ${MOB_CONFIG}"
    else
      info "MOB_TIMER_ROOM already present in ${MOB_CONFIG} (not overwriting)"
    fi
  else
    info "MOB_TIMER_ROOM not set — skip writing room to ~/.mob"
    info "Set before running this script to persist a room:"
    info "  MOB_TIMER_ROOM=my-team-room ${SCRIPT_DIR}/setup-mob.sh"
  fi
}

print_next_steps() {
  info "Cheatsheet: ${CHEATSHEET}"
  info "Dry-run script: ${REPO_ROOT}/DRY-RUN.md"
  info "Claude skill: ${REPO_ROOT}/.claude/skills/mob/SKILL.md"
  cat <<EOF

Next steps:
  1. source ~/.mob-claude.env   # optional timer room
  2. Read ${CHEATSHEET}
  3. Run the dry-run in DRY-RUN.md (15-minute rotate)
  4. Copy .claude/ into your Claude Code project (see README.md)

Tool: mob.sh from https://mob.sh — NOT npm mob-coordinator.
EOF
}

main() {
  info "mob.sh setup (remotemobprogramming/mob)"
  install_mob
  verify_mob
  check_git_repo
  configure_timer_room
  print_next_steps
  info "Setup complete."
}

main "$@"
