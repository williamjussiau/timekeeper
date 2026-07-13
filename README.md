# Timekeeper

A minimal, local-only time tracker: log hours against projects and see how
time splits between them. No accounts, no billing features, no analytics —
data stays in the browser's `localStorage`.

## Current state

Single-file app: `timekeeper.html`. Open it directly in a browser, no build
step needed. All logic is vanilla JS + inline CSS, no framework, no
dependencies.

Features already working:
- **Projects → tasks hierarchy**: each project holds its own tasks
  (e.g. Meetings, Writing docs). Add/remove both projects and tasks inline.
- **Choose project colours**: click a project's colour dot (or the swatch next
  to the "New project" box) to open a colour picker.
- **Start/Stop per task** with a sweeping dial readout. Only one task runs at
  a time — starting another automatically stops (pauses) the previous one.
  Press **Esc** to stop the running task; a **Resume [last task]** button
  restarts the one you last tracked.
- **Live timer in the browser tab title** (`▶ 0:12:34 · Meetings`), so you can
  see elapsed time without switching to the app.
- **Rename** projects and tasks (click the name), **reorder** projects (▲/▼),
  and **collapse** a project card (▾) to tidy a long list.
- Per-task **Today** total shown next to each task, plus a Today summary panel
  grouped by project → task, with **today + this-week totals** and an optional
  **daily target** (progress bar).
- Manual entry (for time not tracked live), with project + task pickers and a
  note field.
- **Edit past entries** in the log (fix start/stop times, add a note) — not
  just delete.
- **"Forgot to stop" guard**: if a timer was left running for 8h+ or across a
  day, on next open it asks how long to log (or discard) instead of silently
  counting the whole stretch.
- Split-by-project view: today / this week / all time, as horizontal **bars
  or a pie/donut** (tick the "Pie" box to switch).
- **Backup**: export everything as **JSON** (full restore) or **CSV** (for
  spreadsheets); re-import JSON later. A "last backup: N days ago" note turns
  red when it's been a week.
- Everything persisted to `localStorage` (keys `tk-projects`, `tk-tasks`,
  `tk-entries`, `tk-active-timer`, plus `tk-collapsed`, `tk-daily-target`,
  `tk-last-task`, `tk-last-backup`). Old project-only data is migrated
  automatically (orphaned time is moved to a "General" task).

## Setup

Open `timekeeper.html` in any modern browser — that's it. No install, no build,
no internet.

**Launch it in one click every day:** make a browser bookmark, or a desktop
shortcut to the file, and pin it. On Windows-with-WSL, a shortcut targeting the
file via its `\\wsl.localhost\<distro>\...\timekeeper.html` path works; a sample
`timekeeper.url` is included as a template — just edit the path inside it to
where your copy lives.

**Important:** the browser stores your data (`localStorage`) keyed to the file's
location, so always open it from the **same path in the same browser**. Moving
or renaming the file, or opening it from a different path, starts you with an
empty store. If you need to relocate it, export a backup first (see below) and
import it after.

## Backup

Because data lives only in this browser, clearing browser data wipes it. Use
the **Backup** panel at the bottom:
- **Export backup (JSON)** downloads `timekeeper-backup-YYYY-MM-DD.json`.
- **Export CSV** downloads a spreadsheet-friendly copy.
- **Import backup…** replaces all current data with a chosen JSON backup.

Export every so often (or before changing browser/machine).

### Getting backups into `timekeeper/backups/`

A web page can't choose *where* a download is saved (browser security) — it can
only set the filename. So exports land in your browser's normal Downloads
folder. A dedicated `backups/` folder sits next to the app to collect them.
There are two ways to get files there; the tidy script is the recommended one
because it doesn't touch your global download settings.

**Option A — auto-tidy script (recommended).** Leave Firefox saving to
Downloads as usual, then sweep the backups over with the included script. It
moves `timekeeper-backup-*.json` and `timekeeper-*.csv` from Downloads into
`backups/`, never overwrites (name clashes are kept as `name(1).json`), and
removes the Windows "mark of the web" sidecar.

The script is self-locating and figures out your Downloads folder itself, so it
works wherever you keep this project (WSL reads the Windows Downloads folder;
plain Linux/macOS uses `~/Downloads`; or set `DOWNLOADS=/path` to override).

- **Double-click (Windows):** run `move-backups.bat` — it finds its own location
  and runs the script in WSL. Tip: copy it to your Desktop first, since
  double-clicking on a `\\wsl.localhost\...` path may show a harmless
  *"CMD does not support UNC paths"* warning.
- **From a terminal** (run it from the project folder):

  ```bash
  bash move-backups.sh            # move the files
  bash move-backups.sh --dry-run  # preview only, change nothing
  ```

- **Fully automatic (Windows):** Task Scheduler → Create Basic Task → trigger
  *When I log on* (or hourly/daily) → action *Start a program* → program
  `wsl.exe`, arguments `bash "<path-to>/move-backups.sh"`. It tidies files
  *after* they reach Downloads, not the instant they're saved.

**Option B — point your browser at the folder.** In Firefox: *Settings →
General → Files and Applications → Downloads.* Either pick **"Always ask you
where to save files"** (then navigate to the `backups/` folder on export —
Firefox remembers the last folder used), or **"Save files to"** that folder —
but the latter sends **all** downloads there, not just Timekeeper.

## Known gaps / good next steps

- **Charts**: pie/donut done (inline SVG, zero-dependency). Still to add: a
  `month` filter alongside today/week, and optional per-task drill-down.
- Entry editing covers time + note, but not reassigning an entry to a
  different project/task (delete + re-add for that).
- No packaging — this stays a single HTML file by design. Electron/Tauri would
  give a proper installed window/tray app if that's ever wanted.
- `localStorage` is per-browser and doesn't sync across devices; the JSON
  export/import is the manual bridge for now.

## Design intent

Kept deliberately minimal — this exists specifically *instead of* tools like
Clockify because those bundle billing/invoicing features and a cloud account
that the user didn't want. Any new features should keep that spirit: local
data, no accounts, no telemetry.

## License

MIT — see [LICENSE](LICENSE). Do whatever you like with it.
