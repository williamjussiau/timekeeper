# Timekeeper

A local-only time tracker. Track time against projects and their tasks,
see where your hours go, and keep everything on your own machine. No accounts,
no cloud, no dependencies.

## Features

- Projects with tasks, each with its own colour
- Start and stop tasks with one click (only one runs at a time)
- Live timer in the tab title. Press Esc to stop, or resume the last task
- Today, this-week and this-month totals with optional daily target
- A guard against forgetting to stop the timer
- A day timeline (tasks shown as shades of the project colour) and a multi-day
  "Recent days" view to compare days at a glance
- Split-by-project chart (bars or pie), filterable by today/week/month/all
- Light and dark mode
- Editable log for notes and manual time entries
- Export to JSON or CSV, and import from JSON. Data is stored in your browser

## Setup

Open `timekeeper.html` in any modern browser. To launch it quickly,
bookmark it or create a desktop shortcut (a sample `timekeeper.url` template is
included).

Your data is stored by the browser and tied to the file's location,
so open it from the same path in the same browser each time. To move your data,
export a backup first and import it at the new location.

## Backup

Use the Backup panel to export everything as JSON (full restore) or CSV,
and to import a JSON backup. Exports go to your browser's Downloads folder.
The included `move-backups.sh` and `move-backups.bat` scripts can move them
into a `backups/` folder (run `bash move-backups.sh`, or double-click the `.bat`
on Windows).

## Design intent

The design is intentionally minimal. All data stays local on your machine.

## License

MIT — see [LICENSE](LICENSE).
