# LaTeX Installation - Linux

Comprehensive LaTeX installation guide for Linux distributions.

## Quick Install

### Ubuntu/Debian/Linux Mint
```bash
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-extra make
```

### Fedora/RHEL/CentOS/Rocky Linux
```bash
sudo dnf install texlive-scheme-basic texlive-collection-latexextra make
```

### Arch Linux/Manjaro
```bash
sudo pacman -S texlive-core texlive-latexextra make
```

### openSUSE
```bash
sudo zypper install texlive-latex texlive-latexextra make
```

## Automated Installation

Run the installation script:

```bash
cd /path/to/cv-resume-repository
chmod +x scripts/install-latex-linux.sh
./scripts/install-latex-linux.sh
```

The script will:
1. Detect your distribution automatically
2. Check if LaTeX is already installed
3. Install appropriate packages for your distribution
4. Verify the installation
5. Run a test build

## Installation Options

### Option 1: Basic Installation (Recommended)

**Size:** ~500MB | **Time:** 2-5 minutes

Includes core LaTeX and required packages for this project.

**Ubuntu/Debian:**
```bash
sudo apt-get install texlive-latex-base texlive-latex-extra make
```

**Fedora/RHEL:**
```bash
sudo dnf install texlive-scheme-basic texlive-collection-latexextra make
```

**Arch Linux:**
```bash
sudo pacman -S texlive-core texlive-latexextra make
```

**openSUSE:**
```bash
sudo zypper install texlive-latex texlive-latexextra make
```

### Option 2: Full Installation

**Size:** ~5GB | **Time:** 10-30 minutes

Complete TeX Live with all packages.

**Ubuntu/Debian:**
```bash
sudo apt-get install texlive-full make
```

**Fedora/RHEL:**
```bash
sudo dnf install texlive-scheme-full make
```

**Arch Linux:**
```bash
sudo pacman -S texlive-most make
```

**openSUSE:**
```bash
sudo zypper install texlive-scheme-full make
```

### Option 3: Minimal Installation

**Size:** ~200MB | **Time:** 1-2 minutes

Only essential packages. May require installing additional packages later.

**Ubuntu/Debian:**
```bash
sudo apt-get install texlive-latex-base make
# Install additional packages if needed:
sudo apt-get install texlive-latex-extra
```

**Fedora/RHEL:**
```bash
sudo dnf install texlive-latex-bin texlive-collection-basic make
```

**Arch Linux:**
```bash
sudo pacman -S texlive-core make
```

## Detailed Instructions by Distribution

### Ubuntu/Debian/Linux Mint

**1. Update package lists:**
```bash
sudo apt-get update
```

**2. Install LaTeX:**
```bash
sudo apt-get install texlive-latex-base texlive-latex-extra make
```

**3. Verify installation:**
```bash
pdflatex --version
make --version
```

**Expected output:**
```
pdfTeX 3.14159... (TeX Live 20XX/Debian)
GNU Make X.X
```

### Fedora/RHEL/CentOS/Rocky Linux

**1. Install LaTeX:**
```bash
sudo dnf install texlive-scheme-basic texlive-collection-latexextra make
```

**2. Verify:**
```bash
pdflatex --version
make --version
```

### Arch Linux/Manjaro

**1. Install LaTeX:**
```bash
sudo pacman -S texlive-core texlive-latexextra make
```

**2. Verify:**
```bash
pdflatex --version
make --version
```

### openSUSE

**1. Install LaTeX:**
```bash
sudo zypper install texlive-latex texlive-latexextra make
```

**2. Verify:**
```bash
pdflatex --version
make --version
```

## Package Details

### Required Packages by Distribution

| Distribution | Package Names | Install Command |
|--------------|---------------|-----------------|
| Ubuntu/Debian | texlive-latex-base, texlive-latex-extra, make | `sudo apt-get install` |
| Fedora/RHEL | texlive-scheme-basic, texlive-collection-latexextra, make | `sudo dnf install` |
| Arch Linux | texlive-core, texlive-latexextra, make | `sudo pacman -S` |
| openSUSE | texlive-latex, texlive-latexextra, make | `sudo zypper install` |

### LaTeX Packages Included

The installation includes these required packages:

| Package | Purpose | Included In |
|---------|---------|-------------|
| geometry | Page margins and layout | texlive-latex-extra (Debian) |
| hyperref | Clickable links in PDFs | texlive-latex-extra (Debian) |
| enumitem | Custom bullet points | texlive-latex-extra (Debian) |
| titlesec | Section formatting | texlive-latex-extra (Debian) |
| etoolbox | LaTeX programming tools | texlive-latex-extra (Debian) |

## Alternative: Manual TeX Live Installation

For the latest version or unsupported distributions:

**1. Download TeX Live installer:**
```bash
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*
```

**2. Run installer:**
```bash
sudo ./install-tl
```

**3. Follow prompts:**
- Press `I` to install
- Or press `C` for custom installation
- Select scheme: basic (smaller) or full (complete)
- Wait for installation (10-60 minutes depending on scheme)

**4. Add to PATH:**
```bash
echo 'export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH' >> ~/.bashrc
source ~/.bashrc
```

**Note:** Replace `2025` and `x86_64-linux` with your installed version and architecture.

**5. Verify:**
```bash
pdflatex --version
tlmgr --version
```

**Official documentation:** https://tug.org/texlive/quickinstall.html

## Verification

After installation, verify everything works:

**1. Check pdflatex:**
```bash
pdflatex --version
```

Expected output: `pdfTeX 3.14159...`

**2. Check make:**
```bash
make --version
```

Expected output: `GNU Make X.X`

**3. Test build:**
```bash
cd /path/to/cv-resume-repository
make COMPANY=apple
```

Expected: PDF generated at `output/apple/Your_Name_apple.pdf`

**For detailed verification:** See [VERIFICATION.md](VERIFICATION.md)

## Troubleshooting

### Quick Fixes

**"pdflatex: command not found"**

1. Install texlive-latex-base package
2. Check PATH includes LaTeX bin directory
3. Restart terminal

**"File geometry.sty not found"**

Install texlive-latex-extra package:
```bash
sudo apt-get install texlive-latex-extra  # Ubuntu/Debian
sudo dnf install texlive-collection-latexextra  # Fedora
sudo pacman -S texlive-latexextra  # Arch
```

**"make: command not found"**

Install make package:
```bash
sudo apt-get install make  # Ubuntu/Debian
sudo dnf install make  # Fedora
sudo pacman -S make  # Arch
```

**Build fails with missing package errors**

Option 1 - Install package group:
```bash
sudo apt-get install texlive-latex-extra
```

Option 2 - Install specific package (if using manual TeX Live):
```bash
sudo tlmgr install packagename
```

**Permission denied errors**

Don't run make with sudo:
```bash
# Wrong:
sudo make COMPANY=apple

# Correct:
make COMPANY=apple
```

If output directory has permission issues:
```bash
chmod -R u+w output/
```

**For more issues:** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

## Package Management

### Using Distribution Package Manager

**Update packages:**
```bash
sudo apt-get update && sudo apt-get upgrade  # Ubuntu/Debian
sudo dnf upgrade  # Fedora
sudo pacman -Syu  # Arch
```

### Using TeX Live Manager (tlmgr)

If you installed TeX Live manually:

**Update tlmgr:**
```bash
sudo tlmgr update --self
```

**Install package:**
```bash
sudo tlmgr install packagename
```

**Search for package:**
```bash
tlmgr search packagename
```

**List installed packages:**
```bash
tlmgr list --only-installed
```

**Update all packages:**
```bash
sudo tlmgr update --all
```

## Disk Space Information

| Installation Type | Size | Packages |
|-------------------|------|----------|
| Minimal | ~200MB | Basic only |
| Recommended | ~500MB | Base + Extra |
| Full | ~5GB | Everything |

**Check available space:**
```bash
df -h /usr
```

**Clean package cache after install:**
```bash
sudo apt-get clean  # Ubuntu/Debian
sudo dnf clean all  # Fedora
sudo pacman -Sc  # Arch
```

## Uninstalling

### Remove Distribution Packages

**Ubuntu/Debian:**
```bash
sudo apt-get remove texlive* --purge
sudo apt-get autoremove
```

**Fedora/RHEL:**
```bash
sudo dnf remove texlive-*
```

**Arch Linux:**
```bash
sudo pacman -Rs texlive-core texlive-latexextra
```

### Remove Manual TeX Live Installation

```bash
sudo rm -rf /usr/local/texlive
```

Remove PATH entry from `~/.bashrc`.

## Official Resources

- **TeX Live:** https://tug.org/texlive/
- **Quick install guide:** https://tug.org/texlive/quickinstall.html
- **CTAN (packages):** https://www.ctan.org/
- **TeX Live documentation:** https://tug.org/texlive/doc.html

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
- [macOS Installation](MAC.md)
- [Windows Installation](WINDOWS.md)
