#!/bin/bash
# =============================================================================
# test-build.sh - Quick build test for CV Resume Repository
# =============================================================================
# USAGE:
#   ./scripts/test-build.sh
#
# WHAT IT DOES:
#   1. Cleans previous build
#   2. Builds resume for COMPANY=apple
#   3. Checks if PDF was generated
#   4. Reports pass/fail
#
# EXIT CODES:
#   0 - Build successful
#   1 - Build failed
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Find repository root
REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}Quick Build Test${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

cd "$REPO_ROOT"

# Clean previous build
echo -e "${BLUE}Cleaning previous build...${NC}"
make clean > /dev/null 2>&1 || true

# Build
echo -e "${BLUE}Building resume (COMPANY=apple)...${NC}"
echo ""

if make COMPANY=apple; then
    echo ""
    echo -e "${BLUE}Checking output...${NC}"

    # Check if PDF exists
    if [ -f output/apple/*_apple.pdf ]; then
        PDF_FILE=$(ls output/apple/*_apple.pdf | head -n 1)
        PDF_SIZE=$(stat -f%z "$PDF_FILE" 2>/dev/null || stat -c%s "$PDF_FILE" 2>/dev/null)

        if [ "$PDF_SIZE" -gt 0 ]; then
            echo -e "${GREEN}✓ Build successful!${NC}"
            echo ""
            echo "PDF generated:"
            echo "  Location: $PDF_FILE"
            echo "  Size: $PDF_SIZE bytes"
            echo ""
            exit 0
        else
            echo -e "${RED}✗ Build failed${NC}"
            echo "  PDF file is empty (0 bytes)"
            echo ""
            exit 1
        fi
    else
        echo -e "${RED}✗ Build failed${NC}"
        echo "  PDF not found in output/apple/"
        echo ""
        exit 1
    fi
else
    echo ""
    echo -e "${RED}✗ Build failed${NC}"
    echo ""
    echo "Check error messages above for details."
    echo ""
    echo "Troubleshooting:"
    echo "  - Ensure LaTeX is installed: pdflatex --version"
    echo "  - Ensure make is installed: make --version"
    echo "  - Check docs/installation/VERIFICATION.md"
    echo "  - See docs/installation/TROUBLESHOOTING.md"
    echo ""
    exit 1
fi
