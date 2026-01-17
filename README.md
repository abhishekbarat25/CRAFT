# Company-Specific Resume Generator

A LaTeX-based system for generating tailored resumes with a single command. Create company-specific versions of your resume that emphasize different skills and experiences based on what each company values.

## Features

- **One Command Build**: Generate a tailored resume with `make COMPANY=name`
- **Folder-Based Organization**: Each company gets its own configuration folder
- **Shared Content**: Common sections (education, skills) managed in one place
- **Skeleton Template**: Comprehensive template with documentation for creating new resumes
- **Reference Examples**: Startup, enterprise, and example-focused templates included
- **Helper Script**: Quickly create new company configurations

## Quick Start

```bash
# Generate a resume using an existing company configuration
make COMPANY=apple

# Create a new company configuration from skeleton template
./add_company.sh google

# Generate resume for the new company
make COMPANY=google

# Use a reference template (startup/enterprise/example)
./add_company.sh amazon startup
make COMPANY=amazon
```

Output: `output/{company}/{name}_{company}.pdf`

## First-Time Setup

Before generating resumes:

1. **Set your name** in `Makefile` (line 12):
   ```makefile
   NAME = Your_Name
   ```

2. **Update common content** (applies to all resumes):
   - `src/common/header.tex` - Contact information
   - `src/common/education.tex` - Education section
   - `src/common/skills.tex` - Technical skills

3. **Create company configurations** as needed

## Directory Structure

```
.
├── Makefile              # Build automation
├── resume.cls            # Resume styling
├── add_company.sh        # Helper script
│
├── src/
│   ├── main.tex          # Main LaTeX document
│   ├── common/           # Shared content (all companies)
│   │   ├── header.tex    # Contact information
│   │   ├── education.tex # Education section
│   │   └── skills.tex    # Technical skills
│   │
│   ├── companies/        # Your company-specific resumes
│   │   └── apple/        # Example company configuration
│   │
│   ├── skeleton/         # Blank template with documentation
│   │   ├── skeleton_objective.tex
│   │   └── skeleton_experience.tex
│   │
│   └── templates/        # Reference templates
│       ├── example/      # Balanced template
│       ├── startup/      # Innovation-focused
│       └── enterprise/   # Leadership-focused
│
├── docs/                 # Documentation
│
└── output/               # Generated PDFs (gitignored)
```

## How It Works

1. **Common files** in `src/common/` contain shared content (contact info, education, skills)
2. **Company folders** in `src/companies/` contain customized objective statements and experience sections
3. The **Makefile** passes the company name to LaTeX, which dynamically loads the right files
4. **NAME** is set once in the Makefile and used for all output filenames

## Adding a New Company

### Using the Helper Script (Recommended)

```bash
# Create from skeleton template (blank with documentation)
./add_company.sh google

# Or copy from a reference template
./add_company.sh amazon startup    # Innovation-focused
./add_company.sh microsoft enterprise  # Leadership-focused
```

### Manual Process

```bash
cp -r src/skeleton src/companies/google
cd src/companies/google
mv skeleton_objective.tex google_objective.tex
mv skeleton_experience.tex google_experience.tex
# Edit the files, then:
cd ../../..
make COMPANY=google
```

## Templates

| Template | Location | Focus | Best For |
|----------|----------|-------|----------|
| `skeleton` | `src/skeleton/` | Documentation | Starting from scratch (default) |
| `example` | `src/templates/` | Balanced | General use, placeholders |
| `startup` | `src/templates/` | Innovation | Startups, tech companies, R&D roles |
| `enterprise` | `src/templates/` | Leadership | Large corporations, management roles |

The skeleton template includes comprehensive inline documentation to guide you through creating each section.

## Requirements

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- `pdflatex` command
- `make` utility

### Installation

New to LaTeX? See our **[Installation Guide](docs/INSTALLATION.md)** for:
- Automated one-command installation scripts
- Detailed platform-specific guides (Linux, macOS, Windows)
- Troubleshooting and verification steps

**Quick install:**
- **Linux:** `./scripts/install-latex-linux.sh`
- **macOS:** `./scripts/install-latex-mac.sh`
- **Windows:** `.\scripts\install-latex-windows.bat`

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make COMPANY=name` | Generate resume for specified company |
| `make clean` | Remove temp files, keep PDFs |
| `make fclean` | Delete all output including PDFs |
| `make help` | Show available commands |

**Note**: The NAME variable is set in the Makefile itself (line 12), not passed as a command-line parameter.

## Documentation

- [Usage Guide](docs/USAGE_GUIDE.md) - Complete command reference
- [Workflow](docs/WORKFLOW.md) - Step-by-step company creation process
- [Architecture](docs/ARCHITECTURE.md) - System design and extension points
- [Examples](docs/EXAMPLES.md) - Template comparison and customization tips
- [Contributing](CONTRIBUTING.md) - How to contribute
- [CLAUDE.md](CLAUDE.md) - Documentation for Claude Code AI assistant

## Workflow

1. **One-time setup**:
   - Set NAME in Makefile
   - Update common files (header, education, skills)

2. **For each company**:
   - Run `./add_company.sh company_name [template]`
   - Edit `src/companies/company_name/company_name_objective.tex` - Tailor to company values
   - Edit `src/companies/company_name/company_name_experience.tex` - Highlight relevant experience
   - Run `make COMPANY=company_name`
   - Review PDF at `output/company_name/{name}_company_name.pdf`

3. **Iterate**:
   - Adjust spacing, bullet points, and content
   - Rebuild with `make COMPANY=company_name`

## Tips for Customization

- **For Startups**: Emphasize innovation, full-stack capabilities, rapid development
- **For Enterprise**: Emphasize scale, reliability, process, compliance
- **For Specific Tech**: Mirror their tech stack in your skills and experience
- **Spacing**: Use `\vspace{-Xpt}` to adjust whitespace and fit to one page

## File Naming Convention

Files must follow the pattern: `src/companies/{company}/{company}_{section}.tex`

**Valid**: `src/companies/google/google_objective.tex`
**Invalid**: `src/companies/google/objective.tex` (missing company prefix)

## License

MIT License - Feel free to adapt for your own use.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.
