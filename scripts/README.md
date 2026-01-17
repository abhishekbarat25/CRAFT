# Installation Scripts

Automated installation and verification scripts for LaTeX and dependencies.

## Available Scripts

### Installation Scripts

| Script | Platform | Description |
|--------|----------|-------------|
| `install-latex-linux.sh` | Linux | Auto-installer for Ubuntu, Fedora, Arch, openSUSE |
| `install-latex-mac.sh` | macOS | Auto-installer using Homebrew + BasicTeX |
| `install-latex-windows.bat` | Windows | Auto-installer using Chocolatey + MiKTeX (batch) |
| `install-latex-windows.ps1` | Windows | Auto-installer using Chocolatey + MiKTeX (PowerShell) |

### Verification Scripts

| Script | Platform | Description |
|--------|----------|-------------|
| `verify-setup.sh` | Linux/macOS | Comprehensive setup verification (bash) |
| `verify-setup.bat` | Windows | Comprehensive setup verification (batch) |
| `test-build.sh` | Linux/macOS | Quick build test with sample resume |

## Usage

### Linux

```bash
cd /path/to/cv-resume-repository

# Installation
chmod +x scripts/install-latex-linux.sh
./scripts/install-latex-linux.sh

# Verification
chmod +x scripts/verify-setup.sh
./scripts/verify-setup.sh

# Test build
chmod +x scripts/test-build.sh
./scripts/test-build.sh
```

### macOS

```bash
cd /path/to/cv-resume-repository

# Installation
chmod +x scripts/install-latex-mac.sh
./scripts/install-latex-mac.sh

# Verification
chmod +x scripts/verify-setup.sh
./scripts/verify-setup.sh

# Test build
chmod +x scripts/test-build.sh
./scripts/test-build.sh
```

### Windows (Command Prompt)

```batch
cd C:\path\to\cv-resume-repository

REM Installation
scripts\install-latex-windows.bat

REM Verification
scripts\verify-setup.bat
```

### Windows (PowerShell)

```powershell
cd C:\path\to\cv-resume-repository

# Installation
Set-ExecutionPolicy Bypass -Scope Process
.\scripts\install-latex-windows.ps1

# Verification
.\scripts\verify-setup.bat
```

## What the Scripts Do

### Installation Scripts

The installation scripts perform these steps:

1. **Detect environment**
   - Identify operating system and version
   - Check architecture (x86_64, ARM, etc.)
   - Determine available package managers

2. **Check existing installation**
   - Verify if LaTeX already installed
   - Check version and distribution
   - Offer to skip if already present

3. **Install LaTeX distribution**
   - Linux: TeX Live via distribution package manager
   - macOS: BasicTeX via Homebrew
   - Windows: MiKTeX via Chocolatey

4. **Install make utility**
   - Linux: via package manager
   - macOS: via Xcode Command Line Tools
   - Windows: via Chocolatey or Git for Windows

5. **Install required packages**
   - geometry, hyperref, enumitem, titlesec, etoolbox
   - Platform-specific installation methods

6. **Configure environment**
   - Update PATH if needed
   - Configure shell startup files
   - Set optimal settings

7. **Verify installation**
   - Run verification checks
   - Test pdflatex and make commands
   - Compile test document

8. **Report results**
   - Show installation summary
   - Display next steps
   - Provide troubleshooting links if needed

### Verification Scripts

The verification scripts check:

1. **Command availability**
   - pdflatex command exists and works
   - make command exists and works
   - Display versions

2. **LaTeX packages**
   - geometry, hyperref, enumitem, titlesec, etoolbox
   - Compile minimal test document
   - Report missing packages

3. **Repository build**
   - Build sample resume (COMPANY=apple)
   - Check PDF generation
   - Verify output location

4. **Results summary**
   - Display ✓ for passed checks
   - Display ✗ for failed checks
   - Provide troubleshooting guidance

## Script Features

### Non-Destructive
- Won't reinstall if already present
- Asks for confirmation before changes
- Preserves existing configurations

### Interactive
- Prompts for user input when needed
- Confirms actions before execution
- Allows cancellation at any step

### Verbose
- Shows what it's doing
- Displays commands being run
- Provides progress updates

### Error Handling
- Stops on errors
- Provides clear error messages
- Offers troubleshooting tips

### Color Output
- Green for success (✓)
- Red for errors (✗)
- Yellow for warnings (⚠)
- Blue for information

## Manual Installation

If scripts fail or you prefer manual installation, see platform-specific guides:

- **[Linux Installation](../docs/installation/LINUX.md)** - Ubuntu, Debian, Fedora, Arch, openSUSE
- **[macOS Installation](../docs/installation/MAC.md)** - Homebrew, MacTeX, MacPorts
- **[Windows Installation](../docs/installation/WINDOWS.md)** - MiKTeX, TeX Live, Chocolatey

## Troubleshooting

If scripts encounter errors:

1. **Read error messages** - Scripts provide specific guidance
2. **Check [Troubleshooting Guide](../docs/installation/TROUBLESHOOTING.md)**
3. **Review [Verification Guide](../docs/installation/VERIFICATION.md)**
4. **Consult platform-specific guide** for manual installation

### Common Issues

**Script won't run (Linux/macOS):**
```bash
# Make executable
chmod +x scripts/install-latex-linux.sh
chmod +x scripts/install-latex-mac.sh
chmod +x scripts/verify-setup.sh
chmod +x scripts/test-build.sh

# Run
./scripts/install-latex-linux.sh
```

**Permission denied:**
- Scripts may require sudo/admin privileges for installation
- Verification scripts don't require elevated privileges

**PowerShell script blocked (Windows):**
```powershell
Set-ExecutionPolicy Bypass -Scope Process
.\scripts\install-latex-windows.ps1
```

**Chocolatey not installed (Windows):**
- Batch script will offer to install Chocolatey
- Or install manually: https://chocolatey.org/install

## Requirements

### Installation Scripts

- **Linux:**
  - sudo privileges
  - Internet connection
  - 500MB-5GB disk space

- **macOS:**
  - Admin privileges
  - Internet connection
  - Homebrew (script will install if missing)
  - 100MB-4GB disk space

- **Windows:**
  - Administrator privileges
  - Internet connection
  - PowerShell or Command Prompt
  - 200MB-4GB disk space

### Verification Scripts

- No special privileges required
- Existing LaTeX installation
- Repository cloned locally

## Script Output

### Successful Installation

```
================================================
LaTeX Installation Complete!
================================================

Installed:
  ✓ pdflatex (TeX Live 2025)
  ✓ make (GNU Make 4.3)
  ✓ Required packages: geometry, hyperref, enumitem, titlesec, etoolbox

Verification:
  ✓ Test build successful
  ✓ PDF generated: test.pdf

Next Steps:
  1. Close and reopen your terminal
  2. Navigate to cv-resume-repository
  3. Run: make COMPANY=apple
  4. Check output/apple/ for your resume PDF

Documentation:
  - Quickstart: docs/QUICKSTART.md
  - Verification: docs/installation/VERIFICATION.md
  - Troubleshooting: docs/installation/TROUBLESHOOTING.md

================================================
```

### Failed Installation

```
================================================
LaTeX Installation Failed
================================================

Error: Unable to install texlive-latex-base

Troubleshooting:
  1. Check internet connection
  2. Update package lists: sudo apt-get update
  3. Try manual installation: docs/installation/LINUX.md

For help:
  - Troubleshooting: docs/installation/TROUBLESHOOTING.md
  - Open issue with error details

================================================
```

## Testing Scripts

Before using in production:

1. **Review script contents** - Check commands before execution
2. **Test in VM** - Use virtual machine for safety
3. **Check prerequisites** - Ensure requirements met
4. **Have backup plan** - Know manual installation steps

## Contributing

If you improve these scripts:

1. Test on multiple platforms/versions
2. Maintain error handling
3. Keep output clear and helpful
4. Document changes
5. See [CONTRIBUTING.md](../CONTRIBUTING.md)

## Security

- Scripts use official package repositories
- No downloads from untrusted sources
- All URLs use HTTPS where available
- Review scripts before running with elevated privileges

## License

These scripts are part of the cv-resume-repository and follow the same license.

---

**Quick Links:**
- [Back to Installation Guide](../docs/INSTALLATION.md)
- [Linux Installation](../docs/installation/LINUX.md)
- [macOS Installation](../docs/installation/MAC.md)
- [Windows Installation](../docs/installation/WINDOWS.md)
- [Verification Guide](../docs/installation/VERIFICATION.md)
- [Troubleshooting](../docs/installation/TROUBLESHOOTING.md)
- [Main README](../README.md)
