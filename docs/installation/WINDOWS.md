# LaTeX Installation - Windows

Comprehensive LaTeX installation guide for Windows.

## Quick Install

### Option 1: MiKTeX (Recommended)
Download and run installer from:
https://miktex.org/download

### Option 2: TeX Live
Download and run installer from:
https://tug.org/texlive/windows.html

### Option 3: Chocolatey (Package Manager)
```powershell
choco install miktex make
```

### Option 4: Scoop (Package Manager)
```powershell
scoop install latex make
```

## Automated Installation

### Using Batch Script (Command Prompt):
```batch
cd C:\path\to\cv-resume-repository
scripts\install-latex-windows.bat
```

### Using PowerShell:
```powershell
cd C:\path\to\cv-resume-repository
Set-ExecutionPolicy Bypass -Scope Process
.\scripts\install-latex-windows.ps1
```

## Installation Options

### Option 1: MiKTeX (Recommended for Windows)

**Size:** 200MB-4GB | **Time:** 5-20 minutes | **Best for:** Beginners

**Why MiKTeX?**
- Automatic package installation on-demand
- User-friendly GUI (MiKTeX Console)
- Windows-native
- Smaller initial download

**Installation Steps:**

**1. Download MiKTeX:**
- Visit: https://miktex.org/download
- Click "Download" for Windows
- Choose: Basic MiKTeX Installer (64-bit)
- File: basic-miktex-XX.XX-x64.exe (~200MB)

**2. Run Installer:**
- Double-click downloaded .exe
- Accept license agreement
- Installation scope:
  - "Install for all users" (recommended) - requires admin
  - "Just for me" - no admin required
- Installation directory: Default `C:\Program Files\MiKTeX` or custom
- Settings:
  - ✓ Install missing packages on-the-fly: **Yes** (recommended)
  - Paper size: Letter
- Click "Start" and wait (5-10 minutes)

**3. Update MiKTeX:**
- Open "MiKTeX Console" from Start Menu
- Click "Check for updates"
- Click "Update now"

**4. Verify:**
Open Command Prompt and run:
```batch
pdflatex --version
```

### Option 2: TeX Live

**Size:** ~4GB | **Time:** 20-60 minutes | **Best for:** Advanced users

**Why TeX Live?**
- Complete installation (all packages included)
- Cross-platform consistency (same as Linux/macOS)
- No on-demand downloads

**Installation Steps:**

**1. Download TeX Live:**
- Visit: https://tug.org/texlive/acquire-netinstall.html
- Download: install-tl-windows.exe
- Or direct: https://mirror.ctan.org/systems/texlive/tlnet/install-tl-windows.exe

**2. Run Installer:**
- Right-click install-tl-windows.exe → "Run as administrator"
- Click "Install" (uses defaults)
- Or click "Advanced" for customization:
  - Scheme: full (recommended) or basic
  - Installation directory: Default `C:\texlive\2025`
- Wait 20-60 minutes (downloads and installs ~4GB)

**3. Verify:**
```batch
pdflatex --version
```

### Option 3: Chocolatey Package Manager

**Best for:** Users with Chocolatey installed

**Install Chocolatey first** (if needed):

Open PowerShell as Administrator and run:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Install MiKTeX:**
```powershell
choco install miktex
```

**Install make:**
```powershell
choco install make
```

**Refresh PATH:**
```powershell
refreshenv
```

### Option 4: Scoop Package Manager

**Best for:** Users with Scoop installed

**Install Scoop first** (if needed):

Open PowerShell (normal user) and run:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

**Add bucket and install:**
```powershell
scoop bucket add extras
scoop install latex
scoop install make
```

## Installing make

Windows doesn't include make by default.

### Method 1: Chocolatey
```powershell
choco install make
```

### Method 2: Git for Windows (includes make)

**1. Download Git for Windows:**
- Visit: https://git-scm.com/download/win
- Download installer
- Run installer (default options)

**2. Use Git Bash:**
- Open "Git Bash" from Start Menu
- Git Bash includes make and Unix-like tools
- Use for all LaTeX work

### Method 3: Manual Download

**1. Download:**
- Visit: https://gnuwin32.sourceforge.net/packages/make.htm
- Click "Download" → "Complete package, except sources"

**2. Install:**
- Run installer
- Default location: `C:\Program Files (x86)\GnuWin32`

**3. Add to PATH:**
- Windows key → Search "environment variables"
- Click "Edit the system environment variables"
- Click "Environment Variables" button
- Under "System variables", select "Path" → Click "Edit"
- Click "New"
- Add: `C:\Program Files (x86)\GnuWin32\bin`
- Click "OK" on all dialogs
- Restart Command Prompt

### Method 4: WSL (Windows Subsystem for Linux)

Use Linux installation instead:

**1. Install WSL:**
```powershell
wsl --install
```

**2. Use Linux commands:**
```bash
sudo apt-get install texlive-latex-base texlive-latex-extra make
```

See [LINUX.md](LINUX.md) for details.

## Required Packages

MiKTeX will auto-install these when first building (if "install on-the-fly" enabled):
- geometry
- hyperref
- enumitem
- titlesec
- etoolbox

**Manual installation (if needed):**

**1. Open MiKTeX Console**
**2. Click "Packages" tab**
**3. Search for package name**
**4. Click "+" to install**

Or via command line:
```batch
mpm --install=geometry
mpm --install=hyperref
mpm --install=enumitem
mpm --install=titlesec
mpm --install=etoolbox
```

## Verification

After installation:

**1. Check pdflatex:**
```batch
pdflatex --version
```
Expected: `MiKTeX-pdfTeX X.XX...` or `pdfTeX 3.14159...`

**2. Check make:**
```batch
make --version
```
Expected: `GNU Make X.X`

**3. Test build:**
```batch
cd C:\path\to\cv-resume-repository
make COMPANY=apple
```

Expected: PDF at `output\apple\Your_Name_apple.pdf`

**For detailed verification:** See [VERIFICATION.md](VERIFICATION.md)

## PATH Configuration

If commands not found after installation:

**1. Open System Environment Variables:**
- Windows key → Search "environment variables"
- Click "Edit the system environment variables"
- Click "Environment Variables" button

**2. Add to PATH:**
- Under "System variables" (or "User variables")
- Select "Path" → Click "Edit"
- Click "New"
- Add MiKTeX path:
  - `C:\Program Files\MiKTeX\miktex\bin\x64`
- Add make path (if applicable):
  - `C:\Program Files (x86)\GnuWin32\bin`
  - Or: `C:\Program Files\Git\usr\bin` (if using Git for Windows)
- Click "OK" on all dialogs

**3. Restart Command Prompt** (important)

## Troubleshooting

### Quick Fixes

**"pdflatex is not recognized"**

1. Add MiKTeX to PATH (see above)
2. Restart Command Prompt
3. Reinstall MiKTeX with "Add to PATH" option

**"make is not recognized"**

1. Install make (see "Installing make" section)
2. Use Git Bash instead of Command Prompt
3. Add make to PATH

**"Unable to find package geometry.sty"**

**MiKTeX:**
1. Enable auto-install in MiKTeX Console
2. Or manually install via MiKTeX Console → Packages
3. Or run: `mpm --install=geometry`

**TeX Live:**
- Packages should be pre-installed
- If missing, download full installation

**LaTeX asks to install packages during build**

**MiKTeX only:**
- Click "Install" when prompted (on-demand installation)
- Or pre-configure: MiKTeX Console → Settings → "Always install missing packages on-the-fly"

**Permission errors**

1. Run Command Prompt or PowerShell as Administrator
2. Or install "Just for me" instead of "all users"

**Windows Defender blocking downloads**

1. Add MiKTeX to Windows Defender exclusions:
   - Windows Security → Virus & threat protection
   - Manage settings → Exclusions → Add exclusion
   - Folder: `C:\Program Files\MiKTeX`
2. Temporarily disable real-time protection during installation

**For more issues:** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

## Using Git Bash (Recommended)

Git Bash provides Unix-like environment on Windows:

**1. Install Git for Windows:**
- Download: https://git-scm.com/download/win
- Run installer (default options)

**2. Open "Git Bash" from Start Menu**

**3. Use Linux-style commands:**
```bash
cd /c/path/to/cv-resume-repository
./add_company.sh google
make COMPANY=google
```

**Benefits:**
- Includes make, bash, and Unix tools
- Better compatibility with repository scripts
- More powerful terminal

## Windows Terminal (Modern Alternative)

Windows Terminal provides better experience:

**1. Install from Microsoft Store:**
- Search "Windows Terminal"
- Click "Install"

**2. Features:**
- Multiple tabs
- PowerShell, Command Prompt, WSL in one window
- Better Unicode support
- Customizable

## Disk Space Information

| Installation Type | Size | Time | Packages |
|-------------------|------|------|----------|
| MiKTeX Basic | ~200MB | 5-10 min | On-demand |
| MiKTeX Complete | ~4GB | 15-30 min | Everything |
| TeX Live | ~4GB | 20-60 min | Everything |

**Check available space:**
```batch
dir C:\
```

## Windows Version Compatibility

| Windows Version | MiKTeX | TeX Live | Chocolatey | Notes |
|-----------------|--------|----------|------------|-------|
| Windows 11 | ✓ | ✓ | ✓ | Fully supported |
| Windows 10 | ✓ | ✓ | ✓ | Fully supported |
| Windows 8.1 | ✓ | ✓ | ✓ | Supported |
| Windows 7 | ⚠ | ⚠ | ⚠ | May work, unsupported |

## Uninstalling

### Remove MiKTeX:
1. Open "Add or Remove Programs"
2. Search "MiKTeX"
3. Click "Uninstall"

### Remove TeX Live:
1. Delete installation directory: `C:\texlive`
2. Remove PATH entries

### Remove make:
- If via Chocolatey: `choco uninstall make`
- If via Git for Windows: Uninstall Git for Windows
- If manual: Delete `C:\Program Files (x86)\GnuWin32`

## Official Resources

- **MiKTeX:** https://miktex.org/
- **MiKTeX Documentation:** https://docs.miktex.org/
- **TeX Live:** https://tug.org/texlive/windows.html
- **Chocolatey:** https://chocolatey.org/
- **Scoop:** https://scoop.sh/
- **Make for Windows:** https://gnuwin32.sourceforge.net/packages/make.htm
- **Git for Windows:** https://git-scm.com/download/win

## Next Steps

1. [Verify your installation](VERIFICATION.md)
2. Return to [QUICKSTART.md](../QUICKSTART.md)
3. Set your name in Makefile
4. Build your first resume!

---

**Quick Links:**
- [Back to Installation Guide](../INSTALLATION.md)
- [Verification Guide](VERIFICATION.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Linux Installation](LINUX.md)
- [macOS Installation](MAC.md)
