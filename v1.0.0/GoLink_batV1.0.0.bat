::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCeDJF6N4EolOCdzQyiLMmCGIbow4ebw0OOErQMUV+1f
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCeDJF6N4EolOCdzQyiLMmCGIbow4ebwoe+fpy0=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion

:: ------------------------------------------------
:: PORTABLE VERSION (No findstr, No parens)
:: ------------------------------------------------
set "URL_FILE=%~dp0last_url.txt"
set "DEFAULT_URL=https://google.com"
set "TIMEOUT_SECONDS=2"
set "TARGET_URL="

:: ------------------------------------------------
:: 1. Read saved URL (skip empty lines)
:: ------------------------------------------------
set "SAVED_URL="
if exist "%URL_FILE%" (
    for /f "usebackq tokens=* delims=" %%i in ("%URL_FILE%") do (
        set "line=%%i"
        set "line=!line: =!"
        if "!line!" neq "" if not defined SAVED_URL set "SAVED_URL=!line!"
    )
)

:: ------------------------------------------------
:: 2. Show saved URL + auto-open timer
:: ------------------------------------------------
if defined SAVED_URL (
    set "TARGET_URL=!SAVED_URL!"

    cls
    echo.
    echo ===================================
    echo Saved URL: !TARGET_URL!
    echo (File: %~dp0last_url.txt)
    echo ===================================
    echo.
    echo [Y] Open now
    echo [N] or [E] Enter new URL
    echo.
    echo Auto-open in %TIMEOUT_SECONDS% seconds...

    >nul 2>&1 timeout /t %TIMEOUT_SECONDS% /nobreak >nul
    choice /c YNE /n /t 1 /d Y >nul 2>&1
    if errorlevel 3 goto GET_NEW_URL
    if errorlevel 2 goto GET_NEW_URL
    goto OPEN_URL
) else (
    goto GET_NEW_URL
)

:: ------------------------------------------------
:: 3. Prompt for new URL
:: ------------------------------------------------
:GET_NEW_URL
cls
echo.
echo ===================================
echo No saved URL or you chose to change
echo ===================================
echo.
set "NEW_URL="
set /p "NEW_URL=Enter URL (e.g. youtube.com): "

if not defined NEW_URL (
    set "TARGET_URL=%DEFAULT_URL%"
    echo Using default: %DEFAULT_URL%
) else (
    set "NEW_URL=!NEW_URL: =!"
    
    :: ROBUST FIX: Replaced FINDSTR with internal check
    set "PREFIX_7=!NEW_URL:~0,7!"
    set "PREFIX_8=!NEW_URL:~0,8!"

    if /I "!PREFIX_7!" == "http://" (
        set "TARGET_URL=!NEW_URL!"
    ) else if /I "!PREFIX_8!" == "https://" (
        set "TARGET_URL=!NEW_URL!"
    ) else (
        :: No prefix found, add it
        set "TARGET_URL=http://!NEW_URL!"
    )
    
    :: FINAL FIX: Changed (echo ... ) to simple echo
    :: This is less safe for special chars, but your system requires it.
    echo !TARGET_URL! > "%URL_FILE%"
    
    echo Saved: !TARGET_URL!
)
echo.
echo Press any key to open...
pause >nul
goto OPEN_URL

:: ------------------------------------------------
:: 4. Open URL in default browser
:: ------------------------------------------------
:OPEN_URL
cls
echo.
echo Opening in browser...
echo URL: %TARGET_URL%
echo.

start "" "%TARGET_URL%"
timeout /t 1 >nul
exit