#!/bin/sh
# Claude Code notification hook
# Usage: notify.sh <message> [sound_name]
#   $1 = message body (e.g. "DONE" / "WAIT")
#   $2 = sound name (optional, e.g. "Glass"). Empty = silent.
#
# Behavior:
#   - Builds title "[Claude Code] <window-name>:<window-index>" when running
#     inside tmux. Outside tmux, title is "[Claude Code]".
#   - Suppresses notification only when Ghostty is frontmost AND the
#     currently visible tmux window is the same window that this Claude
#     instance is running in. Otherwise notifies.

set -u

msg=${1:-""}
sound=${2:-""}

# Build tab identifier from the pane this Claude was launched in.
tab=""
if [ -n "${TMUX_PANE:-}" ]; then
  tab=$(tmux display-message -t "$TMUX_PANE" -p '#W:#I' 2>/dev/null || true)
fi
title="[Claude Code]${tab:+ $tab}"

# Suppression: only skip when Ghostty is frontmost AND user is currently
# looking at the same tmux window as this Claude instance.
front=$(osascript -e 'tell application "System Events" to set f to name of first application process whose frontmost is true' 2>/dev/null || true)
if [ "$front" = "ghostty" ] && [ -n "${TMUX_PANE:-}" ]; then
  cur=$(tmux display-message -p '#S:#I' 2>/dev/null || true)
  mine=$(tmux display-message -t "$TMUX_PANE" -p '#S:#I' 2>/dev/null || true)
  if [ -n "$cur" ] && [ "$cur" = "$mine" ]; then
    exit 0
  fi
fi

# Fire macOS notification.
if [ -n "$sound" ]; then
  osascript -e "display notification \"$msg\" with title \"$title\" sound name \"$sound\""
else
  osascript -e "display notification \"$msg\" with title \"$title\""
fi
