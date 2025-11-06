::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBZbRAWPAE+1EbsQ5+n//NakqkwJc9ILOKbW27OLYM4c/AWyOdZ/higP1ItcWCQNLS34Nk8EhCBLtWvl
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
::Zh4grVQjdCyDJGyX8VAjFBZbRAWPAES0A5EO4f7+086CsUYJW/IDX4D307qFbuUL7yU=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal EnableDelayedExpansion

:: Clear input buffer
>nul 2>&1 <nul set /p = || ver >nul

:: AppData storage path
set "APP_FOLDER=%APPDATA%\OpenSite"
set "URL_FILE=%APP_FOLDER%\last_url.txt"
set "DEFAULT_URL=https://google.com"
set "TIMEOUT_SECONDS=2"
set "TARGET_URL="

:: Create folder if missing
if not exist "%APP_FOLDER%" mkdir "%APP_FOLDER%" >nul 2>&1

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
    echo !SAVED_URL! | findstr /i /b "http:// https://" >nul
    if errorlevel 1 (set "TARGET_URL=http://!SAVED_URL!") else (set "TARGET_URL=!SAVED_URL!")

    cls
    echo.
    echo ===================================
    echo Saved URL: !TARGET_URL!
    echo ===================================
    echo.
    echo [Y] Open now
    echo [N] or [E] Enter new URL
    echo.
    echo Auto-open in %TIMEOUT_SECONDS% seconds...

    :: Wait with real timeout
    >nul 2>&1 timeout /t %TIMEOUT_SECONDS% /nobreak >nul

    :: Check for key press (Y is default)
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
    echo !NEW_URL! | findstr /i /b "http:// https://" >nul
    if errorlevel 1 set "NEW_URL=http://!NEW_URL!"
    echo !NEW_URL! > "%URL_FILE%"
    set "TARGET_URL=!NEW_URL!"
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

:: Short delay to ensure browser starts
timeout /t 1 >nul

exit