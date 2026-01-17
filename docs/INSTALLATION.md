# LaTeX Installation Guide

Complete guide for installing LaTeX to use with the CV Resume Repository.

## Quick Platform Navigation

Choose your operating system for detailed instructions:

- **[Linux Installation →](installation/LINUX.md)** - Ubuntu, Debian, Fedora, Arch, openSUSE
- **[macOS Installation →](installation/MAC.md)** - Homebrew, MacTeX, MacPorts
- **[Windows Installation →](installation/WINDOWS.md)** - MiKTeX, TeX Live, Chocolatey
- **[Verify Installation →](installation/VERIFICATION.md)** - Post-install verification checklist
- **[Troubleshooting →](installation/TROUBLESHOOTING.md)** - Common issues and solutions

## What You Need

To build resumes with this repository, you need:

| Component | Purpose | Size |
|-----------|---------|------|
| LaTeX distribution | Core typesetting system | 200MB - 7GB |
| pdflatex command | PDF generation | Included in LaTeX |
| make utility | Build automation | <10MB |
| Disk space | Installation and temp files | 500MB - 7GB |

## Installation Methods

### Automated Installation (Recommended)

Use platform-specific scripts for one-command setup:

```bash
# Linux
cd /path/to/cv-resume-repository
chmod +x scripts/install-latex-linux.sh
./scripts/install-latex-linux.sh

# macOS
cd /path/to/cv-resume-repository
chmod +x scripts/install-latex-mac.sh
./scripts/install-latex-mac.sh
```

```batch
# Windows (Command Prompt)
cd C:\path\to\cv-resume-repository
scripts\install-latex-windows.bat
```

```powershell
# Windows (PowerShell)
cd C:\path\to\cv-resume-repository
Set-ExecutionPolicy Bypass -Scope Process
.\scripts\install-latex-windows.ps1
```

See [scripts/README.md](../scripts/README.md) for details on what the scripts do.

### Manual Installation

Follow detailed platform-specific guides:

- **[Linux Guide](installation/LINUX.md)** - Step-by-step for Ubuntu, Fedora, Arch, openSUSE
- **[macOS Guide](installation/MAC.md)** - Homebrew, MacTeX, or MacPorts installation
- **[Windows Guide](installation/WINDOWS.md)** - MiKTeX, TeX Live, or package manager installation

## Required LaTeX Packages

This project requires these LaTeX packages:

| Package | Purpose | Included In |
|---------|---------|-------------|
| geometry | Page layout and margins | Most distributions |
| hyperref | Clickable links in PDFs | Most distributions |
| enumitem | Custom bullet point formatting | Most distributions |
| titlesec | Section header formatting | Most distributions |
| etoolbox | LaTeX programming utilities | Most distributions |

**Note:** Most LaTeX distributions include these packages by default. See platform guides for package installation instructions if needed.

## Installation Options by Platform

### Linux

**Quick install (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-extra make
```

**Recommendations:**
- Basic installation: 500MB, sufficient for this project
- Full installation: 5GB, includes all packages
- See [Linux Guide](installation/LINUX.md) for Fedora, Arch, openSUSE

### macOS

**Quick install (Homebrew + BasicTeX):**
```bash
brew install basictex
eval "$(/usr/libexec/path_helper)"
sudo tlmgr update --self
sudo tlmgr install enumitem titlesec etoolbox
```

**Recommendations:**
- BasicTeX: 100MB, fast, recommended
- MacTeX: 4GB, complete with GUI tools
- See [macOS Guide](installation/MAC.md) for details

### Windows

**Quick install (Chocolatey + MiKTeX):**
```powershell
choco install miktex make
```

**Recommendations:**
- MiKTeX: Auto-installs packages on-demand, user-friendly
- TeX Live: Complete installation, cross-platform
- See [Windows Guide](installation/WINDOWS.md) for alternatives

## After Installation

1. **Verify your setup**
   - Follow [Verification Guide](installation/VERIFICATION.md)
   - Run verification scripts from `scripts/` directory
   - Ensure all commands work correctly

2. **Return to Quickstart**
   - Continue with [QUICKSTART.md](QUICKSTART.md)
   - Set your name in Makefile
   - Update common files
   - Build your first resume

3. **If issues arise**
   - Check [Troubleshooting Guide](installation/TROUBLESHOOTING.md)
   - Review platform-specific guide for your OS
   - Verify all prerequisites are met

## Disk Space Requirements

| Installation Type | Size | Time | Best For |
|-------------------|------|------|----------|
| Minimal (BasicTeX, Basic TeX Live) | 100-200MB | 1-5 min | This project only |
| Recommended (with extras) | 500MB - 1GB | 2-10 min | This + most LaTeX work |
| Full (all packages) | 4-7GB | 10-60 min | Heavy LaTeX users |

**Recommendation:** Start with recommended installation. You can always add packages later if needed.

## Getting Help

If you encounter issues:

1. **Check [Troubleshooting Guide](installation/TROUBLESHOOTING.md)** for common problems
2. **Review [Verification Guide](installation/VERIFICATION.md)** to diagnose issues
3. **Consult official documentation:**
   - TeX Live: https://tug.org/texlive/doc.html
   - MiKTeX: https://docs.miktex.org/
   - MacTeX: https://tug.org/mactex/
4. **Open an issue** on the repository with:
   - Operating system and version
   - LaTeX distribution (`pdflatex --version`)
   - Full error message
   - Steps to reproduce

## Next Steps

1. Choose your platform above
2. Follow installation guide
3. Verify installation works
4. Return to [QUICKSTART.md](QUICKSTART.md)
5. Build your first resume!

---

**Quick Links:**
- [Linux Installation](installation/LINUX.md)
- [macOS Installation](installation/MAC.md)
- [Windows Installation](installation/WINDOWS.md)
- [Verification](installation/VERIFICATION.md)
- [Troubleshooting](installation/TROUBLESHOOTING.md)
- [Scripts README](../scripts/README.md)
- [Back to Main README](../README.md)
