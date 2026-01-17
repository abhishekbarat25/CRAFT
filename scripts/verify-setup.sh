#!/bin/bash
# =============================================================================
# verify-setup.sh - Verify LaTeX installation for CV Resume Repository
# =============================================================================
# USAGE:
#   ./scripts/verify-setup.sh
#
# WHAT IT DOES:
#   1. Checks if pdflatex is installed and working
#   2. Checks if make is installed and working
#   3. Verifies required LaTeX packages are available
#   4. Tests minimal LaTeX compilation
#   5. Tests repository build
#   6. Reports results with ✓/✗ for each check
#
# EXIT CODES:
#   0 - All checks passed
#   1 - One or more checks failed
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Symbols
CHECK_MARK="${GREEN}✓${NC}"
CROSS_MARK="${RED}✗${NC}"
WARN_MARK="${YELLOW}⚠${NC}"

# Counters
PASSED=0
FAILED=0

# Header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}LaTeX Installation Verification${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Function to check command exists
check_command() {
    local cmd=$1
    local name=$2

    echo -n "Checking $name... "

    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n 1)
        echo -e "${CHECK_MARK} Found"
        echo "  Version: $version"
        ((PASSED++))
        return 0
    else
        echo -e "${CROSS_MARK} Not found"
        echo -e "  ${RED}ERROR: $name is not installed or not in PATH${NC}"
        ((FAILED++))
        return 1
    fi
}

# Function to check LaTeX package
check_package() {
    local package=$1

    echo -n "Checking package: $package... "

    # Create minimal test file
    local test_file=$(mktemp)
    cat > "$test_file" <<EOF
\\documentclass{article}
\\usepackage{$package}
\\begin{document}
Test
\\end{document}
EOF

    # Try to compile
    if pdflatex -interaction=nonstopmode -output-directory=/tmp "$test_file" &> /dev/null; then
        echo -e "${CHECK_MARK} Available"
        ((PASSED++))
        rm -f /tmp/*.pdf /tmp/*.log /tmp/*.aux "$test_file"
        return 0
    else
        echo -e "${CROSS_MARK} Missing"
        echo -e "  ${RED}ERROR: Package $package not found${NC}"
        ((FAILED++))
        rm -f /tmp/*.pdf /tmp/*.log /tmp/*.aux "$test_file"
        return 1
    fi
}

# Check pdflatex
check_command "pdflatex" "pdflatex"
PDFLATEX_OK=$?

# Check make
check_command "make" "make"
MAKE_OK=$?

echo ""
echo -e "${BLUE}Checking LaTeX packages...${NC}"

# Check required packages
check_package "geometry"
check_package "hyperref"
check_package "enumitem"
check_package "titlesec"
check_package "etoolbox"

echo ""
echo -e "${BLUE}Testing minimal LaTeX compilation...${NC}"

# Test minimal LaTeX file
TEST_FILE=$(mktemp --suffix=.tex)
cat > "$TEST_FILE" <<'EOF'
\documentclass{article}
\usepackage{geometry}
\usepackage{hyperref}
\usepackage{enumitem}
\usepackage{titlesec}
\usepackage{etoolbox}
\begin{document}
LaTeX verification test successful!
\end{document}
EOF

echo -n "Compiling test document... "

if pdflatex -interaction=nonstopmode -output-directory=/tmp "$TEST_FILE" > /dev/null 2>&1; then
    if [ -f "/tmp/$(basename "$TEST_FILE" .tex).pdf" ]; then
        echo -e "${CHECK_MARK} Success"
        ((PASSED++))
        rm -f /tmp/$(basename "$TEST_FILE" .tex).*
    else
        echo -e "${CROSS_MARK} PDF not generated"
        ((FAILED++))
    fi
else
    echo -e "${CROSS_MARK} Compilation failed"
    echo -e "  ${RED}Check /tmp/$(basename "$TEST_FILE" .tex).log for details${NC}"
    ((FAILED++))
fi

rm -f "$TEST_FILE"

echo ""
echo -e "${BLUE}Testing repository build...${NC}"

# Find repository root
REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)

echo -n "Building test resume (COMPANY=apple)... "

cd "$REPO_ROOT"

if make COMPANY=apple > /tmp/build.log 2>&1; then
    # Check if PDF was generated
    if [ -f "output/apple/"*"_apple.pdf" ]; then
        PDF_FILE=$(ls output/apple/*_apple.pdf | head -n 1)
        PDF_SIZE=$(stat -f%z "$PDF_FILE" 2>/dev/null || stat -c%s "$PDF_FILE" 2>/dev/null)

        if [ "$PDF_SIZE" -gt 0 ]; then
            echo -e "${CHECK_MARK} Success"
            echo "  PDF: $PDF_FILE ($PDF_SIZE bytes)"
            ((PASSED++))
        else
            echo -e "${CROSS_MARK} PDF is empty"
            ((FAILED++))
        fi
    else
        echo -e "${CROSS_MARK} PDF not found in output/apple/"
        echo -e "  ${RED}Check build log: /tmp/build.log${NC}"
        ((FAILED++))
    fi
else
    echo -e "${CROSS_MARK} Build failed"
    echo -e "  ${RED}Check build log: /tmp/build.log${NC}"
    echo -e "  ${YELLOW}Run 'make COMPANY=apple' manually for detailed errors${NC}"
    ((FAILED++))
fi

# Summary
echo ""
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Verification Summary${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

TOTAL=$((PASSED + FAILED))

echo -e "Total checks: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"

if [ $FAILED -gt 0 ]; then
    echo -e "${RED}Failed: $FAILED${NC}"
fi

echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo ""
    echo "Your LaTeX installation is ready to use."
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
    exit 0
else
    echo -e "${RED}✗ Some checks failed${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "  1. Review error messages above"
    echo "  2. Check docs/installation/VERIFICATION.md"
    echo "  3. See docs/installation/TROUBLESHOOTING.md"
    echo ""
    echo "Quick fixes:"

    if [ $PDFLATEX_OK -ne 0 ]; then
        echo "  - Install LaTeX: See docs/installation/LINUX.md or MAC.md"
    fi

    if [ $MAKE_OK -ne 0 ]; then
        echo "  - Install make:"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "    macOS: xcode-select --install"
        else
            echo "    Linux: sudo apt-get install make (or dnf/pacman)"
        fi
    fi

    echo ""
    exit 1
fi
