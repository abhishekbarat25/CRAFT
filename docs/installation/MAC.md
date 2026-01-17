# LaTeX Installation - macOS

Comprehensive LaTeX installation guide for macOS.

## Quick Install

### Recommended: Homebrew + BasicTeX

```bash
brew install basictex
eval "$(/usr/libexec/path_helper)"
sudo tlmgr update --self
sudo tlmgr install enumitem titlesec etoolbox
```

### Full Installation: MacTeX

Download and install MacTeX from:
https://tug.org/mactex/mactex-download.html

## Automated Installation

Run the installation script:

```bash
cd /path/to/cv-resume-repository
chmod +x scripts/install-latex-mac.sh
./scripts/install-latex-mac.sh
```

The script will:
1. Detect if Homebrew is installed (offers to install if not)
2. Install BasicTeX via Homebrew
3. Update PATH configuration
4. Install required LaTeX packages via tlmgr
5. Verify the installation
6. Run a test build

## Installation Options

### Option 1: BasicTeX (Recommended)

**Size:** ~100MB | **Time:** 2-5 minutes | **Method:** Homebrew

Minimal LaTeX distribution, fast installation, sufficient for this project.

**Step-by-step:**

**1. Install Homebrew** (if not already installed):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Install BasicTeX:**
```bash
brew install basictex
```

**3. Update PATH** (critical step):
```bash
# For current session
eval "$(/usr/libexec/path_helper)"

# Make permanent (zsh - default on macOS Catalina+)
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc
source ~/.zshrc

# Make permanent (bash - older macOS)
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.bash_profile
source ~/.bash_profile
```

**4. Update TeX Live Manager:**
```bash
sudo tlmgr update --self
```

**5. Install required packages:**
```bash
sudo tlmgr install enumitem titlesec etoolbox
```

**6. Verify:**
```bash
pdflatex --version
which pdflatex  # Should show /Library/TeX/texbin/pdflatex
```

### Option 2: MacTeX (Full Installation)

**Size:** ~4GB | **Time:** 10-20 minutes | **Method:** Direct download

Complete LaTeX with GUI tools and all packages.

**Why MacTeX?**
- Includes all packages (no manual package installation needed)
- GUI tools (TeXShop, BibDesk, LaTeXiT)
- Recommended for beginners or heavy LaTeX users

**Step-by-step:**

**1. Download MacTeX:**
- Visit: https://tug.org/mactex/
- Click "MacTeX Download" button
- Or direct download: https://mirror.ctan.org/systems/mac/mactex/MacTeX.pkg
- File size: ~4GB

**2. Install:**
- Open MacTeX.pkg
- Follow installation wizard
- Installation time: 10-20 minutes
- Requires admin password

**3. Restart terminal** (important):
```bash
# Close and reopen Terminal
```

**4. Verify:**
```bash
pdflatex --version
which pdflatex  # Should show /Library/TeX/texbin/pdflatex
```

### Option 3: MacPorts

**Size:** ~500MB | **Time:** 5-15 minutes

For users with MacPorts:

**1. Update MacPorts:**
```bash
sudo port selfupdate
```

**2. Install LaTeX:**
```bash
sudo port install texlive-latex texlive-latex-extra
```

**3. Verify:**
```bash
pdflatex --version
```

## Installing make

macOS usually includes make with Xcode Command Line Tools.

**Check if installed:**
```bash
make --version
```

**If not installed:**
```bash
xcode-select --install
```

Click "Install" in the dialog that appears.

## PATH Configuration

**Critical for macOS:** LaTeX commands won't work without proper PATH setup.

**Update PATH for current session:**
```bash
eval "$(/usr/libexec/path_helper)"
```

**Make permanent (zsh):**
```bash
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc
source ~/.zshrc
```

**Make permanent (bash):**
```bash
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.bash_profile
source ~/.bash_profile
```

**Check which shell you're using:**
```bash
echo $SHELL
# /bin/zsh = use .zshrc
# /bin/bash = use .bash_profile
```

## Package Management with tlmgr

TeX Live Manager (tlmgr) manages LaTeX packages.

**Update tlmgr:**
```bash
sudo tlmgr update --self
```

**Install packages:**
```bash
sudo tlmgr install package-name
```

**Search for packages:**
```bash
tlmgr search package-name
```

**List installed packages:**
```bash
tlmgr list --only-installed
```

**Update all packages:**
```bash
sudo tlmgr update --all
```

## Required Packages

These packages are required for this project:

| Package | Status | Installation |
|---------|--------|--------------|
| geometry | ✓ Included in BasicTeX | Pre-installed |
| hyperref | ✓ Included in BasicTeX | Pre-installed |
| enumitem | ⚠ Must install | `sudo tlmgr install enumitem` |
| titlesec | ⚠ Must install | `sudo tlmgr install titlesec` |
| etoolbox | ⚠ Must install | `sudo tlmgr install etoolbox` |

**Quick install all required packages:**
```bash
sudo tlmgr install enumitem titlesec etoolbox
```

## Verification

After installation:

**1. Check pdflatex:**
```bash
pdflatex --version
```
Expected: `pdfTeX 3.141592...`

**2. Check path:**
```bash
which pdflatex
```
Expected: `/Library/TeX/texbin/pdflatex`

**3. Check make:**
```bash
make --version
```
Expected: `GNU Make 3.81` or higher

**4. Test build:**
```bash
cd /path/to/cv-resume-repository
make COMPANY=apple
```

Expected: PDF generated at `output/apple/Your_Name_apple.pdf`

**For detailed verification:** See [VERIFICATION.md](VERIFICATION.md)

## Troubleshooting

### Quick Fixes

**"pdflatex: command not found"**

1. Update PATH:
   ```bash
   eval "$(/usr/libexec/path_helper)"
   ```

2. Add to shell config:
   ```bash
   echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc
   ```

3. Restart terminal

4. If still not working, reinstall:
   ```bash
   brew reinstall basictex
   ```

**"tlmgr: command not found"**

1. Update PATH as above
2. Check if tlmgr exists:
   ```bash
   ls -la /Library/TeX/texbin/tlmgr
   ```

3. If missing, reinstall BasicTeX

**"File enumitem.sty not found"**

Install missing packages:
```bash
sudo tlmgr install enumitem titlesec etoolbox
```

**Homebrew installation fails**

1. Check internet connection
2. Update Homebrew:
   ```bash
   brew update
   ```

3. Try alternative:
   ```bash
   brew install --cask basictex
   ```

4. Or download BasicTeX directly:
   - https://tug.org/cgi-bin/mactex-download/BasicTeX.pkg

**Permission denied when using tlmgr**

Always use `sudo` with tlmgr:
```bash
sudo tlmgr install packagename
```

**Commands work after PATH update but not after restart**

PATH not persistent. Add to shell config:
```bash
# Check your shell
echo $SHELL

# If zsh:
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.zshrc

# If bash:
echo 'eval "$(/usr/libexec/path_helper)"' >> ~/.bash_profile
```

**For more issues:** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

## Upgrading

### Upgrade BasicTeX:
```bash
brew upgrade basictex
sudo tlmgr update --self --all
```

### Upgrade MacTeX:
Download new version from https://tug.org/mactex/

## Uninstalling

### Remove BasicTeX:
```bash
brew uninstall basictex
sudo rm -rf /Library/TeX
```

Remove PATH config from `~/.zshrc` or `~/.bash_profile`.

### Remove MacTeX:

Use official uninstaller or:
```bash
sudo rm -rf /Library/TeX
sudo rm -rf /Applications/TeX
```

## Disk Space Information

| Installation Type | Size | Time | Includes |
|-------------------|------|------|----------|
| BasicTeX | ~100MB | 2-5 min | Core + manual packages |
| MacTeX | ~4GB | 10-20 min | Everything + GUI tools |

**Check available space:**
```bash
df -h /Library
```

## macOS Version Compatibility

| macOS Version | BasicTeX | MacTeX | Notes |
|---------------|----------|--------|-------|
| Sonoma (14.x) | ✓ | ✓ | Fully supported |
| Ventura (13.x) | ✓ | ✓ | Fully supported |
| Monterey (12.x) | ✓ | ✓ | Fully supported |
| Big Sur (11.x) | ✓ | ✓ | Fully supported |
| Catalina (10.15) | ✓ | ✓ | Uses zsh by default |
| Older versions | ⚠ | ⚠ | May work, check official docs |

## Apple Silicon (M1/M2/M3) Support

Both BasicTeX and MacTeX fully support Apple Silicon Macs.

**Verify architecture:**
```bash
uname -m
# arm64 = Apple Silicon
# x86_64 = Intel
```

The correct binaries are installed automatically.

## Official Resources

- **MacTeX:** https://tug.org/mactex/
- **BasicTeX:** https://tug.org/mactex/morepackages.html
- **TeX Live:** https://tug.org/texlive/
- **Homebrew:** https://brew.sh/
- **TeX on Mac FAQ:** https://tug.org/mactex/faq/

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
- [Windows Installation](WINDOWS.md)
