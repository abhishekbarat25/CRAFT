# Installation Troubleshooting

Common problems and solutions for LaTeX installation issues.

## Quick Diagnosis

### 1. Command Not Found Errors
- [pdflatex: command not found](#pdflatex-command-not-found)
- [make: command not found](#make-command-not-found)
- [tlmgr: command not found](#tlmgr-command-not-found)

### 2. Package Errors
- [File '*.sty' not found](#missing-latex-packages)
- [MiKTeX package installation fails](#miktex-package-installation-issues)

### 3. Build Errors
- [LaTeX compilation errors](#latex-compilation-errors)
- [PDF not generated](#pdf-not-generated)
- [Permission denied errors](#permission-errors)

### 4. Platform-Specific
- [Linux Issues](#linux-specific-issues)
- [macOS Issues](#macos-specific-issues)
- [Windows Issues](#windows-specific-issues)

---

## Command Not Found Errors

### pdflatex: command not found

**Linux:**

**1. Check if installed:**
```bash
dpkg -l | grep texlive  # Ubuntu/Debian
rpm -qa | grep texlive  # Fedora/RHEL
pacman -Q | grep texlive  # Arch
```

**2. If not installed:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-extra

# Fedora/RHEL
sudo dnf install texlive-scheme-basic texlive-collection-latexextra

# Arch Linux
sudo pacman -S texlive-core texlive-latexextra
```

**3. If installed but not found, check PATH:**
```bash
find /usr -name pdflatex 2>/dev/null
# Add directory to PATH if found
export PATH="/usr/bin:$PATH"  # Adjust path as needed
```

**macOS:**

**1. Update PATH:**
```bash
eval "$(/usr/libexec/path_helper)"
```

**2. Make permanent:**
```bash
# For zsh (default on macOS Catalina+)
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc
source ~/.zshrc

# For bash
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.bash_profile
source ~/.bash_profile
```

**3. If still not found, reinstall:**
```bash
brew reinstall basictex
```

**4. Check installation:**
```bash
ls -la /Library/TeX/texbin/
```

**Windows:**

**1. Check installation:**
- Open "Add or Remove Programs"
- Search for "MiKTeX" or "TeX Live"
- If not found, install from [WINDOWS.md](WINDOWS.md)

**2. Add to PATH:**
- Windows key → "environment variables"
- Edit PATH → Add: `C:\Program Files\MiKTeX\miktex\bin\x64`
- Restart Command Prompt

**3. Or use Git Bash:**
- Install Git for Windows (includes Unix tools)
- Use Git Bash terminal instead of Command Prompt

### make: command not found

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install make

# Fedora/RHEL
sudo dnf install make

# Arch Linux
sudo pacman -S make
```

**macOS:**
```bash
xcode-select --install
```

**Windows:**

**Option 1 - Git Bash (recommended):**
1. Download Git for Windows: https://git-scm.com/download/win
2. Install with default options
3. Use "Git Bash" terminal

**Option 2 - Chocolatey:**
```powershell
choco install make
```

**Option 3 - Manual:**
1. Download: https://gnuwin32.sourceforge.net/packages/make.htm
2. Install to: `C:\Program Files (x86)\GnuWin32`
3. Add to PATH: `C:\Program Files (x86)\GnuWin32\bin`

### tlmgr: command not found

**macOS:**

**1. Update PATH:**
```bash
eval "$(/usr/libexec/path_helper)"
```

**2. Check if tlmgr exists:**
```bash
ls -la /Library/TeX/texbin/tlmgr
```

**3. If missing, reinstall BasicTeX:**
```bash
brew reinstall basictex
```

**Linux (manual TeX Live installation):**

Add to PATH:
```bash
# Adjust path to match your installation
echo 'export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH' >> ~/.bashrc
source ~/.bashrc
```

**Windows (TeX Live):**

Add to PATH:
- `C:\texlive\2025\bin\win32` (or similar)

---

## Package Errors

### Missing LaTeX Packages

**Error:** `! LaTeX Error: File 'packagename.sty' not found.`

**Linux (Ubuntu/Debian):**

**Common packages:**
```bash
# Install extended LaTeX packages
sudo apt-get install texlive-latex-extra

# For all packages (large download ~5GB)
sudo apt-get install texlive-full
```

**Specific packages:**
```bash
# Search for package
apt-cache search texlive packagename

# Install found package
sudo apt-get install texlive-packagename
```

**Linux (Fedora/RHEL):**
```bash
sudo dnf install texlive-collection-latexextra
```

**Linux (Arch):**
```bash
sudo pacman -S texlive-latexextra
```

**macOS:**
```bash
# Update tlmgr
sudo tlmgr update --self

# Install specific package
sudo tlmgr install packagename

# Install all required packages for this project
sudo tlmgr install enumitem titlesec etoolbox
```

**Windows (MiKTeX):**

**Option 1 - Automatic (recommended):**
1. Open MiKTeX Console
2. Settings → "Always install missing packages on-the-fly"
3. Rebuild your resume (will auto-install packages)

**Option 2 - Manual:**
1. Open MiKTeX Console
2. Packages tab
3. Search for package name
4. Click "+" to install

**Option 3 - Command line:**
```batch
mpm --install=packagename
```

**Any system with tlmgr:**
```bash
# Search for package
tlmgr search --global packagename

# Install package
sudo tlmgr install packagename

# Update all packages
sudo tlmgr update --all
```

### MiKTeX Package Installation Issues

**Problem:** MiKTeX fails to download/install packages

**Solutions:**

**1. Change repository:**
- Open MiKTeX Console
- Settings → "Package repository"
- Click "Change" → Select different mirror
- Try closer geographical location
- Try installation again

**2. Update MiKTeX:**
- Open MiKTeX Console
- Click "Check for updates"
- Install all available updates
- Restart computer
- Try package installation again

**3. Clear package cache:**
```batch
mpm --clear-cache
```

**4. Firewall/proxy issues:**
- Check if firewall is blocking MiKTeX
- Configure proxy in MiKTeX Console settings if needed
- Temporarily disable firewall to test

**5. Manual package installation:**
- Download package .tar.lzma from CTAN: https://www.ctan.org/
- Install via MiKTeX Console → Packages → Install from file

---

## Build Errors

### LaTeX Compilation Errors

**Error:** `! LaTeX Error: ...` or `! Undefined control sequence.`

**Common causes:**

**1. Unmatched braces:**
```latex
% Wrong:
\textbf{Bold text

% Correct:
\textbf{Bold text}
```

**2. Unescaped special characters:**
```latex
% Wrong:
Experience with C++ & Python, making $100,000

% Correct:
Experience with C++ \& Python, making \$100,000
```

**Escape these characters:** `\$`, `\%`, `\&`, `\_`, `\{`, `\}`, `\#`

**3. Missing packages:**
See [Missing LaTeX Packages](#missing-latex-packages)

**4. Syntax errors:**
- Check error line number in output
- Review .tex file at that line
- Look for typos in LaTeX commands

**Debugging steps:**

**1. Read error message carefully:**
```
! LaTeX Error: File `enumitem.sty' not found.

Type X to quit or <RETURN> to proceed,
or enter new name. (Default extension: sty)

Enter file name:
```
Error indicates missing package `enumitem`

**2. Check log file:**
```bash
cat output/apple/internals/Your_Name_apple.log | grep Error  # Linux/Mac
type output\apple\internals\Your_Name_apple.log | findstr Error  # Windows
```

**3. Clean and rebuild:**
```bash
make clean
make COMPANY=apple
```

**4. Test with minimal file:**
Create simple test to isolate the issue:
```latex
\documentclass{article}
\begin{document}
Test
\end{document}
```

### PDF Not Generated

**Problem:** Build completes but no PDF created

**Check:**

**1. Verify build actually succeeded:**
```bash
echo $?  # Linux/Mac - Should be 0 (success)
echo %ERRORLEVEL%  # Windows - Should be 0
```

**2. Look in internals folder:**
```bash
ls output/apple/internals/  # Linux/Mac
dir output\apple\internals\  # Windows
```

If PDF is there but not in parent folder:
- Check Makefile copy command (around line 39)
- Check file permissions

**3. Check for errors in log:**
```bash
grep -i error output/apple/internals/Your_Name_apple.log  # Linux/Mac
findstr /i error output\apple\internals\Your_Name_apple.log  # Windows
```

**4. Try manual build:**
```bash
cd output/apple/internals
pdflatex "\def\currcompany{apple}\input{../../../src/main.tex}"
```

### Permission Errors

**Error:** `Permission denied` or `Cannot write to file`

**Linux/macOS:**

**1. Fix ownership:**
```bash
sudo chown -R $USER:$USER /path/to/cv-resume-repository
```

**2. Fix permissions:**
```bash
chmod -R u+w /path/to/cv-resume-repository/output
```

**3. Don't run make with sudo:**
```bash
# Wrong:
sudo make COMPANY=apple

# Correct:
make COMPANY=apple
```

Running with sudo creates files owned by root, causing permission issues.

**Windows:**

**1. Run as Administrator:**
- Right-click Command Prompt
- "Run as administrator"
- Navigate to repository
- Run build command

**2. Check folder permissions:**
- Right-click folder → Properties → Security
- Ensure your user has "Full control"

**3. Move repository to user folder:**
- Avoid `C:\Program Files` (requires admin)
- Use `C:\Users\YourName\Documents\`

---

## Platform-Specific Issues

### Linux-Specific Issues

**Old TeX Live version in repositories**

**Problem:** Distribution packages are outdated

**Example:** Ubuntu 20.04 ships TeX Live 2019, current is 2025

**Solution:** Install TeX Live manually

**1. Download installer:**
```bash
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*
```

**2. Run installer:**
```bash
sudo ./install-tl
```

**3. Add to PATH:**
```bash
echo 'export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH' >> ~/.bashrc
source ~/.bashrc
```

**Font cache issues**

**Problem:** Fonts not displaying correctly

**Solution:**
```bash
sudo fc-cache -fv
```

**SELinux issues (Fedora/RHEL)**

**Problem:** SELinux blocking LaTeX operations

**Solution:**
```bash
# Check SELinux status
getenforce

# Temporarily disable to test
sudo setenforce 0

# If that fixes it, create SELinux policy or disable permanently
```

### macOS-Specific Issues

**PATH not persistent**

**Problem:** Commands work after `eval "$(/usr/libexec/path_helper)"` but not after restart

**Solution:** Add to shell configuration
```bash
# Determine shell
echo $SHELL

# For zsh (default macOS Catalina+)
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc
source ~/.zshrc

# For bash
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.bash_profile
source ~/.bash_profile
```

**tlmgr permission denied**

**Problem:** `tlmgr: permission denied`

**Solution:** Always use sudo with tlmgr
```bash
sudo tlmgr update --self
sudo tlmgr install packagename
```

**Homebrew installation issues**

**Problem:** `brew install basictex` fails

**Solutions:**

**1. Update Homebrew:**
```bash
brew update
brew upgrade
```

**2. Try cask:**
```bash
brew install --cask basictex
```

**3. Install from PKG:**
- Download: https://tug.org/cgi-bin/mactex-download/BasicTeX.pkg
- Double-click to install

**Multiple LaTeX installations conflict**

**Problem:** Multiple TeX distributions installed, commands conflicting

**Solution:** Remove duplicates
```bash
# Check which pdflatex
which -a pdflatex

# Should show only:
# /Library/TeX/texbin/pdflatex

# If multiple shown, remove others
# Check what's installed
brew list | grep tex
```

**Gatekeeper blocking PKG files**

**Problem:** macOS won't open downloaded PKG

**Solution:**
```bash
# Allow downloaded PKG
xattr -dr com.apple.quarantine /path/to/MacTeX.pkg
# Or: Right-click → Open → Open anyway
```

### Windows-Specific Issues

**MiKTeX vs TeX Live conflicts**

**Problem:** Both installed, commands conflicting

**Solution:** Uninstall one

1. Open "Add or Remove Programs"
2. Uninstall MiKTeX or TeX Live (keep one)
3. Restart computer
4. Verify: `pdflatex --version`

**Windows Defender blocking downloads**

**Problem:** MiKTeX can't download packages, antivirus blocking

**Solution:**

**1. Add MiKTeX to exclusions:**
- Windows Security → Virus & threat protection
- Manage settings → Exclusions → Add exclusion
- Folder: `C:\Program Files\MiKTeX`

**2. Temporarily disable real-time protection** during installation

**Line ending issues (CRLF vs LF)**

**Problem:** Scripts fail with `\r` errors

**Solution:**

**Use Git Bash or convert line endings:**
```bash
# In Git Bash
dos2unix scripts/*.sh
```

**Configure Git:**
```bash
git config --global core.autocrlf false
```

**Spaces in path**

**Problem:** Build fails due to spaces in folder path

**Bad:**  `C:\Users\John Doe\My Documents\cv-resume-repository`
**Good:** `C:\Users\JohnDoe\Documents\cv-resume-repository`

**Solution:**

**1. Move repository to path without spaces**

**2. Or use quotes in commands:**
```batch
cd "C:\Users\John Doe\My Documents\cv-resume-repository"
```

**Git Bash vs Command Prompt**

**Problem:** Commands work in Git Bash but not Command Prompt

**Solution:**

**Either:**
1. Always use Git Bash (recommended for LaTeX work)
2. Or add tools to Windows PATH for Command Prompt use

**PowerShell ExecutionPolicy errors**

**Problem:** Cannot run PowerShell scripts

**Solution:**
```powershell
Set-ExecutionPolicy Bypass -Scope Process
.\scripts\install-latex-windows.ps1
```

---

## Network/Download Issues

**Slow package downloads**

**Solutions:**

**1. Change mirror (MiKTeX):**
- MiKTeX Console → Settings → Package repository
- Choose closer geographical mirror

**2. Change mirror (TeX Live):**
```bash
sudo tlmgr option repository https://mirror.ctan.org/systems/texlive/tlnet
```

**3. Use faster network** (avoid VPN if possible)

**Download fails / timeout**

**Solutions:**

**1. Check internet connection**
- Ping test: `ping ctan.org`

**2. Retry with timeout:**
```bash
sudo tlmgr update --self --all --repository https://mirror.ctan.org/systems/texlive/tlnet
```

**3. Different mirror:**
- Find mirrors: https://ctan.org/mirrors
- Select geographically close mirror
- Configure in tlmgr or MiKTeX Console

**4. Download offline (last resort):**
- TeX Live ISO: https://tug.org/texlive/acquire-iso.html
- Install from ISO offline

---

## Disk Space Issues

**Insufficient disk space**

**Solutions:**

**1. Check available space:**
```bash
df -h  # Linux/Mac
dir C:\  # Windows
```

**2. Use smaller installation:**
- BasicTeX (Mac): 100MB instead of 4GB
- TeX Live Basic (Linux): 500MB instead of 5GB
- MiKTeX Basic (Windows): 200MB instead of 4GB

**3. Clean old files:**
```bash
# Repository
make fclean  # Remove all output

# TeX Live cache (Linux/Mac)
sudo rm -rf ~/.texlive*

# MiKTeX cache (Windows)
mpm --clear-cache

# System package cache
sudo apt-get clean  # Ubuntu/Debian
sudo dnf clean all  # Fedora
```

---

## Getting Further Help

If issues persist:

**1. Check system requirements:**
- Disk space: 500MB-7GB
- RAM: 1GB minimum
- OS: Supported version

**2. Review documentation:**
- [LINUX.md](LINUX.md)
- [MAC.md](MAC.md)
- [WINDOWS.md](WINDOWS.md)
- [VERIFICATION.md](VERIFICATION.md)

**3. Consult official docs:**
- TeX Live: https://tug.org/texlive/doc.html
- MiKTeX: https://docs.miktex.org/
- MacTeX: https://tug.org/mactex/

**4. Search for error messages:**
- Copy exact error message
- Search: "error message" + "texlive" or "miktex"
- Check TeX Stack Exchange: https://tex.stackexchange.com/

**5. Open repository issue:**
- Include:
  - Operating system and version
  - LaTeX distribution (`pdflatex --version`)
  - Full error message
  - Steps to reproduce
  - Output of `make clean && make COMPANY=apple`

---

## Emergency Workaround: Overleaf

If local installation proves too difficult, use Overleaf (cloud LaTeX):

**1. Create account:** https://www.overleaf.com/

**2. Create new project:**
- Click "New Project" → "Upload Project"
- Upload repository ZIP

**3. Set main document:**
- Menu → Settings → Main document: `src/main.tex`

**4. Compile:**
- Click "Recompile"
- Download PDF when ready

**Note:** This bypasses the Makefile system, so you'll need to manually change the `\currcompany` variable in `src/main.tex`.

**Limitation:** No `make` command, no automation, manual edits required.

---

## Prevention Tips

**Avoid future issues:**

**1. Keep updated:**
```bash
# TeX Live (Linux/Mac)
sudo tlmgr update --self --all

# MiKTeX (Windows)
# Use MiKTeX Console → Updates

# Distribution packages (Linux)
sudo apt-get update && sudo apt-get upgrade  # Ubuntu/Debian
sudo dnf upgrade  # Fedora
sudo pacman -Syu  # Arch
```

**2. Use version control:**
- Commit working configurations
- Can revert if issues arise
- Track what changed

**3. Document custom changes:**
- Note modifications to system
- Easier to debug later
- Share solutions with team

**4. Test after updates:**
- After OS updates
- After LaTeX updates
- Run: `make COMPANY=apple`
- Verify PDF generates correctly

**5. Backup working installation:**
- Document exact versions: `pdflatex --version`
- Export package list: `tlmgr list --only-installed > packages.txt`

---

**Still stuck?** Return to [INSTALLATION.md](../INSTALLATION.md) or [VERIFICATION.md](VERIFICATION.md).

**Quick Links:**
- [Back to Installation Guide](../INSTALLATION.md)
- [Verification Guide](VERIFICATION.md)
- [Linux Installation](LINUX.md)
- [macOS Installation](MAC.md)
- [Windows Installation](WINDOWS.md)
