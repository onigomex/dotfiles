#!/usr/bin/env bash
# Claude Code notification helper.
#
# Usage:
#   notify.sh <message> [sound] [group]
#
# Behavior:
#   - Skip if Ghostty is the frontmost app (the user is already looking at it).
#   - Otherwise, fire an alerter notification detached from the hook process.
#   - On click, bring Ghostty to the foreground via `open -a Ghostty`.

set -u

MSG="${1:-Claude Code}"
SOUND="${2:-}"
GROUP="${3:-claude-default}"

# Suppress when Ghostty is foreground
front="$(/usr/bin/osascript -e 'tell application "System Events" to name of first application process whose frontmost is true' 2>/dev/null || true)"
if [ "$front" = "ghostty" ]; then
  exit 0
fi

export MSG SOUND GROUP

# Fully detach from the hook process so alerter's click-wait does not block,
# and so macOS attribution is not pinned to the hook subprocess.
nohup bash -c '
  args=(--title "Claude Code" --message "$MSG" --group "$GROUP" --timeout 86400)
  if [ -n "$SOUND" ]; then
    args+=(--sound "$SOUND")
  fi
  result=$(/opt/homebrew/bin/alerter "${args[@]}" 2>/dev/null)
  case "$result" in
    @CONTENTCLICKED|@ACTIONCLICKED) /usr/bin/open -a Ghostty ;;
  esac
' >/dev/null 2>&1 &
disown
