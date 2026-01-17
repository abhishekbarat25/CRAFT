# System Architecture

Technical documentation for the Company-Specific Resume Generator.

## Overview

A LaTeX-based system that generates company-tailored resumes using a folder-based architecture with clear separation between working files, templates, and shared content.

### Key Principles

1. **Folder = Company** - Each company has its own folder in `src/companies/`
2. **Separation of Concerns** - Common vs company-specific vs template content
3. **Single Command Build** - `make COMPANY=name` (NAME set in Makefile)
4. **No Conditional Logic** - Clean LaTeX files with dynamic loading
5. **Template Hierarchy** - Skeleton → Reference Templates → Active Companies

## Directory Structure

```
.
├── Makefile                    # Build automation
├── resume.cls                  # LaTeX resume class (styling)
├── add_company.sh              # Helper script for creating companies
│
├── src/
│   ├── main.tex                # Main document (orchestrates loading)
│   │
│   ├── common/                 # Shared content (ALL companies)
│   │   ├── header.tex          # Contact information
│   │   ├── education.tex       # Education section
│   │   └── skills.tex          # Technical skills
│   │
│   ├── companies/              # ACTIVE company configurations
│   │   └── {company}/          # One folder per company
│   │       ├── {company}_objective.tex
│   │       └── {company}_experience.tex
│   │
│   ├── skeleton/               # BLANK template (default for new companies)
│   │   ├── skeleton_objective.tex    # With comprehensive documentation
│   │   └── skeleton_experience.tex   # With usage examples
│   │
│   └── templates/              # REFERENCE templates (read-only examples)
│       ├── example/            # Balanced template
│       ├── startup/            # Innovation-focused
│       └── enterprise/         # Leadership-focused
│
├── docs/                       # Documentation
│
└── output/                     # Generated PDFs (gitignored)
    └── {company}/
        ├── {name}_{company}.pdf
        └── internals/          # Build artifacts
```

## Core Components

### src/main.tex

The central document that orchestrates dynamic loading:

```latex
\documentclass{resume}
\providecommand{\currcompany}{apple}  % Default company

\begin{document}
% Common content (same for all companies)
\input{src/common/header}
\input{src/common/education}
\input{src/common/skills}

% Company-specific content (dynamically loaded)
\input{src/companies/\currcompany/\currcompany_objective}
\input{src/companies/\currcompany/\currcompany_experience}
\end{document}
```

**Key Features:**
- Uses `\currcompany` variable for dynamic file loading
- Loads common files from `src/common/`
- Loads company-specific files from `src/companies/{company}/`
- Default fallback to 'apple' if COMPANY not specified

### Makefile

Handles build automation with minimal user input:

```makefile
# User configures once
NAME = Abhishek_Barat

# User specifies per build
COMPANY ?= apple

pdf:
    # Run 1: Generate auxiliary files
    pdflatex -jobname=$(NAME)_$(COMPANY) \
        "\def\currcompany{$(COMPANY)}\input{src/main.tex}"

    # Run 2: Resolve references
    pdflatex -jobname=$(NAME)_$(COMPANY) \
        "\def\currcompany{$(COMPANY)}\input{src/main.tex}"

    # Copy to output folder
    cp output/$(COMPANY)/internals/$(NAME)_$(COMPANY).pdf \
       output/$(COMPANY)/
```

**Key Features:**
- NAME set once in Makefile (line 12)
- COMPANY passed via command line
- Two-pass compilation for references
- Stores build artifacts in `internals/` subfolder
- Final PDF copied to company folder

### resume.cls

Custom LaTeX class defining document styling:

```latex
\LoadClass[11pt,letterpaper]{article}
\usepackage[left=0.5in, top=0.5in, right=0.5in, bottom=0.5in]{geometry}

% Custom command for experience items
\newcommand{\experienceItem}[3]{
  \noindent\textbf{#1} \hfill #2 \hfill \textit{#3}
}

% Custom command for education items
\newcommand{\educationItem}[4]{
  \noindent\textbf{#1} \hfill #2 \\
  \noindent{#3} \hfill {#4}
}
```

**Key Features:**
- 11pt font on letter-size paper
- 0.5 inch margins (all sides)
- Section formatting with horizontal rules
- Custom commands for consistent formatting
- No page numbers (`\pagenumbering{gobble}`)

### add_company.sh

Helper script for creating new company configurations:

**Features:**
- Validates company name (lowercase alphanumeric)
- Copies from skeleton (default) or reference templates
- Renames files to match company name
- Checks for existing companies
- Provides next-step instructions

**Usage:**
```bash
./add_company.sh google              # From skeleton
./add_company.sh amazon startup      # From startup template
```

## Build Process Flow

```
┌─────────────────┐
│ make COMPANY=X  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Makefile reads │
│  NAME variable  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Pass variables │
│  to pdflatex    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   main.tex      │
│   loads files   │
└────────┬────────┘
         │
         ├──► src/common/header.tex
         ├──► src/common/education.tex
         ├──► src/common/skills.tex
         ├──► src/companies/X/X_objective.tex
         └──► src/companies/X/X_experience.tex
         │
         ▼
┌─────────────────┐
│  PDF generated  │
│  in output/X/   │
└─────────────────┘
```

## Dynamic Loading Mechanism

The system uses LaTeX's variable substitution for dynamic file loading:

```latex
% In Makefile:
"\def\currcompany{google}\input{src/main.tex}"

% In main.tex:
\input{src/companies/\currcompany/\currcompany_objective}

% Expands to:
\input{src/companies/google/google_objective}
```

**Why This Works:**
1. Makefile defines `\currcompany` variable
2. LaTeX expands `\currcompany` before loading files
3. File path dynamically constructed
4. No conditional logic needed in LaTeX

## File Naming Convention

**CRITICAL:** Files must follow this exact pattern:

```
src/companies/{company}/{company}_{section}.tex
```

The double occurrence of `{company}` is **required** for dynamic loading.

**Valid Examples:**
- `src/companies/google/google_objective.tex` ✓
- `src/companies/amazon/amazon_experience.tex` ✓

**Invalid Examples:**
- `src/companies/google/objective.tex` ✗ (missing prefix)
- `src/companies/Google/google_objective.tex` ✗ (wrong case)
- `src/companies/google/google-objective.tex` ✗ (hyphen, not underscore)

## Template Hierarchy

### Level 1: Skeleton (src/skeleton/)
- **Purpose:** Starting point for new companies
- **Content:** Blank with comprehensive documentation
- **Usage:** Default template for `./add_company.sh`
- **Audience:** Users creating from scratch

### Level 2: Reference Templates (src/templates/)
- **Purpose:** Pre-filled examples showing different styles
- **Content:** Complete resumes with placeholder data
- **Usage:** Copy when you want a specific style
- **Audience:** Users who want inspiration

### Level 3: Active Companies (src/companies/)
- **Purpose:** Your actual company-specific resumes
- **Content:** Tailored content for each company
- **Usage:** Generated PDFs from these
- **Audience:** End result for applications

## Extension Points

### Adding Company-Specific Sections

To add a new section (e.g., publications):

1. Create file in company folder:
   ```bash
   touch src/companies/google/google_publications.tex
   ```

2. Add content:
   ```latex
   \section{Publications}
   \item Paper 1
   \item Paper 2
   ```

3. Update main.tex:
   ```latex
   \input{src/companies/\currcompany/\currcompany_publications}
   ```

### Adding Common Sections

For sections shared across all companies:

1. Create file:
   ```bash
   touch src/common/certifications.tex
   ```

2. Add content:
   ```latex
   \section{Certifications}
   \item AWS Certified Solutions Architect
   ```

3. Update main.tex:
   ```latex
   \input{src/common/certifications}
   ```

### Customizing Styling

Edit `resume.cls` to modify:

**Margins:**
```latex
\usepackage[left=0.75in, top=0.75in, right=0.75in, bottom=0.75in]{geometry}
```

**Font size:**
```latex
\LoadClass[10pt,letterpaper]{article}  % Smaller
\LoadClass[12pt,letterpaper]{article}  % Larger
```

**Section formatting:**
```latex
\titleformat{\section}{\Large\bfseries}{}{0pt}{}[\titlerule]
```

## Maintenance Tasks

### Adding New Company

```bash
./add_company.sh newcompany
nano src/companies/newcompany/newcompany_objective.tex
nano src/companies/newcompany/newcompany_experience.tex
make COMPANY=newcompany
```

### Updating All Companies

When you update `src/common/` files, regenerate all resumes:

```bash
for company in src/companies/*/; do
    company=$(basename $company)
    make COMPANY=$company
done
```

### Cleaning Build Artifacts

```bash
make clean    # Remove .aux, .log (keep PDFs)
make fclean   # Remove entire output/ directory
```

## Design Decisions

### Why Folder-Based Instead of Config Files?
- Simpler: Each company is self-contained
- Clearer: Easy to see all companies at a glance
- Version control friendly: Clean diffs per company

### Why Two LaTeX Passes?
- First pass: Generate auxiliary files (.aux)
- Second pass: Resolve references and finalize
- Standard LaTeX practice for complex documents

### Why Separate templates/ and companies/?
- Templates are read-only references
- Companies are working directories
- Prevents accidental template modification
- Clear mental model for users

### Why NAME in Makefile Instead of CLI?
- Set once, use many times
- Avoids repetitive typing
- Simpler command: `make COMPANY=X` vs `make COMPANY=X NAME=Y`
- NAME rarely changes, COMPANY changes frequently

## Common Patterns

### Creating Multiple Company Versions Quickly

```bash
# Create multiple companies from same template
for company in google amazon microsoft; do
    ./add_company.sh $company startup
done

# Customize each
for company in google amazon microsoft; do
    # Open in editor and make company-specific changes
    nano src/companies/$company/${company}_objective.tex
done

# Generate all
for company in google amazon microsoft; do
    make COMPANY=$company
done
```

### Testing Template Changes

```bash
# Edit template
nano src/templates/startup/startup_objective.tex

# Test by creating a company from it
./add_company.sh testcompany startup
make COMPANY=testcompany

# Review and delete if not needed
rm -rf src/companies/testcompany
```

## Technical Constraints

### LaTeX Limitations
- Variable expansion happens at compile time
- Cannot use runtime conditionals efficiently
- File paths must be known at compile time
- Hence the strict naming convention

### Makefile Constraints
- Variables must be defined before use
- `?=` allows command-line override
- Shell commands run in subshell (use `&&` for sequences)

### File System Requirements
- Case-sensitive file systems work best
- Lowercase naming prevents issues
- No spaces in company names (LaTeX limitation)

## Performance Considerations

- **Two-pass compilation:** ~2-4 seconds per resume
- **Batch generation:** Linear scaling (O(n) for n companies)
- **Disk usage:** ~50KB per PDF, ~10KB per company config
- **Build artifacts:** Stored in internals/ to avoid clutter

## Security Considerations

- **Output directory gitignored:** Prevents committing PDFs with personal info
- **Template files:** Safe to commit (no personal data)
- **Common files:** Review before committing (contains contact info)
- **Helper scripts:** Standard bash, no external dependencies
