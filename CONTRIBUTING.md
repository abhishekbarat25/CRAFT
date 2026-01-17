# Contributing Guide

Guidelines for contributing to the Company-Specific Resume Generator.

## Adding a New Company Configuration

### Method 1: Using the Helper Script (Recommended)

```bash
./add_company.sh mycompany
```

This will:
1. Copy the example template
2. Rename files automatically
3. Show you the next steps

### Method 2: Manual Process

```bash
# Copy template
cp -r src/example src/mycompany

# Rename files
cd src/mycompany
mv example_objective.tex mycompany_objective.tex
mv example_experience.tex mycompany_experience.tex

# Edit content
nano mycompany_objective.tex
nano mycompany_experience.tex

# Test build
cd ../..
make COMPANY=mycompany NAME=Your_Name
```

### Choosing a Template

You can copy from an existing template that matches your target:

| Target Type | Copy From |
|-------------|-----------|
| General/Balanced | `example` |
| Startups, tech, R&D | `startup` |
| Large corporations, management | `enterprise` |

```bash
./add_company.sh mycompany startup
```

## Editing Common Files

Common files affect **all** company resumes.

```bash
nano src/common/header.tex     # Contact information
nano src/common/education.tex  # Education section
nano src/common/skills.tex     # Technical skills
```

After editing common files, regenerate all resumes to verify changes.

## File Naming Convention

All company-specific files must follow this pattern:

```
src/{company}/{company}_{filename}.tex
```

### Valid Examples

- `src/google/google_objective.tex`
- `src/google/google_experience.tex`

### Invalid Examples

- `src/google/objective.tex` (missing company prefix)
- `src/Google/google_objective.tex` (wrong case in folder name)

## Testing Changes

### Test Single Company

```bash
make COMPANY=mycompany NAME=Test_User
```

### Test All Templates

```bash
for company in example startup enterprise; do
    echo "Building $company..."
    make COMPANY=$company NAME=Test_User
done
```

### Verify PDFs

Check that all PDFs:
- Are exactly 1 page
- Have correct naming
- Compile without errors

## Pull Request Guidelines

1. **Test your changes** before submitting
2. **Don't commit PDFs** - they are gitignored
3. **Follow naming conventions** - lowercase, underscores
4. **Update documentation** if adding major features
5. **Keep it clean** - no commented-out code in final submissions

## Style Guidelines

### Bullet Points

- Start with strong action verbs
- Include quantifiable results when possible
- Keep under 2 lines when compiled

**Good:**
```latex
\item Led development of API serving 10M+ requests daily with 99.9\% uptime.
```

**Bad:**
```latex
\item Worked on API development and achieved good results.
```

### Special Characters

Always escape these characters in LaTeX:
- Dollar sign: `\$`
- Percent: `\%`
- Ampersand: `\&`
- Underscore in text: `\_`

## Documentation

- [docs/USAGE_GUIDE.md](docs/USAGE_GUIDE.md) - Command reference
- [docs/WORKFLOW.md](docs/WORKFLOW.md) - Step-by-step process
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) - System design
- [docs/EXAMPLES.md](docs/EXAMPLES.md) - Template comparisons

## Questions?

Open an issue on GitHub with:
- What you're trying to do
- What error you're seeing
- Steps to reproduce
