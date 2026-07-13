#!/usr/bin/env bash
# Move Timekeeper backup files out of the browser's Downloads folder into the
# backups/ folder that sits next to this script. Safe to run repeatedly: it
# never overwrites — a name clash is kept as "name(1).json".
#
# Portable: it locates itself, so it works wherever you put the folder.
#  - On WSL it reads the Windows Downloads folder automatically.
#  - On plain Linux/macOS it uses ~/Downloads.
#  - Override the source anytime:  DOWNLOADS=/some/path bash move-backups.sh
#
# Usage:
#   bash move-backups.sh            # move the files
#   bash move-backups.sh --dry-run  # preview only, change nothing
set -euo pipefail

# Folder this script lives in -> backups/ goes right next to it.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$SCRIPT_DIR/backups"

# Find the Downloads folder: explicit override wins; else the Windows profile
# (when running under WSL); else the local home Downloads.
if [ -z "${DOWNLOADS:-}" ]; then
  if command -v wslpath >/dev/null 2>&1 \
     && up="$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')" \
     && [ -n "$up" ]; then
    DOWNLOADS="$(wslpath "$up")/Downloads"
  else
    DOWNLOADS="$HOME/Downloads"
  fi
fi

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

if [ ! -d "$DOWNLOADS" ]; then
  echo "Downloads folder not found: $DOWNLOADS" >&2
  echo "Set it explicitly, e.g.:  DOWNLOADS=/path/to/Downloads bash move-backups.sh" >&2
  exit 1
fi
mkdir -p "$DEST"

shopt -s nullglob
moved=0
for src in "$DOWNLOADS"/timekeeper-backup-*.json "$DOWNLOADS"/timekeeper-*.csv; do
  base="$(basename "$src")"
  dest="$DEST/$base"
  # never clobber an existing backup of the same name
  if [ -e "$dest" ]; then
    stem="${base%.*}"; ext="${base##*.}"; n=1
    while [ -e "$DEST/${stem}(${n}).${ext}" ]; do n=$((n+1)); done
    dest="$DEST/${stem}(${n}).${ext}"
  fi
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "would move: $base -> $(basename "$dest")"
  else
    mv "$src" "$dest"
    # drop the leftover Windows "mark of the web" sidecar, if any
    rm -f "${src}:Zone.Identifier" 2>/dev/null || true
    echo "moved: $base -> $(basename "$dest")"
  fi
  moved=$((moved+1))
done

if [ "$moved" -eq 0 ]; then
  echo "No Timekeeper backups found in $DOWNLOADS."
elif [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run: $moved file(s) would move to $DEST (nothing changed)."
else
  echo "Done. Moved $moved file(s) to $DEST."
fi
