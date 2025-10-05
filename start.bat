@echo off
setlocal
title Charity Earth - One Click Start

REM switch to script directory
pushd %~dp0

REM port argument (optional), default 3000; fallback 3010 if in use
set PORT=%1
if "%PORT%"=="" set PORT=3000
set ALT_PORT=3010

echo [INFO] Checking Node.js and npm...
where node >nul 2>&1 || (echo [ERROR] Node.js not found. Please install Node.js. & goto :end)
where npm  >nul 2>&1 || (echo [ERROR] npm not found. Please ensure npm is installed. & goto :end)

echo [INFO] Checking dependencies...
if not exist node_modules (
  echo [INFO] node_modules not found. Running npm install...
  call npm install
  if errorlevel 1 (
    echo [ERROR] npm install failed. Please check your network or npm registry.
    goto :end
  )
)

echo [INFO] Checking port: %PORT%
set PORT_IN_USE=
for /f "tokens=*" %%P in ('netstat -ano ^| findstr /r /c:":%PORT%"') do set PORT_IN_USE=1
if defined PORT_IN_USE (
  echo [WARN] Port %PORT% is in use. Switching to %ALT_PORT%.
  set PORT=%ALT_PORT%
)

echo [INFO] Starting server on port %PORT%...
timeout /t 2 >nul
start "Charity Earth" http://localhost:%PORT%/

set PORT=%PORT%
call npm start

echo.
echo [INFO] Server process exited (stopped or failed to start).
echo [HINT] To run manually:
echo   PowerShell: ^$env:PORT=%PORT%; npm start
echo   CMD:        set PORT=%PORT% ^&^& npm start
pause
goto :end

:end
popd
endlocal