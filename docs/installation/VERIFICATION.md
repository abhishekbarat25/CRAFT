# Installation Verification

Complete checklist to verify your LaTeX setup is working correctly.

## Quick Verification

Run these commands in your terminal:

```bash
# Check pdflatex
pdflatex --version

# Check make
make --version

# Test build
cd /path/to/cv-resume-repository
make COMPANY=apple
```

If all three work, you're ready! Otherwise, follow detailed steps below.

---

## Detailed Verification Steps

### Step 1: Verify pdflatex

**Linux/macOS:**
```bash
pdflatex --version
```

**Windows:**
```batch
pdflatex --version
```

**Expected output:**
```
pdfTeX 3.141592653-2.6-1.40.XX (TeX Live 20XX)
kpathsea version X.X.X
Copyright 20XX Han The Thanh (pdfTeX) et al.
...
```

**Variations:**
- **TeX Live:** `pdfTeX 3.14159... (TeX Live 20XX)`
- **MiKTeX:** `MiKTeX-pdfTeX X.XX (MiKTeX X.XX)`
- **MacTeX:** `pdfTeX 3.14159... (TeX Live 20XX/MacTeX)`

**✅ Success if:** Version number displays

**❌ Failure if:**
- `pdflatex: command not found` (Linux/Mac)
- `'pdflatex' is not recognized` (Windows)
- See [Troubleshooting](#troubleshooting-command-not-found)

### Step 2: Verify make

**All platforms:**
```bash
make --version
```

**Expected output:**
```
GNU Make X.X
Built for ...
Copyright (C) ...
```

**✅ Success if:** Shows "GNU Make" with version

**❌ Failure if:**
- `make: command not found` (Linux/Mac)
- `'make' is not recognized` (Windows)
- See [Troubleshooting](#troubleshooting-make-not-found)

### Step 3: Verify LaTeX Packages

Create a minimal test file to verify required packages:

**Linux/macOS:**
```bash
cd /tmp
cat > test.tex << 'EOF'
\documentclass{article}
\usepackage{geometry}
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage{titlesec}
\usepackage{etoolbox}
\begin{document}
LaTeX package test successful!
\end{document}
EOF

pdflatex test.tex
```

**Windows (PowerShell):**
```powershell
cd $env:TEMP
@"
\documentclass{article}
\usepackage{geometry}
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage{titlesec}
\usepackage{etoolbox}
\begin{document}
LaTeX package test successful!
\end{document}
"@ | Out-File -Encoding ASCII test.tex

pdflatex test.tex
```

**✅ Success if:** Creates test.pdf without errors

**❌ Failure if:**
- `File 'geometry.sty' not found`
- `File 'enumitem.sty' not found`
- etc.

**Fix:**
- **Linux:** `sudo apt-get install texlive-latex-extra`
- **macOS:** `sudo tlmgr install enumitem titlesec etoolbox`
- **Windows (MiKTeX):** Auto-installs on first build, or use MiKTeX Console

**Cleanup:**
```bash
rm test.*  # Linux/Mac
del test.*  # Windows
```

### Step 4: Test Repository Build

**Linux/macOS:**
```bash
cd /path/to/cv-resume-repository
make COMPANY=apple
```

**Windows:**
```batch
cd C:\path\to\cv-resume-repository
make COMPANY=apple
```

**Expected output:**
```
mkdir -p output/apple/internals
pdflatex -jobname=Your_Name_apple ...
This is pdfTeX, Version 3.14159...
...
Output written on Your_Name_apple.pdf (1 page, XXXXX bytes).
Transcript written on Your_Name_apple.log.
...
-------------------------------------------------------
PDF GENERATED: output/apple/Your_Name_apple.pdf
-------------------------------------------------------
```

**✅ Success if:**
- PDF is created at `output/apple/Your_Name_apple.pdf`
- No error messages
- Build completes in 5-15 seconds

**❌ Failure if:**
- Missing package errors
- File not found errors
- See [Troubleshooting Build Errors](#troubleshooting-build-errors)

### Step 5: Verify PDF Output

Open the generated PDF:

**Linux:**
```bash
xdg-open output/apple/Your_Name_apple.pdf
```

**macOS:**
```bash
open output/apple/Your_Name_apple.pdf
```

**Windows:**
```batch
start output\apple\Your_Name_apple.pdf
```

**Or use your PDF viewer:**
- Adobe Acrobat Reader
- Preview (macOS)
- Browser
- etc.

**Check for:**
- ✅ PDF opens without errors
- ✅ Contact information displays correctly
- ✅ Sections are properly formatted
- ✅ Links are clickable (email, LinkedIn, phone)
- ✅ Exactly one page
- ✅ Proper fonts and spacing

---

## Verification Checklist

Print or check off as you complete each step:

- [ ] `pdflatex --version` works
- [ ] `make --version` works
- [ ] Test LaTeX file compiles successfully
- [ ] All required packages are installed (geometry, hyperref, enumitem, titlesec, etoolbox)
- [ ] Repository builds successfully (`make COMPANY=apple`)
- [ ] PDF is generated in `output/apple/`
- [ ] PDF opens and displays correctly
- [ ] PDF is exactly one page
- [ ] Links in PDF are clickable

**All checked?** You're ready to use the system! Return to [QUICKSTART.md](../QUICKSTART.md).

---

## Troubleshooting

### Command Not Found

**Problem:** `pdflatex: command not found` or `'pdflatex' is not recognized`

**Solutions:**

**1. Verify installation:**
- **Linux:** `dpkg -l | grep texlive`
- **macOS:** `ls /Library/TeX/texbin/`
- **Windows:** Check "Add/Remove Programs" for MiKTeX or TeX Live

**2. Fix PATH:**
- **Linux:** Reinstall package
- **macOS:** Run `eval "$(/usr/libexec/path_helper)"` and add to ~/.zshrc
- **Windows:** Add to PATH (see [WINDOWS.md](WINDOWS.md#path-configuration))

**3. Restart terminal** after PATH changes

### Make Not Found

**Problem:** `make: command not found` or `'make' is not recognized`

**Solutions:**

**Linux:**
```bash
sudo apt-get install make        # Ubuntu/Debian
sudo dnf install make            # Fedora
sudo pacman -S make              # Arch
```

**macOS:**
```bash
xcode-select --install
```

**Windows:**
- Use Git Bash (includes make)
- Or install via Chocolatey: `choco install make`
- Or see [WINDOWS.md](WINDOWS.md#installing-make)

### Missing Package Errors

**Problem:** `File 'packagename.sty' not found`

**Solutions:**

**Ubuntu/Debian:**
```bash
sudo apt-get install texlive-latex-extra
```

**Fedora/RHEL:**
```bash
sudo dnf install texlive-collection-latexextra
```

**macOS:**
```bash
sudo tlmgr update --self
sudo tlmgr install enumitem titlesec etoolbox
```

**Windows (MiKTeX):**
- Enable auto-install in MiKTeX Console
- Or manually install via MiKTeX Console → Packages

**Any system with tlmgr:**
```bash
sudo tlmgr install packagename
```

### Build Errors

**Problem:** LaTeX compilation fails with errors

**Common causes:**

**1. Missing packages:** See [Missing Package Errors](#missing-package-errors)

**2. Syntax errors in .tex files:**
- Check for unmatched braces `{}`
- Escape special characters: `\$`, `\%`, `\&`, `\_`
- Run `make clean` then `make COMPANY=apple`

**3. File permission errors:**
- **Linux/Mac:** `chmod -R u+w output/`
- **Windows:** Check folder permissions

**4. Corrupted auxiliary files:**
```bash
make fclean
make COMPANY=apple
```

**View detailed error log:**
```bash
cat output/apple/internals/Your_Name_apple.log  # Linux/Mac
type output\apple\internals\Your_Name_apple.log  # Windows
```

### PDF Not Generated

**Problem:** Build completes but no PDF appears

**Check:**

**1. Look in correct location:**
```bash
ls output/apple/  # Linux/Mac
dir output\apple\  # Windows
```
Should show: `Your_Name_apple.pdf`

**2. Check for errors in build output:**
- Scroll up in terminal
- Look for "Error:" or "!"

**3. Check internals folder:**
```bash
ls output/apple/internals/  # Linux/Mac
dir output\apple\internals\  # Windows
```
If .pdf is there but not in parent folder, check Makefile

**4. Permissions:**
- **Linux/Mac:** `chmod -R u+w output/`
- **Windows:** Right-click folder → Properties → Security

---

## Verification Scripts

### Automated Verification

Use the automated verification script:

**Linux/macOS:**
```bash
cd /path/to/cv-resume-repository
chmod +x scripts/verify-setup.sh
./scripts/verify-setup.sh
```

**Windows:**
```batch
cd C:\path\to\cv-resume-repository
scripts\verify-setup.bat
```

The script will:
- Check pdflatex availability
- Check make availability
- Verify LaTeX packages
- Test repository build
- Report results with ✓/✗ for each check

---

## Platform-Specific Issues

### Linux

**Issue:** TeX Live version is very old

**Example:** Ubuntu 20.04 ships with TeX Live 2019

**Solution:** Use manual TeX Live installation instead of distribution packages
- See [LINUX.md](LINUX.md#alternative-manual-tex-live-installation)

**Issue:** Font cache issues

**Solution:**
```bash
sudo fc-cache -fv
```

### macOS

**Issue:** PATH not persistent after restart

**Solution:** Add to shell configuration
```bash
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc
source ~/.zshrc
```

**Issue:** `tlmgr` permission denied

**Solution:** Use `sudo tlmgr ...`
```bash
sudo tlmgr install packagename
```

**Issue:** Multiple LaTeX installations conflict

**Solution:** Check which pdflatex is being used
```bash
which -a pdflatex
# Should show only: /Library/TeX/texbin/pdflatex
# Remove others if multiple found
```

### Windows

**Issue:** MiKTeX asks to install packages during build

**Solution:** This is normal! Click "Install" when prompted

**Or pre-configure:**
- MiKTeX Console → Settings → "Always install missing packages on-the-fly"

**Issue:** Commands work in Git Bash but not Command Prompt

**Solution:**
- Add to Windows PATH (see [WINDOWS.md](WINDOWS.md#path-configuration))
- Or use Git Bash for all LaTeX work

**Issue:** Spaces in path cause errors

**Example:** `C:\Users\John Doe\Documents\cv-resume-repository`

**Solution:** Move to path without spaces or use quotes:
```batch
cd "C:\Users\John Doe\Documents\cv-resume-repository"
```

---

## Getting Help

If verification still fails after troubleshooting:

**1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)** for comprehensive solutions

**2. Review platform-specific guide:**
- [LINUX.md](LINUX.md)
- [MAC.md](MAC.md)
- [WINDOWS.md](WINDOWS.md)

**3. Consult official documentation:**
- TeX Live: https://tug.org/texlive/doc.html
- MiKTeX: https://docs.miktex.org/
- MacTeX: https://tug.org/mactex/

**4. Open an issue** on the repository with:
- Operating system and version
- LaTeX distribution (`pdflatex --version`)
- Full error message
- Output of all verification steps
- Steps to reproduce

---

## Next Steps

Once verification is complete:

1. ✅ **Update your name** in `Makefile` (line 12)
2. ✅ **Update common files:**
   - `src/common/header.tex` - Contact information
   - `src/common/education.tex` - Education history
   - `src/common/skills.tex` - Technical skills
3. ✅ **Create company configuration:**
   ```bash
   ./add_company.sh google
   ```
4. ✅ **Build your first resume:**
   ```bash
   make COMPANY=google
   ```

**Continue to:** [QUICKSTART.md](../QUICKSTART.md)

---

**Quick Links:**
- [Back to Installation Guide](../INSTALLATION.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Linux Installation](LINUX.md)
- [macOS Installation](MAC.md)
- [Windows Installation](WINDOWS.md)
- [Quickstart Guide](../QUICKSTART.md)
