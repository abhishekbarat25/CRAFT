# =============================================================================
# install-latex-windows.ps1 - Automated LaTeX installation for Windows
# =============================================================================
# USAGE:
#   Set-ExecutionPolicy Bypass -Scope Process
#   .\scripts\install-latex-windows.ps1
#
# WHAT IT DOES:
#   1. Checks if Chocolatey is installed (offers to install if not)
#   2. Installs MiKTeX via Chocolatey
#   3. Installs make via Chocolatey
#   4. Verifies installation
#   5. Tests build
#
# REQUIREMENTS:
#   - Windows 10 or later
#   - Administrator privileges
#   - Internet connection
# =============================================================================

# Require administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[ERROR] This script requires Administrator privileges." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please right-click and select 'Run as Administrator'"
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "LaTeX Installation - Windows" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[OK] Running with Administrator privileges" -ForegroundColor Green
Write-Host ""

# Check if already installed
Write-Host "Checking existing installation..." -ForegroundColor Cyan
Write-Host ""

$pdflatexInstalled = $null -ne (Get-Command pdflatex -ErrorAction SilentlyContinue)
$makeInstalled = $null -ne (Get-Command make -ErrorAction SilentlyContinue)

if ($pdflatexInstalled -and $makeInstalled) {
    Write-Host "[OK] LaTeX and make are already installed!" -ForegroundColor Green
    Write-Host ""
    pdflatex --version | Select-String "pdfTeX"
    make --version | Select-String "GNU Make"
    Write-Host ""
    $skip = Read-Host "Do you want to skip installation? (Y/n)"
    if ($skip -eq "" -or $skip -eq "Y" -or $skip -eq "y") {
        & "$PSScriptRoot\verify-setup.bat"
        exit 0
    }
}

# Check Chocolatey
Write-Host "Checking Chocolatey..." -ForegroundColor Cyan
Write-Host ""

$chocoInstalled = $null -ne (Get-Command choco -ErrorAction SilentlyContinue)

if ($chocoInstalled) {
    Write-Host "[OK] Chocolatey is installed" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "[WARNING] Chocolatey is not installed" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Chocolatey is a package manager for Windows."
    Write-Host "This script will use it to install MiKTeX and make."
    Write-Host ""
    $installChoco = Read-Host "Install Chocolatey? (Y/n)"
    if ($installChoco -eq "n" -or $installChoco -eq "N") {
        Write-Host ""
        Write-Host "Cannot proceed without Chocolatey."
        Write-Host "For manual installation, see docs\installation\WINDOWS.md"
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Install Chocolatey
    Write-Host ""
    Write-Host "Installing Chocolatey..." -ForegroundColor Cyan
    Write-Host ""

    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Chocolatey installed" -ForegroundColor Green
        Write-Host ""
        # Refresh environment
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    } else {
        Write-Host "[ERROR] Chocolatey installation failed" -ForegroundColor Red
        Write-Host "Check error messages above"
        Write-Host ""
        Write-Host "For manual installation, see: https://chocolatey.org/install"
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Install MiKTeX
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Installing MiKTeX..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "This will install MiKTeX Basic (~200MB)"
Write-Host ""
$continue = Read-Host "Continue? (Y/n)"
if ($continue -eq "n" -or $continue -eq "N") {
    Write-Host "Installation cancelled."
    exit 0
}

Write-Host "Installing MiKTeX via Chocolatey..."
Write-Host ""

choco install miktex -y

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] MiKTeX installed" -ForegroundColor Green
} else {
    Write-Host "[ERROR] MiKTeX installation failed" -ForegroundColor Red
    Write-Host "Check error messages above"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# Install make
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Installing make..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Installing make via Chocolatey..."
Write-Host ""

choco install make -y

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] make installed" -ForegroundColor Green
} else {
    Write-Host "[ERROR] make installation failed" -ForegroundColor Red
    Write-Host "Check error messages above"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# Refresh environment
Write-Host "Refreshing environment variables..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Verify installation
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Verifying installation..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$pdflatexInstalled = $null -ne (Get-Command pdflatex -ErrorAction SilentlyContinue)
if ($pdflatexInstalled) {
    Write-Host "[OK] pdflatex installed" -ForegroundColor Green
    pdflatex --version | Select-String "pdfTeX"
} else {
    Write-Host "[FAIL] pdflatex not found" -ForegroundColor Red
    Write-Host "Installation may have failed or PATH not updated"
    Write-Host "Try restarting PowerShell"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

$makeInstalled = $null -ne (Get-Command make -ErrorAction SilentlyContinue)
if ($makeInstalled) {
    Write-Host "[OK] make installed" -ForegroundColor Green
    make --version | Select-String "GNU Make"
} else {
    Write-Host "[FAIL] make not found" -ForegroundColor Red
    Write-Host "Installation may have failed or PATH not updated"
    Write-Host "Try restarting PowerShell"
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Running verification script..."
Write-Host ""

& "$PSScriptRoot\verify-setup.bat"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "Installation Successful!" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "LaTeX is ready to use."
    Write-Host ""
    Write-Host "IMPORTANT: Restart PowerShell for PATH changes to take effect." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "  1. Restart PowerShell"
    Write-Host "  2. Update your name in Makefile (line 12)"
    Write-Host "  3. Update common files (src\common\)"
    Write-Host "  4. Create company configuration: add_company.sh company"
    Write-Host "  5. Build resume: make COMPANY=company"
    Write-Host ""
    Write-Host "Documentation:"
    Write-Host "  - Quickstart: docs\QUICKSTART.md"
    Write-Host "  - Usage Guide: docs\USAGE_GUIDE.md"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Yellow
    Write-Host "Installation completed with warnings" -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "LaTeX installed but verification had issues."
    Write-Host ""
    Write-Host "Try restarting PowerShell and running:"
    Write-Host "  .\scripts\verify-setup.bat"
    Write-Host ""
    Write-Host "Troubleshooting:"
    Write-Host "  - Restart PowerShell for PATH changes"
    Write-Host "  - See docs\installation\VERIFICATION.md"
    Write-Host "  - See docs\installation\TROUBLESHOOTING.md"
    Write-Host ""
}

Read-Host "Press Enter to exit"
