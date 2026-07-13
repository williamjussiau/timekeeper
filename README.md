# Timekeeper

A tiny, local-only time tracker. Track time against projects and their tasks,
see where your hours go, and keep everything on your own machine — no accounts,
no cloud, no dependencies. It's a single HTML file.

## Features

- Projects → tasks, each with its own colour
- One-click start/stop per task (only one runs at a time), live tab-title timer,
  Esc to stop, resume-last
- Today / this-week totals, optional daily target, and a "forgot to stop" guard
- Split-by-project chart as bars or a pie
- Editable log with notes and manual entries
- JSON / CSV export and JSON import; data stored in the browser's `localStorage`

## Setup

Open `timekeeper.html` in any modern browser — that's it. For one-click launch,
bookmark it or make a desktop shortcut (a sample `timekeeper.url` template is
included).

Your data is stored by the browser and keyed to the file's location, so open it
from the **same path in the same browser** each time. To move it, export a
backup first and import it after.

## Backup

Use the **Backup** panel to export everything as JSON (full restore) or CSV, and
to import a JSON backup. Exports land in your browser's Downloads folder; the
included `move-backups.sh` / `move-backups.bat` can sweep them into `backups/`
(run `bash move-backups.sh`, or double-click the `.bat` on Windows).

## Design intent

Kept deliberately minimal — this exists specifically *instead of* tools like
Clockify because those bundle billing/invoicing features and a cloud account
that the user didn't want. Any new features should keep that spirit: local
data, no accounts, no telemetry.

## License

MIT — see [LICENSE](LICENSE). Do whatever you like with it.
