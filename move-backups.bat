@echo off
REM Double-click from Windows to move Timekeeper backups from Downloads into
REM backups\. Portable: it finds its own location and runs the sibling WSL
REM script, so it works wherever this folder lives.
for /f "usebackq delims=" %%p in (`wsl.exe wslpath "%~dp0move-backups.sh"`) do set "SH=%%p"
wsl.exe bash "%SH%"
echo.
pause
