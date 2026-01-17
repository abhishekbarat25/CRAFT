@echo off
REM =============================================================================
REM install-latex-windows.bat - Automated LaTeX installation for Windows
REM =============================================================================
REM USAGE:
REM   scripts\install-latex-windows.bat
REM
REM WHAT IT DOES:
REM   1. Checks if Chocolatey is installed (offers to install if not)
REM   2. Installs MiKTeX via Chocolatey
REM   3. Installs make via Chocolatey
REM   4. Verifies installation
REM   5. Tests build
REM
REM REQUIREMENTS:
REM   - Windows 10 or later
REM   - Administrator privileges
REM   - Internet connection
REM =============================================================================

setlocal enabledelayedexpansion

echo ================================================
echo LaTeX Installation - Windows
echo ================================================
echo.

REM Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script requires Administrator privileges.
    echo.
    echo Please right-click and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo [OK] Running with Administrator privileges
echo.

REM Check if already installed
echo Checking existing installation...
echo.

where pdflatex >nul 2>&1
set PDFLATEX_INSTALLED=%ERRORLEVEL%

where make >nul 2>&1
set MAKE_INSTALLED=%ERRORLEVEL%

if %PDFLATEX_INSTALLED% == 0 (
    if %MAKE_INSTALLED% == 0 (
        echo [OK] LaTeX and make are already installed!
        echo.
        pdflatex --version | findstr /C:"pdfTeX"
        make --version | findstr /C:"GNU Make"
        echo.
        set /p SKIP="Do you want to skip installation? (Y/n) "
        if /i "!SKIP!" == "Y" goto verify
        if /i "!SKIP!" == "" goto verify
    )
)

REM Check Chocolatey
echo Checking Chocolatey...
echo.

where choco >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [OK] Chocolatey is installed
    echo.
) else (
    echo [WARNING] Chocolatey is not installed
    echo.
    echo Chocolatey is a package manager for Windows.
    echo This script will use it to install MiKTeX and make.
    echo.
    set /p INSTALL_CHOCO="Install Chocolatey? (Y/n) "
    if /i "!INSTALL_CHOCO!" == "n" (
        echo.
        echo Cannot proceed without Chocolatey.
        echo For manual installation, see docs\installation\WINDOWS.md
        echo.
        pause
        exit /b 1
    )
    call :install_chocolatey
)

REM Install MiKTeX
echo ================================================
echo Installing MiKTeX...
echo ================================================
echo.

echo This will install MiKTeX Basic (~200MB)
echo.
set /p CONTINUE="Continue? (Y/n) "
if /i "!CONTINUE!" == "n" (
    echo Installation cancelled.
    pause
    exit /b 0
)

echo Installing MiKTeX via Chocolatey...
echo.

choco install miktex -y

if %ERRORLEVEL% == 0 (
    echo [OK] MiKTeX installed
) else (
    echo [ERROR] MiKTeX installation failed
    echo Check error messages above
    pause
    exit /b 1
)

echo.

REM Install make
echo ================================================
echo Installing make...
echo ================================================
echo.

echo Installing make via Chocolatey...
echo.

choco install make -y

if %ERRORLEVEL% == 0 (
    echo [OK] make installed
) else (
    echo [ERROR] make installation failed
    echo Check error messages above
    pause
    exit /b 1
)

echo.

REM Refresh environment
echo Refreshing environment variables...
call refreshenv

REM Verify installation
:verify
echo.
echo ================================================
echo Verifying installation...
echo ================================================
echo.

where pdflatex >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [OK] pdflatex installed
    pdflatex --version | findstr /C:"pdfTeX"
) else (
    echo [FAIL] pdflatex not found
    echo Installation may have failed or PATH not updated
    echo Try restarting Command Prompt
    pause
    exit /b 1
)

echo.

where make >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [OK] make installed
    make --version | findstr /C:"GNU Make"
) else (
    echo [FAIL] make not found
    echo Installation may have failed or PATH not updated
    echo Try restarting Command Prompt
    pause
    exit /b 1
)

echo.
echo Running verification script...
echo.

call scripts\verify-setup.bat

if %ERRORLEVEL% == 0 (
    echo.
    echo ================================================
    echo Installation Successful!
    echo ================================================
    echo.
    echo LaTeX is ready to use.
    echo.
    echo IMPORTANT: Restart Command Prompt for PATH changes to take effect.
    echo.
    echo Next steps:
    echo   1. Restart Command Prompt
    echo   2. Update your name in Makefile (line 12^)
    echo   3. Update common files (src\common\^)
    echo   4. Create company configuration: add_company.sh company
    echo   5. Build resume: make COMPANY=company
    echo.
    echo Documentation:
    echo   - Quickstart: docs\QUICKSTART.md
    echo   - Usage Guide: docs\USAGE_GUIDE.md
    echo.
) else (
    echo.
    echo ================================================
    echo Installation completed with warnings
    echo ================================================
    echo.
    echo LaTeX installed but verification had issues.
    echo.
    echo Try restarting Command Prompt and running:
    echo   scripts\verify-setup.bat
    echo.
    echo Troubleshooting:
    echo   - Restart Command Prompt for PATH changes
    echo   - See docs\installation\VERIFICATION.md
    echo   - See docs\installation\TROUBLESHOOTING.md
    echo.
)

pause
exit /b 0

REM Install Chocolatey function
:install_chocolatey
echo.
echo Installing Chocolatey...
echo.

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command ^
"[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

if %ERRORLEVEL% == 0 (
    echo [OK] Chocolatey installed
    echo.
    call refreshenv
) else (
    echo [ERROR] Chocolatey installation failed
    echo Check error messages above
    echo.
    echo For manual installation, see: https://chocolatey.org/install
    pause
    exit /b 1
)

goto :eof
