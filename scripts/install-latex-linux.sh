#!/bin/bash
# =============================================================================
# install-latex-linux.sh - Automated LaTeX installation for Linux
# =============================================================================
# USAGE:
#   ./scripts/install-latex-linux.sh
#
# WHAT IT DOES:
#   1. Detects Linux distribution (Ubuntu, Fedora, Arch, openSUSE)
#   2. Checks if LaTeX is already installed
#   3. Installs appropriate LaTeX packages for the distribution
#   4. Installs make if missing
#   5. Verifies installation
#   6. Tests build
#
# SUPPORTED DISTRIBUTIONS:
#   - Ubuntu/Debian/Linux Mint
#   - Fedora/RHEL/CentOS/Rocky Linux
#   - Arch Linux/Manjaro
#   - openSUSE
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}LaTeX Installation - Linux${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_ID=$ID
        DISTRO_NAME=$NAME
    elif command -v lsb_release &> /dev/null; then
        DISTRO_ID=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
        DISTRO_NAME=$(lsb_release -sd)
    else
        echo -e "${RED}ERROR: Cannot detect Linux distribution${NC}"
        echo "Please install manually. See docs/installation/LINUX.md"
        exit 1
    fi

    echo -e "Detected: ${GREEN}$DISTRO_NAME${NC}"
    echo ""
}

# Check if LaTeX already installed
check_existing() {
    if command -v pdflatex &> /dev/null && command -v make &> /dev/null; then
        echo -e "${GREEN}LaTeX and make are already installed!${NC}"
        echo ""
        pdflatex --version | head -n 1
        make --version | head -n 1
        echo ""
        read -p "Do you want to skip installation? (Y/n) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
            echo "Skipping installation. Running verification..."
            echo ""
            verify_installation
            exit 0
        fi
    fi
}

# Install for Ubuntu/Debian
install_ubuntu() {
    echo -e "${BLUE}Installing LaTeX for Ubuntu/Debian...${NC}"
    echo ""

    echo "This will install:"
    echo "  - texlive-latex-base (~200MB)"
    echo "  - texlive-latex-extra (~300MB)"
    echo "  - make"
    echo ""
    read -p "Continue? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    echo "Updating package lists..."
    sudo apt-get update

    echo "Installing LaTeX and make..."
    sudo apt-get install -y texlive-latex-base texlive-latex-extra make

    echo -e "${GREEN}✓ Installation complete${NC}"
}

# Install for Fedora/RHEL
install_fedora() {
    echo -e "${BLUE}Installing LaTeX for Fedora/RHEL...${NC}"
    echo ""

    echo "This will install:"
    echo "  - texlive-scheme-basic"
    echo "  - texlive-collection-latexextra"
    echo "  - make"
    echo ""
    read -p "Continue? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    echo "Installing LaTeX and make..."
    sudo dnf install -y texlive-scheme-basic texlive-collection-latexextra make

    echo -e "${GREEN}✓ Installation complete${NC}"
}

# Install for Arch Linux
install_arch() {
    echo -e "${BLUE}Installing LaTeX for Arch Linux...${NC}"
    echo ""

    echo "This will install:"
    echo "  - texlive-core"
    echo "  - texlive-latexextra"
    echo "  - make"
    echo ""
    read -p "Continue? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    echo "Installing LaTeX and make..."
    sudo pacman -S --noconfirm texlive-core texlive-latexextra make

    echo -e "${GREEN}✓ Installation complete${NC}"
}

# Install for openSUSE
install_opensuse() {
    echo -e "${BLUE}Installing LaTeX for openSUSE...${NC}"
    echo ""

    echo "This will install:"
    echo "  - texlive-latex"
    echo "  - texlive-latexextra"
    echo "  - make"
    echo ""
    read -p "Continue? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    echo "Installing LaTeX and make..."
    sudo zypper install -y texlive-latex texlive-latexextra make

    echo -e "${GREEN}✓ Installation complete${NC}"
}

# Verify installation
verify_installation() {
    echo ""
    echo -e "${BLUE}Verifying installation...${NC}"
    echo ""

    # Check pdflatex
    if command -v pdflatex &> /dev/null; then
        echo -e "${GREEN}✓ pdflatex installed${NC}"
        pdflatex --version | head -n 1
    else
        echo -e "${RED}✗ pdflatex not found${NC}"
        echo "Installation may have failed. Check logs above."
        exit 1
    fi

    # Check make
    if command -v make &> /dev/null; then
        echo -e "${GREEN}✓ make installed${NC}"
        make --version | head -n 1
    else
        echo -e "${RED}✗ make not found${NC}"
        echo "Installation may have failed. Check logs above."
        exit 1
    fi

    echo ""
    echo -e "${BLUE}Running verification script...${NC}"
    echo ""

    # Find repository root
    REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
    cd "$REPO_ROOT"

    # Make verify script executable
    chmod +x scripts/verify-setup.sh

    # Run verification
    if ./scripts/verify-setup.sh; then
        echo ""
        echo -e "${GREEN}================================================${NC}"
        echo -e "${GREEN}Installation Successful!${NC}"
        echo -e "${GREEN}================================================${NC}"
        echo ""
        echo "LaTeX is ready to use."
        echo ""
        echo "Next steps:"
        echo "  1. Update your name in Makefile (line 12)"
        echo "  2. Update common files (src/common/)"
        echo "  3. Create company configuration: ./add_company.sh <company>"
        echo "  4. Build resume: make COMPANY=<company>"
        echo ""
        echo "Documentation:"
        echo "  - Quickstart: docs/QUICKSTART.md"
        echo "  - Usage Guide: docs/USAGE_GUIDE.md"
        echo ""
    else
        echo ""
        echo -e "${YELLOW}================================================${NC}"
        echo -e "${YELLOW}Installation completed with warnings${NC}"
        echo -e "${YELLOW}================================================${NC}"
        echo ""
        echo "LaTeX installed but verification had issues."
        echo ""
        echo "Troubleshooting:"
        echo "  - Check error messages above"
        echo "  - See docs/installation/VERIFICATION.md"
        echo "  - See docs/installation/TROUBLESHOOTING.md"
        echo ""
    fi
}

# Main installation flow
detect_distro
check_existing

case "$DISTRO_ID" in
    ubuntu|debian|linuxmint|pop)
        install_ubuntu
        ;;
    fedora|rhel|centos|rocky)
        install_fedora
        ;;
    arch|manjaro)
        install_arch
        ;;
    opensuse*|sles)
        install_opensuse
        ;;
    *)
        echo -e "${YELLOW}WARNING: Unsupported distribution: $DISTRO_ID${NC}"
        echo ""
        echo "This script supports:"
        echo "  - Ubuntu/Debian/Linux Mint"
        echo "  - Fedora/RHEL/CentOS/Rocky Linux"
        echo "  - Arch Linux/Manjaro"
        echo "  - openSUSE"
        echo ""
        echo "For manual installation, see:"
        echo "  docs/installation/LINUX.md"
        echo ""
        exit 1
        ;;
esac

verify_installation
