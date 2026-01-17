# Usage Guide

Complete guide to using the Company-Specific Resume Generator.

## Quick Start

```bash
# 1. Set your name in Makefile (line 12) - do this once
nano Makefile  # Change NAME = Abhishek_Barat to your name

# 2. Update common files with your info
nano src/common/header.tex      # Contact information
nano src/common/education.tex   # Education
nano src/common/skills.tex      # Technical skills

# 3. Create a company configuration
./add_company.sh google

# 4. Customize the files
nano src/companies/google/google_objective.tex
nano src/companies/google/google_experience.tex

# 5. Generate the resume
make COMPANY=google

# 6. View the PDF
open output/google/Your_Name_google.pdf
```

## Configuration

### Setting Your Name (One-Time Setup)

Edit the `Makefile` at line 12:

```makefile
# IMPORTANT: Set your name here (this will be used in the output filename)
# Example: NAME = John_Doe
NAME = Your_Name
```

**Important:** Use underscores, not spaces (e.g., `John_Doe` not `John Doe`)

### Updating Common Information

Files in `src/common/` are shared across all resumes:

| File | Purpose | When to Update |
|------|---------|----------------|
| `header.tex` | Contact info (email, phone, LinkedIn) | When info changes |
| `education.tex` | Degrees and institutions | When completing degrees |
| `skills.tex` | Technical skills and tools | When learning new skills |

**Example - Updating header:**
```bash
nano src/common/header.tex
```

Changes here automatically apply to all company resumes on next build.

## Generating Resumes

### Basic Usage

```bash
make COMPANY=<company_name>
```

### Examples

```bash
# Generate resume for Apple
make COMPANY=apple

# Generate for Google
make COMPANY=google

# Generate for Amazon
make COMPANY=amazon
```

### Output Location

PDFs are generated at:
```
output/{company}/{name}_{company}.pdf
```

**Example:** If `NAME = John_Doe` in Makefile and you run `make COMPANY=google`:
- Output: `output/google/John_Doe_google.pdf`

## Creating New Company Configurations

### Method 1: Using Skeleton Template (Recommended)

Best for creating a completely custom resume from scratch:

```bash
./add_company.sh google
```

This creates:
- `src/companies/google/google_objective.tex` - Blank with documentation
- `src/companies/google/google_experience.tex` - Blank with examples

**Then customize:**
```bash
nano src/companies/google/google_objective.tex
nano src/companies/google/google_experience.tex
```

### Method 2: Using Reference Template

Best when you want a specific style (startup, enterprise, or example):

```bash
# Innovation-focused (for startups, tech companies)
./add_company.sh amazon startup

# Leadership-focused (for large corporations)
./add_company.sh microsoft enterprise

# Balanced approach
./add_company.sh facebook example
```

### Manual Process (Advanced)

If you prefer manual control:

```bash
# Copy from skeleton
cp -r src/skeleton src/companies/google

# Rename files
cd src/companies/google
mv skeleton_objective.tex google_objective.tex
mv skeleton_experience.tex google_experience.tex

# Edit files
nano google_objective.tex
nano google_experience.tex

# Generate
cd ../../..
make COMPANY=google
```

## Editing Content

### Company-Specific Content

Each company folder in `src/companies/` contains:

| File | Purpose | Content |
|------|---------|---------|
| `{company}_objective.tex` | Professional summary | Tailored to company values |
| `{company}_experience.tex` | Work experience | Emphasizes relevant achievements |

**Customization Strategy:**
- Research the company's culture and values
- Read the job posting carefully
- Emphasize relevant skills and achievements
- Use keywords from the job description

### Common Content

Files in `src/common/` appear in all resumes:

```bash
# Contact information
nano src/common/header.tex

# Education history
nano src/common/education.tex

# Technical skills
nano src/common/skills.tex
```

After editing common files, rebuild all companies to propagate changes:
```bash
for company in src/companies/*/; do
    company=$(basename "$company")
    make COMPANY="$company"
done
```

## Makefile Commands

| Command | Description | Example |
|---------|-------------|---------|
| `make COMPANY=name` | Generate resume for company | `make COMPANY=google` |
| `make clean` | Remove temporary files (keep PDFs) | `make clean` |
| `make fclean` | Delete all output including PDFs | `make fclean` |
| `make help` | Show available commands and usage | `make help` |

### Command Details

**Generate Resume:**
```bash
make COMPANY=google
# Output: output/google/Your_Name_google.pdf
```

**Clean Temporary Files:**
```bash
make clean
# Removes: .aux, .log, .out files
# Keeps: PDFs in output/
```

**Full Clean:**
```bash
make fclean
# Removes: Entire output/ directory
# Use before committing to git
```

## File Naming Rules

**CRITICAL:** Company-specific files must follow this pattern:

```
src/companies/{company}/{company}_{section}.tex
```

### Valid Examples
✅ `src/companies/google/google_objective.tex`
✅ `src/companies/amazon/amazon_experience.tex`
✅ `src/companies/microsoft/microsoft_objective.tex`

### Invalid Examples
❌ `src/companies/google/objective.tex` (missing company prefix)
❌ `src/companies/Google/google_objective.tex` (uppercase folder)
❌ `src/companies/google/google-objective.tex` (hyphen instead of underscore)
❌ `src/companies/google/googleobjective.tex` (missing underscore)

**Why?** The system uses the company name to dynamically load files. The naming pattern is required for this to work.

## Workflow Examples

### Creating Your First Resume

```bash
# 1. Initial setup (once)
nano Makefile                      # Set NAME = Your_Name
nano src/common/header.tex         # Add your contact info
nano src/common/education.tex      # Add your education
nano src/common/skills.tex         # Add your skills

# 2. Create company config
./add_company.sh google

# 3. Customize for Google
nano src/companies/google/google_objective.tex     # Tailor objective
nano src/companies/google/google_experience.tex    # Highlight relevant experience

# 4. Generate PDF
make COMPANY=google

# 5. Review
open output/google/Your_Name_google.pdf
```

### Creating Multiple Company Versions

```bash
# Create configurations for multiple companies
./add_company.sh google startup
./add_company.sh amazon startup
./add_company.sh facebook startup

# Customize each
nano src/companies/google/google_objective.tex
nano src/companies/amazon/amazon_objective.tex
nano src/companies/facebook/facebook_objective.tex

# Generate all
make COMPANY=google
make COMPANY=amazon
make COMPANY=facebook

# Or batch generate
for company in google amazon facebook; do
    make COMPANY=$company
done
```

### Updating Common Info Across All Resumes

```bash
# Update your skills
nano src/common/skills.tex

# Regenerate all company resumes
for company in src/companies/*/; do
    company=$(basename "$company")
    make COMPANY="$company"
done
```

## Troubleshooting

### "File not found" Error

**Problem:** LaTeX can't find company-specific files

**Solutions:**
1. Check folder exists: `ls src/companies/google`
2. Check file naming:
   ```bash
   ls src/companies/google/
   # Should show: google_objective.tex, google_experience.tex
   ```
3. Verify lowercase: `google` not `Google`
4. Check underscores: `google_objective.tex` not `google-objective.tex`

### PDF is More Than One Page

**Problem:** Resume exceeds one page

**Solutions:**

1. **Remove bullet points:**
   ```bash
   nano src/companies/google/google_experience.tex
   # Delete less relevant achievements
   ```

2. **Shorten text:**
   - Use abbreviations (e.g., "config" → "cfg")
   - Remove redundant words
   - Combine similar points

3. **Adjust spacing:**
   ```latex
   % Reduce space between items
   \vspace{-12pt}  % Try -14pt or -16pt
   ```

4. **Reduce experience items:**
   - Remove oldest or least relevant positions
   - Combine similar roles

### LaTeX Compilation Error

**Common errors and fixes:**

**Unmatched braces:**
```latex
% Wrong
\textbf{Title  % Missing }

% Correct
\textbf{Title}
```

**Unescaped special characters:**
```latex
% Wrong
I saved $500 and improved performance by 20%.

% Correct
I saved \$500 and improved performance by 20\%.
```

**Special characters to escape:** `$ % & _ { } # \`

**General fix:**
```bash
make clean      # Clear old build files
make COMPANY=google  # Try again
```

### Wrong Name in Output PDF

**Problem:** PDF has wrong name

**Solution:**
```bash
# Edit Makefile line 12
nano Makefile
# Change: NAME = Your_Name

# Rebuild
make COMPANY=google
```

### Changes Not Appearing in PDF

**Problem:** Edited files but PDF unchanged

**Solutions:**
```bash
# Clean build artifacts
make clean

# Rebuild
make COMPANY=google

# Or full clean + rebuild
make fclean
make COMPANY=google
```

## Advanced Usage

### Adding Custom Sections

To add a section (e.g., Publications) for specific companies:

1. **Create the file:**
   ```bash
   nano src/companies/google/google_publications.tex
   ```

2. **Add content:**
   ```latex
   \section{Publications}
   \begin{itemize}[leftmargin=0.15in, label={$\bullet$}]
       \item "Paper Title" - Conference Name, Year
       \item "Another Paper" - Journal Name, Year
   \end{itemize}
   ```

3. **Update main.tex:**
   ```bash
   nano src/main.tex
   ```
   Add before `\end{document}`:
   ```latex
   \input{src/companies/\currcompany/\currcompany_publications}
   ```

### Batch Operations

**Generate all company resumes:**
```bash
for company in src/companies/*/; do
    company=$(basename "$company")
    echo "Generating $company..."
    make COMPANY="$company"
done
```

**Clean all output:**
```bash
make fclean
```

**List all companies:**
```bash
ls src/companies/
```

### Testing Changes

**Before applying to real companies:**
```bash
# Create test company
./add_company.sh test

# Make experimental changes
nano src/companies/test/test_objective.tex

# Generate and review
make COMPANY=test
open output/test/Your_Name_test.pdf

# Delete when done
rm -rf src/companies/test output/test
```

## Tips and Best Practices

### Organization
- Keep company folders organized by industry or role type
- Use consistent naming (all lowercase, no spaces)
- Document customizations in comments within tex files

### Efficiency
- Set up common files once, customize per company
- Use templates as starting points
- Batch generate when updating common sections

### Quality
- Always review PDF before submission
- Check for typos and formatting
- Verify contact information is current
- Ensure PDF is exactly one page

### Version Control
- Commit company configs to git
- Don't commit output/ directory (gitignored)
- Review changes before committing personal info

## Pro Tips

### Quick Company Creation and Generation
```bash
./add_company.sh google && make COMPANY=google
```

### Compare Multiple Versions Side by Side
```bash
make COMPANY=startup
make COMPANY=enterprise
open output/startup/Your_Name_startup.pdf output/enterprise/Your_Name_enterprise.pdf
```

### Find All Companies
```bash
ls src/companies/
```

### Check Last Generated PDFs
```bash
ls -lt output/*/Your_Name_*.pdf | head -5
```

### Quick Edit Workflow
```bash
# Edit → Generate → View in one command
nano src/companies/google/google_objective.tex && make COMPANY=google && open output/google/Your_Name_google.pdf
```
