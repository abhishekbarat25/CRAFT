@echo off
REM =============================================================================
REM verify-setup.bat - Verify LaTeX installation for CV Resume Repository
REM =============================================================================
REM USAGE:
REM   scripts\verify-setup.bat
REM
REM WHAT IT DOES:
REM   1. Checks if pdflatex is installed and working
REM   2. Checks if make is installed and working
REM   3. Tests repository build
REM   4. Reports results
REM
REM EXIT CODES:
REM   0 - All checks passed
REM   1 - One or more checks failed
REM =============================================================================

setlocal enabledelayedexpansion

set PASSED=0
set FAILED=0

echo ================================================
echo LaTeX Installation Verification
echo ================================================
echo.

REM Check pdflatex
echo Checking pdflatex...
where pdflatex >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [OK] pdflatex found
    pdflatex --version | findstr /C:"pdfTeX"
    set /a PASSED+=1
) else (
    echo [FAIL] pdflatex not found
    echo   ERROR: pdflatex is not installed or not in PATH
    set /a FAILED+=1
)

echo.

REM Check make
echo Checking make...
where make >nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [OK] make found
    make --version | findstr /C:"GNU Make"
    set /a PASSED+=1
) else (
    echo [FAIL] make not found
    echo   ERROR: make is not installed or not in PATH
    echo   TIP: Install Git for Windows or use chocolatey: choco install make
    set /a FAILED+=1
)

echo.
echo ================================================
echo Testing repository build...
echo ================================================
echo.

REM Test build
echo Building test resume (COMPANY=apple)...

make COMPANY=apple >build.log 2>&1
if %ERRORLEVEL% == 0 (
    REM Check if PDF exists
    if exist output\apple\*_apple.pdf (
        echo [OK] Build successful
        for %%F in (output\apple\*_apple.pdf) do (
            echo   PDF: %%F (%%~zF bytes)
        )
        set /a PASSED+=1
    ) else (
        echo [FAIL] PDF not generated
        echo   Check build.log for details
        set /a FAILED+=1
    )
) else (
    echo [FAIL] Build failed
    echo   Check build.log for details
    echo   Try: make COMPANY=apple
    set /a FAILED+=1
)

echo.
echo ================================================
echo Verification Summary
echo ================================================
echo.

set /a TOTAL=!PASSED!+!FAILED!

echo Total checks: !TOTAL!
echo Passed: !PASSED!
echo Failed: !FAILED!
echo.

if !FAILED! == 0 (
    echo [OK] All checks passed!
    echo.
    echo Your LaTeX installation is ready to use.
    echo.
    echo Next steps:
    echo   1. Update your name in Makefile (line 12^)
    echo   2. Update common files (src\common\^)
    echo   3. Create company configuration: add_company.sh company
    echo   4. Build resume: make COMPANY=company
    echo.
    echo Documentation:
    echo   - Quickstart: docs\QUICKSTART.md
    echo   - Usage Guide: docs\USAGE_GUIDE.md
    echo.
    exit /b 0
) else (
    echo [FAIL] Some checks failed
    echo.
    echo Troubleshooting:
    echo   1. Review error messages above
    echo   2. Check docs\installation\VERIFICATION.md
    echo   3. See docs\installation\TROUBLESHOOTING.md
    echo.
    echo Installation guides:
    echo   - docs\installation\WINDOWS.md
    echo.
    exit /b 1
)
