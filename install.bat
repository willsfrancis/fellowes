@echo off

if not exist package.json (
  echo package.json not found in the project root.
  exit /b 1
)

where /q yarn
if not errorlevel 1 (
  yarn help install >nul 2>&1
  yarn install
) else (
  where /q npm
  if errorlevel 1 (
    echo Neither yarn nor npm is installed.
    exit /b 1
  ) else (
    npm install
  )
)
