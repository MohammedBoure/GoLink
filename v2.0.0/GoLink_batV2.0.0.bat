::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBZbRAWPAES0A5EO4f7+086CsUYJW/IDf4bP0qGMENw05Wnte50RwCgUyIVcMDxXUhulZTA9qmEMv2eKVw==
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
::Zh4grVQjdCyDJGyX8VAjFBZbRAWPAES0A5EO4f7+086CsUYJW/IDf4bP0qGMENw05Wnte50RwCgUyIVcMDxXUhulZTlm5z4M5iqAL8L8
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion

:: ------------------------------------------------
:: Setup paths and variables
:: ------------------------------------------------
set "URL_FILE=%~dp0last_url.txt"
set "DEFAULT_URL=https://google.com"
set "TARGET_URL="
set "SAVED_URL="

:: ------------------------------------------------
:: 1. Read saved URL (skip empty lines)
:: ------------------------------------------------
if exist "%URL_FILE%" (
    for /f "usebackq tokens=* delims=" %%i in ("%URL_FILE%") do (
        set "line=%%i"
        set "line=!line: =!"
        if "!line!" neq "" if not defined SAVED_URL set "SAVED_URL=!line!"
    )
)

:: ------------------------------------------------
:: 2. Decision: Open immediately or prompt?
:: ------------------------------------------------
if defined SAVED_URL (
    :: If a URL is found, set it and open immediately
    set "TARGET_URL=!SAVED_URL!"
    goto OPEN_URL_SILENT
)

:: If we are here, no saved URL exists (First Run)

:: ------------------------------------------------
:: 3. Prompt for new URL (First run only)
:: ------------------------------------------------
:GET_NEW_URL
cls
echo.
echo ===================================
echo First Run: No saved URL found.
echo ===================================
echo.
set "NEW_URL="
set /p "NEW_URL=Enter URL (e.g. youtube.com): "

if not defined NEW_URL (
    set "TARGET_URL=%DEFAULT_URL%"
    echo Using default: %DEFAULT_URL%
) else (
    set "NEW_URL=!NEW_URL: =!"
    
    :: Check for http/https prefix
    set "PREFIX_7=!NEW_URL:~0,7!"
    set "PREFIX_8=!NEW_URL:~0,8!"

    if /I "!PREFIX_7!" == "http://" (
        set "TARGET_URL=!NEW_URL!"
    ) else if /I "!PREFIX_8!" == "https://" (
        set "TARGET_URL=!NEW_URL!"
    ) else (
        :: Add http prefix if missing
        set "TARGET_URL=http://!NEW_URL!"
    )
    
    :: Save the URL for next time
    echo !TARGET_URL! > "%URL_FILE%"
    echo Saved: !TARGET_URL!
)

:: ------------------------------------------------
:: 4. Open URL
:: ------------------------------------------------
:OPEN_URL_SILENT
start "" "!TARGET_URL!"
exit