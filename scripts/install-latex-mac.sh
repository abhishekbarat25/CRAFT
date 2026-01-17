#!/bin/bash
# =============================================================================
# install-latex-mac.sh - Automated LaTeX installation for macOS
# =============================================================================
# USAGE:
#   ./scripts/install-latex-mac.sh
#
# WHAT IT DOES:
#   1. Checks if Homebrew is installed (offers to install if not)
#   2. Installs BasicTeX via Homebrew
#   3. Configures PATH
#   4. Updates tlmgr (TeX Live Manager)
#   5. Installs required LaTeX packages
#   6. Verifies installation
#   7. Tests build
#
# REQUIREMENTS:
#   - macOS 10.15 (Catalina) or later
#   - Admin privileges
#   - Internet connection
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
echo -e "${BLUE}LaTeX Installation - macOS${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Check macOS version
check_macos_version() {
    MACOS_VERSION=$(sw_vers -productVersion)
    echo -e "Detected: ${GREEN}macOS $MACOS_VERSION${NC}"
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

# Check and install Homebrew
check_homebrew() {
    if command -v brew &> /dev/null; then
        echo -e "${GREEN}✓ Homebrew is installed${NC}"
        echo ""
        return 0
    else
        echo -e "${YELLOW}Homebrew is not installed${NC}"
        echo ""
        echo "Homebrew is a package manager for macOS."
        echo "This script will use it to install BasicTeX."
        echo ""
        read -p "Install Homebrew? (Y/n) " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
            install_homebrew
        else
            echo ""
            echo "Cannot proceed without Homebrew."
            echo "For manual installation, see docs/installation/MAC.md"
            exit 1
        fi
    fi
}

# Install Homebrew
install_homebrew() {
    echo -e "${BLUE}Installing Homebrew...${NC}"
    echo ""

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo -e "${GREEN}✓ Homebrew installed${NC}"
    echo ""
}

# Install BasicTeX
install_basictex() {
    echo -e "${BLUE}Installing BasicTeX...${NC}"
    echo ""

    echo "This will install BasicTeX (~100MB)"
    echo ""
    read -p "Continue? (Y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! -z $REPLY ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    echo "Installing BasicTeX via Homebrew..."
    brew install basictex

    echo -e "${GREEN}✓ BasicTeX installed${NC}"
    echo ""
}

# Configure PATH
configure_path() {
    echo -e "${BLUE}Configuring PATH...${NC}"
    echo ""

    # Update PATH for current session
    eval "$(/usr/libexec/path_helper)"

    # Determine shell
    if [[ $SHELL == */zsh ]]; then
        SHELL_RC=~/.zshrc
    elif [[ $SHELL == */bash ]]; then
        SHELL_RC=~/.bash_profile
    else
        SHELL_RC=~/.profile
    fi

    # Add to shell config if not already there
    if ! grep -q 'eval "$(/usr/libexec/path_helper)"' "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo '# LaTeX PATH configuration' >> "$SHELL_RC"
        echo 'eval "$(/usr/libexec/path_helper)"' >> "$SHELL_RC"
        echo -e "${GREEN}✓ PATH configured in $SHELL_RC${NC}"
    else
        echo -e "${GREEN}✓ PATH already configured${NC}"
    fi

    echo ""
}

# Check and install make
check_make() {
    if command -v make &> /dev/null; then
        echo -e "${GREEN}✓ make is already installed${NC}"
        echo ""
    else
        echo -e "${YELLOW}make is not installed${NC}"
        echo ""
        echo "Installing Xcode Command Line Tools (includes make)..."
        xcode-select --install
        echo ""
        echo "Click 'Install' in the dialog that appears."
        echo "Press Enter when installation is complete..."
        read
        echo -e "${GREEN}✓ make installed${NC}"
        echo ""
    fi
}

# Install LaTeX packages
install_packages() {
    echo -e "${BLUE}Installing required LaTeX packages...${NC}"
    echo ""

    # Update tlmgr
    echo "Updating TeX Live Manager..."
    sudo tlmgr update --self

    # Install packages
    echo "Installing packages: enumitem, titlesec, etoolbox..."
    sudo tlmgr install enumitem titlesec etoolbox

    echo -e "${GREEN}✓ Packages installed${NC}"
    echo ""
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
        echo "You may need to restart your terminal."
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
        echo -e "${YELLOW}IMPORTANT: Restart your terminal for PATH changes to take effect.${NC}"
        echo ""
        echo "Next steps:"
        echo "  1. Restart your terminal or run: source $SHELL_RC"
        echo "  2. Update your name in Makefile (line 12)"
        echo "  3. Update common files (src/common/)"
        echo "  4. Create company configuration: ./add_company.sh <company>"
        echo "  5. Build resume: make COMPANY=<company>"
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
        echo "Try restarting your terminal and running:"
        echo "  ./scripts/verify-setup.sh"
        echo ""
        echo "Troubleshooting:"
        echo "  - Restart terminal for PATH changes"
        echo "  - See docs/installation/VERIFICATION.md"
        echo "  - See docs/installation/TROUBLESHOOTING.md"
        echo ""
    fi
}

# Main installation flow
check_macos_version
check_existing
check_homebrew
install_basictex
configure_path
check_make
install_packages
verify_installation
