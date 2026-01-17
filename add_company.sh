#!/bin/bash
# =============================================================================
# add_company.sh - Create a new company configuration
# =============================================================================
# USAGE:
#   ./add_company.sh <new_company>              # Uses 'skeleton' template
#   ./add_company.sh <new_company> <template>   # Uses specified template
#
# EXAMPLES:
#   ./add_company.sh google                     # Create from skeleton
#   ./add_company.sh amazon startup             # Create from startup template
#   ./add_company.sh tesla enterprise           # Create from enterprise template
#
# WHAT IT DOES:
#   1. Creates a new folder in src/companies/<new_company>/
#   2. Copies template files from src/skeleton/ or src/templates/<template>/
#   3. Renames files to match the company name pattern
#   4. Provides next steps for customization
#
# TEMPLATES:
#   - skeleton: Blank template with comprehensive documentation (default)
#   - example: Balanced template with placeholder examples
#   - startup: Innovation-focused template
#   - enterprise: Leadership-focused template
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Show usage
usage() {
    echo -e "${BLUE}Company-Specific Resume Generator - Add New Company${NC}"
    echo ""
    echo "Usage: ./add_company.sh <new_company> [template]"
    echo ""
    echo "Arguments:"
    echo "  new_company    Name for the new company (lowercase, no spaces)"
    echo "  template       Source template to copy from (default: skeleton)"
    echo ""
    echo "Examples:"
    echo "  ./add_company.sh google             # Uses 'skeleton' template (recommended)"
    echo "  ./add_company.sh amazon startup     # Uses 'startup' template"
    echo "  ./add_company.sh tesla enterprise   # Uses 'enterprise' template"
    echo ""
    echo "Available templates:"
    echo "  skeleton    - Blank template with detailed documentation (default)"
    echo "  example     - Balanced template with placeholder content"
    echo "  startup     - Innovation and R&D focused"
    echo "  enterprise  - Leadership and scale focused"
    exit 1
}

# Check arguments
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    usage
fi

NEW_COMPANY=$1
TEMPLATE=${2:-skeleton}  # Default to 'skeleton' if not specified

# Validate company name (lowercase, alphanumeric, no spaces)
if [[ ! "$NEW_COMPANY" =~ ^[a-z0-9]+$ ]]; then
    echo -e "${RED}Error: Company name must be lowercase alphanumeric (no spaces or special characters)${NC}"
    echo "Example: google, amazon, microsoft"
    exit 1
fi

# Determine source path based on template
if [ "$TEMPLATE" = "skeleton" ]; then
    SOURCE_PATH="src/skeleton"
    SOURCE_PREFIX="skeleton"
else
    SOURCE_PATH="src/templates/$TEMPLATE"
    SOURCE_PREFIX="$TEMPLATE"
fi

# Check if template exists
if [ ! -d "$SOURCE_PATH" ]; then
    echo -e "${RED}Error: Template '$TEMPLATE' does not exist${NC}"
    echo ""
    echo "Available templates:"
    echo "  skeleton (in src/skeleton/)"
    echo "  example, startup, enterprise (in src/templates/)"
    exit 1
fi

# Check if new company already exists
if [ -d "src/companies/$NEW_COMPANY" ]; then
    echo -e "${RED}Error: Company '$NEW_COMPANY' already exists in src/companies/${NC}"
    echo "Delete it first if you want to recreate: rm -rf src/companies/$NEW_COMPANY"
    exit 1
fi

echo -e "${GREEN}Creating new company configuration: $NEW_COMPANY${NC}"
echo "Template: $TEMPLATE"
echo ""

# Step 1: Copy template
echo "1. Copying template files..."
cp -r "$SOURCE_PATH" "src/companies/$NEW_COMPANY"

# Step 2: Rename files
echo "2. Renaming files..."
cd "src/companies/$NEW_COMPANY"
for file in ${SOURCE_PREFIX}_*.tex; do
    if [ -f "$file" ]; then
        new_file=$(echo "$file" | sed "s/${SOURCE_PREFIX}/${NEW_COMPANY}/")
        mv "$file" "$new_file"
        echo "   $file -> $new_file"
    fi
done
cd ../../..

# Step 3: Show success and next steps
echo ""
echo -e "${GREEN}✓ Success! Created: src/companies/$NEW_COMPANY/${NC}"
echo ""
echo -e "${YELLOW}Files created:${NC}"
ls -1 "src/companies/$NEW_COMPANY/"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo ""
echo "  1. Edit the objective statement:"
echo -e "     ${BLUE}nano src/companies/$NEW_COMPANY/${NEW_COMPANY}_objective.tex${NC}"
echo ""
echo "  2. Customize work experience:"
echo -e "     ${BLUE}nano src/companies/$NEW_COMPANY/${NEW_COMPANY}_experience.tex${NC}"
echo ""
echo "  3. Update common files (if needed):"
echo -e "     ${BLUE}nano src/common/header.tex     # Contact information${NC}"
echo -e "     ${BLUE}nano src/common/education.tex  # Education section${NC}"
echo -e "     ${BLUE}nano src/common/skills.tex     # Technical skills${NC}"
echo ""
echo "  4. Generate your resume:"
echo -e "     ${BLUE}make COMPANY=$NEW_COMPANY${NC}"
echo ""
echo "  5. View the PDF:"
echo -e "     ${BLUE}open output/$NEW_COMPANY/Abhishek_Barat_${NEW_COMPANY}.pdf${NC}"
echo "     (Change 'Abhishek_Barat' in Makefile line 12 to your name)"
echo ""
echo -e "${GREEN}Happy customizing!${NC}"
