@echo off
:: BatchGotAdmin code from https://stackoverflow.com/a/8383548
@echo off
:: Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:: End of BatchGotAdmin

set "source=%CD%\rarreg.key"
set "destination=C:\Program Files\WinRAR"

if not exist "%source%" (
    echo File "rarreg.key" not found in the current directory.
    pause
    exit /b
)

if not exist "%destination%" (
    echo Destination directory does not exist.
    pause
    exit /b
)

copy /Y "%source%" "%destination%"

if errorlevel 1 (
    echo Failed to copy the file.
) else (
    echo File "rarreg.key" copied successfully to "%destination%".
)

pause