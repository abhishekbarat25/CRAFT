# Quick Start Guide

Get up and running with the Company-Specific Resume Generator in 10 minutes.

## Prerequisites

- LaTeX distribution installed (TeX Live, MiKTeX, or MacTeX)
- `pdflatex` command available
- `make` utility
- Text editor (nano, vim, VSCode, etc.)

**Test your setup:**
```bash
pdflatex --version
make --version
```

---

## 5-Minute Setup

### Step 1: Configure Your Name (30 seconds)

```bash
nano Makefile
```

Change line 12:
```makefile
NAME = Abhishek_Barat    # Change to your name (use underscores)
```

Save and exit (Ctrl+X, Y, Enter in nano).

### Step 2: Update Your Info (3 minutes)

```bash
# Contact information
nano src/common/header.tex
```

Update:
- Your full name
- Email address
- Phone number
- LinkedIn URL
- Location

```bash
# Education
nano src/common/education.tex
```

Add your degrees using `\educationItem` command.

```bash
# Skills
nano src/common/skills.tex
```

List your technical skills by category.

### Step 3: Test the System (1 minute)

```bash
# Generate the existing example (apple)
make COMPANY=apple

# View the PDF
open output/apple/Your_Name_apple.pdf  # macOS
# xdg-open output/apple/Your_Name_apple.pdf  # Linux
# start output/apple/Your_Name_apple.pdf  # Windows
```

**✅ If you see a PDF, you're ready to go!**

---

## Creating Your First Resume (5 minutes)

### Step 1: Create Company Configuration (10 seconds)

```bash
./add_company.sh google
```

This creates:
- `src/companies/google/google_objective.tex`
- `src/companies/google/google_experience.tex`

### Step 2: Write Your Objective (2 minutes)

```bash
nano src/companies/google/google_objective.tex
```

Replace the placeholder with your own objective. Keep it to 2-4 lines.

**Template:**
```latex
\section{Objective}
\noindent [Your Role] with [X]+ years of experience in [Your Field]
seeking opportunities to [Value You Bring] at [Target Company].
```

**Example:**
```latex
\section{Objective}
\noindent Software Engineer with 6+ years building scalable web applications
seeking to develop innovative products that impact millions of users.
```

### Step 3: Add Your Experience (3 minutes)

```bash
nano src/companies/google/google_experience.tex
```

Replace placeholders with your actual work experience.

**Format:**
```latex
\experienceItem{Job Title}{Company, Location}{Start -- End}
\vspace{-8pt}
\begin{itemize}[leftmargin=0.15in, label={$\bullet$}]
    \item Your first achievement with metrics
    \vspace{-8pt}
    \item Your second achievement
    \vspace{-8pt}
\end{itemize}
```

### Step 4: Generate (5 seconds)

```bash
make COMPANY=google
```

### Step 5: Review

```bash
open output/google/Your_Name_google.pdf
```

**Check:**
- Is it one page? ✓
- Is all info correct? ✓
- No typos? ✓

---

## Using Templates

Instead of starting from scratch, use a pre-filled template:

```bash
# For startups/tech companies (emphasizes innovation)
./add_company.sh amazon startup

# For large enterprises (emphasizes leadership/scale)
./add_company.sh microsoft enterprise

# For balanced approach
./add_company.sh facebook example
```

Then customize:
```bash
nano src/companies/amazon/amazon_objective.tex
nano src/companies/amazon/amazon_experience.tex
make COMPANY=amazon
```

---

## Common Commands

| What You Want | Command |
|---------------|---------|
| Create new company | `./add_company.sh companyname` |
| Generate resume | `make COMPANY=companyname` |
| Clean temp files | `make clean` |
| Delete all output | `make fclean` |
| View all companies | `ls src/companies/` |
| Get help | `make help` |

---

## Quick Customization Workflow

**For each new company application:**

```bash
# 1. Create
./add_company.sh newcompany

# 2. Customize objective (5 min)
nano src/companies/newcompany/newcompany_objective.tex

# 3. Tailor experience (10 min)
nano src/companies/newcompany/newcompany_experience.tex

# 4. Generate
make COMPANY=newcompany

# 5. Review and refine
open output/newcompany/Your_Name_newcompany.pdf
# If changes needed, edit and regenerate
nano src/companies/newcompany/newcompany_objective.tex
make COMPANY=newcompany
```

---

## Troubleshooting

### Problem: "pdflatex: command not found"

**Solution:** Install LaTeX

See our comprehensive **[Installation Guide](INSTALLATION.md)** with automated scripts and detailed instructions for all platforms.

**Quick install:**
- **Linux:** `./scripts/install-latex-linux.sh`
- **macOS:** `./scripts/install-latex-mac.sh`
- **Windows:** `.\scripts\install-latex-windows.bat`

**Or manual installation:**
- [Linux Guide](installation/LINUX.md) - Ubuntu, Fedora, Arch, openSUSE
- [macOS Guide](installation/MAC.md) - Homebrew, MacTeX, MacPorts
- [Windows Guide](installation/WINDOWS.md) - MiKTeX, TeX Live, Chocolatey

**After installation:**
- [Verify your setup](installation/VERIFICATION.md)
- Return here to continue with Step 3

### Problem: PDF is more than one page

**Solution:** Remove bullet points or shorten text:
```bash
nano src/companies/google/google_experience.tex
# Delete 1-2 bullet points
make COMPANY=google
```

### Problem: Changes not showing up

**Solution:** Clean and rebuild:
```bash
make clean
make COMPANY=google
```

### Problem: LaTeX compilation error

**Solution:** Check for unmatched braces `{}` or unescaped special characters.

**Common fixes:**
- `$` → `\$`
- `%` → `\%`
- `&` → `\&`
- `_` → `\_`

---

## Pro Tips

### Tip 1: Batch Create Multiple Companies

```bash
for company in google amazon microsoft apple; do
    ./add_company.sh $company startup
done
```

### Tip 2: Quick Edit and Regenerate

```bash
nano src/companies/google/google_objective.tex && make COMPANY=google
```

### Tip 3: Compare Templates

```bash
make COMPANY=apple        # Uses existing apple config
./add_company.sh test startup
make COMPANY=test
open output/apple/Your_Name_apple.pdf output/test/Your_Name_test.pdf
```

### Tip 4: Update All Resumes After Skill Change

```bash
nano src/common/skills.tex  # Update skills
for company in src/companies/*/; do
    make COMPANY=$(basename "$company")
done
```

---

## File Organization

```
src/
├── common/           ← Edit once, applies to all
│   ├── header.tex    ← Your contact info
│   ├── education.tex ← Your education
│   └── skills.tex    ← Your technical skills
│
├── companies/        ← One folder per company
│   └── google/
│       ├── google_objective.tex    ← Customize per company
│       └── google_experience.tex   ← Customize per company
│
├── skeleton/         ← Template for new companies
└── templates/        ← Reference examples
    ├── example/
    ├── startup/
    └── enterprise/
```

---

## What's Next?

**Just Starting:**
1. Complete the 5-minute setup above
2. Test with one company
3. Read [WORKFLOW.md](WORKFLOW.md) for detailed process

**Ready to Apply:**
1. Research target companies
2. Create configurations using `./add_company.sh`
3. Customize objective and experience
4. Generate and review PDFs

**Need Help:**
- [USAGE_GUIDE.md](USAGE_GUIDE.md) - Complete command reference
- [WORKFLOW.md](WORKFLOW.md) - Step-by-step process
- [EXAMPLES.md](EXAMPLES.md) - Template comparisons
- [ARCHITECTURE.md](ARCHITECTURE.md) - System design details

---

## Remember

- **One page only:** Resumes must fit on one page
- **Tailor everything:** Customize objective and experience for each company
- **Use keywords:** Mirror language from job descriptions
- **Quantify impact:** Use numbers and percentages
- **Proofread carefully:** No typos

---

## Example Session

Here's a complete example from start to finish:

```bash
# Initial setup (first time only)
nano Makefile                      # Set NAME = John_Doe
nano src/common/header.tex         # Add contact info
nano src/common/education.tex      # Add education
nano src/common/skills.tex         # Add skills

# Create company config
./add_company.sh google

# Customize
nano src/companies/google/google_objective.tex     # 5 min
nano src/companies/google/google_experience.tex    # 10 min

# Generate
make COMPANY=google

# Review
open output/google/John_Doe_google.pdf

# Refine if needed
nano src/companies/google/google_experience.tex
make COMPANY=google
open output/google/John_Doe_google.pdf

# Done! Submit your application ✓
```

---

**Total time:** 10-20 minutes per company after initial setup.

Good luck with your job search! 🚀
