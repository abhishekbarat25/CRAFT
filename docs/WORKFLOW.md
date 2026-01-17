# Workflow Guide

Complete step-by-step workflow for creating and maintaining company-specific resumes.

## Workflow Overview

```
Initial Setup → Create Company → Customize → Generate → Review → Update → Regenerate
     ↓              ↓              ↓            ↓         ↓        ↓          ↓
  (Once)      (Per company)  (Research) (Build PDF) (QA)  (Edit) (Rebuild)
```

---

## Phase 1: Initial Setup (One-Time)

Perform these steps once when first using the system.

### Step 1.1: Configure Your Name

Edit the Makefile to set your name:

```bash
nano Makefile
```

Find line 12 and update:
```makefile
NAME = Your_Name    # Change this to your name (use underscores for spaces)
```

**Example:**
```makefile
NAME = John_Doe
```

### Step 1.2: Update Contact Information

```bash
nano src/common/header.tex
```

Update with your details:
```latex
\begin{center}
    {\Large \textbf{Your Full Name}} \\
    \href{mailto:your.email@example.com}{your.email@example.com} $|$
    +1 (555) 123-4567 $|$
    \href{https://www.linkedin.com/in/yourprofile}{linkedin.com/in/yourprofile} $|$
    City, State, ZIP
\end{center}
```

**Tips:**
- Use `\href` for clickable links
- Use `$|$` for pipe separators
- Keep it concise (one or two lines)

### Step 1.3: Update Education

```bash
nano src/common/education.tex
```

Add your degrees:
```latex
\section{Education}
\vspace{-4pt}
\educationItem{Degree Name}{Start Date -- End Date}{University Name}{City, State}
\vspace{-6pt}

\educationItem{Another Degree}{Start Date -- End Date}{University Name}{City, State}
```

**Example:**
```latex
\educationItem{MS in Computer Science}{Aug. 2018 -- May 2020}{Stanford University}{Stanford, CA}
\vspace{-6pt}

\educationItem{BS in Computer Science}{Sept. 2014 -- May 2018}{University of California, Berkeley}{Berkeley, CA}
```

### Step 1.4: Update Technical Skills

```bash
nano src/common/skills.tex
```

List your skills:
```latex
\section{Technical Skills}
\vspace{2pt}
\noindent\textbf{Category 1:} Skill, Skill, Skill \\
\textbf{Category 2:} Skill, Skill, Skill \\
\textbf{Category 3:} Skill, Skill
```

**Example:**
```latex
\section{Technical Skills}
\vspace{2pt}
\noindent\textbf{Languages:} Python, JavaScript, Go, Java, SQL \\
\textbf{Frameworks:} React, Node.js, Django, Flask, TensorFlow \\
\textbf{Tools:} Docker, Kubernetes, AWS, Git, Jenkins
```

**✅ Initial Setup Complete!**

---

## Phase 2: Research Company (Per Application)

Before creating a company configuration, research the target company.

### Step 2.1: Understand Company Culture

Research:
- **Company values:** Innovation? Reliability? Customer focus?
- **Work environment:** Startup culture vs enterprise?
- **Tech stack:** What technologies do they use?
- **Recent news:** Funding, products, initiatives?

**Sources:**
- Company website (About, Careers pages)
- LinkedIn company page
- Glassdoor reviews
- TechCrunch, news articles

### Step 2.2: Analyze Job Posting

Extract from the job description:
- **Required skills:** What must you have?
- **Preferred skills:** Nice to have?
- **Keywords:** Repeated terms and phrases
- **Responsibilities:** What will you do?
- **Qualifications:** Experience level, education

**Create a checklist:**
```
Required Skills:
☐ Python
☐ AWS
☐ Microservices

Preferred:
☐ Kubernetes
☐ Team leadership

Keywords:
- "scalable"
- "distributed systems"
- "agile"
```

### Step 2.3: Choose Template Strategy

Based on your research, decide on a template:

| Company Type | Template | Why |
|--------------|----------|-----|
| **Startup** (< 100 employees, fast-paced) | `startup` | Emphasizes innovation, speed, versatility |
| **Large Tech** (Google, Microsoft, etc.) | `startup` or `example` | Balance of technical depth and scale |
| **Enterprise** (Fortune 500, traditional) | `enterprise` | Emphasizes leadership, process, reliability |
| **Unknown/General** | `skeleton` | Start from scratch, maximum flexibility |

---

## Phase 3: Create Company Configuration

### Step 3.1: Run Helper Script

```bash
# Option A: From skeleton (blank with docs)
./add_company.sh google

# Option B: From template (pre-filled)
./add_company.sh google startup
```

**You'll see:**
```
✓ Success! Created: src/companies/google/

Files created:
google_experience.tex
google_objective.tex

Next steps:
  1. Edit the objective statement: nano src/companies/google/google_objective.tex
  2. Customize work experience: nano src/companies/google/google_experience.tex
  ...
```

### Step 3.2: Verify Creation

```bash
ls src/companies/google/
```

**Should show:**
```
google_objective.tex
google_experience.tex
```

---

## Phase 4: Customize Objective

### Step 4.1: Open Objective File

```bash
nano src/companies/google/google_objective.tex
```

### Step 4.2: Write Tailored Objective

**Formula:**
```
[Your Title/Role] with [X]+ years of [Relevant Experience]
seeking [Target Role/Position] to [Value You Bring Using Company Keywords].
```

**For Startups:**
```latex
\section{Objective}
\noindent Software Engineer with 5+ years in full-stack development
seeking to build innovative, scalable solutions in a fast-paced environment.
```

**For Enterprise:**
```latex
\section{Professional Summary}
\begin{itemize}[leftmargin=0.15in, label={$\bullet$}]
    \item 8+ years building reliable, production-grade systems at scale.
    \vspace{-8pt}
    \item Proven track record leading cross-functional teams through complex projects.
    \vspace{-8pt}
    \item Expert in cloud architecture, microservices, and DevOps practices.
\end{itemize}
```

**Tips:**
- Use keywords from job posting
- Match the company's tone (innovative vs reliable)
- Highlight most relevant experience
- Keep to 2-4 lines or 3-4 bullets

---

## Phase 5: Customize Experience

### Step 5.1: Open Experience File

```bash
nano src/companies/google/google_experience.tex
```

### Step 5.2: Structure Your Experience

For each position:

```latex
\experienceItem{Job Title}{Company, Location}{Start Date -- End Date}
\vspace{-8pt}
\begin{itemize}[leftmargin=0.15in, label={$\bullet$}]
    \item Achievement 1 with quantifiable impact
    \vspace{-8pt}
    \item Achievement 2 relevant to target role
    \vspace{-8pt}
    \item Achievement 3 using company's keywords
    \vspace{-8pt}
\end{itemize}
```

### Step 5.3: Tailor Bullet Points

**Action Verbs by Focus:**

| Focus | Verbs |
|-------|-------|
| **Technical** | Architected, Implemented, Optimized, Built |
| **Leadership** | Led, Managed, Mentored, Coordinated |
| **Impact** | Increased, Reduced, Improved, Delivered |
| **Innovation** | Designed, Created, Pioneered, Launched |

**Quantify Results:**
- **Before:** "Improved system performance"
- **After:** "Optimized database queries, reducing latency by 40%"

**Match Company Focus:**

For **Google** (scale, innovation):
```latex
\item Architected microservices platform serving 10M+ users with 99.99\% uptime
\vspace{-8pt}
\item Implemented ML-based recommendation system, increasing engagement by 25\%
```

For **Bank of America** (reliability, compliance):
```latex
\item Led team of 8 engineers delivering SOC2-compliant payment processing system
\vspace{-8pt}
\item Reduced system downtime by 60\% through proactive monitoring and incident response
```

### Step 5.4: Prioritize Bullet Points

**Selection Strategy:**
1. **Must include:** Directly addresses required skills
2. **Should include:** Demonstrates preferred skills or similar experience
3. **Nice to have:** Impressive but less relevant
4. **Skip:** Not relevant to this role

**Reorder** bullets so most relevant appears first under each position.

---

## Phase 6: Generate Resume

### Step 6.1: Build the PDF

```bash
make COMPANY=google
```

**You'll see:**
```
mkdir -p output/google/internals
pdflatex -jobname=Your_Name_google ...
[LaTeX output...]
-------------------------------------------------------
PDF GENERATED: output/google/Your_Name_google.pdf
-------------------------------------------------------
```

### Step 6.2: Locate the PDF

```bash
ls output/google/
```

**Output:**
```
Your_Name_google.pdf
internals/           # Build artifacts (ignore)
```

---

## Phase 7: Review PDF

### Step 7.1: Open and Review

```bash
open output/google/Your_Name_google.pdf
# On Linux: xdg-open output/google/Your_Name_google.pdf
# On Windows: start output/google/Your_Name_google.pdf
```

### Step 7.2: Quality Checklist

**Layout:**
- ☐ Exactly **one page** (not more, not less)
- ☐ Proper spacing (not too cramped or too sparse)
- ☐ Clear section breaks
- ☐ Consistent formatting

**Content:**
- ☐ Contact info is **correct and current**
- ☐ No typos or grammatical errors
- ☐ Dates are accurate
- ☐ Company names are correct
- ☐ Quantifiable metrics where possible

**Tailoring:**
- ☐ Objective mentions relevant skills/keywords
- ☐ Experience highlights match job requirements
- ☐ Tone matches company culture
- ☐ Most relevant experience is prominent

**Technical:**
- ☐ All special characters display correctly (`%`, `&`, `$`)
- ☐ Links are clickable (email, LinkedIn)
- ☐ PDF filename is correct

---

## Phase 8: Refine and Update

### Step 8.1: Make Adjustments

If PDF is **too long** (more than 1 page):

```bash
nano src/companies/google/google_experience.tex
```

**Solutions:**
- Remove oldest or least relevant position
- Delete less important bullet points
- Shorten bullet text
- Increase negative vspace: `\vspace{-12pt}` → `\vspace{-14pt}`

If PDF is **too short** (less than 1 full page):

- Add more bullet points to recent positions
- Expand on achievements with more detail
- Reduce negative vspace: `\vspace{-12pt}` → `\vspace{-10pt}`

### Step 8.2: Fix Typos or Errors

```bash
# Edit objective
nano src/companies/google/google_objective.tex

# Edit experience
nano src/companies/google/google_experience.tex

# Edit common files (affects all companies)
nano src/common/header.tex
nano src/common/education.tex
nano src/common/skills.tex
```

### Step 8.3: Regenerate

```bash
make COMPANY=google
```

Review again. **Repeat until satisfied.**

---

## Phase 9: Multiple Companies

### Step 9.1: Create Multiple Configurations

```bash
./add_company.sh amazon startup
./add_company.sh microsoft enterprise
./add_company.sh facebook startup
```

### Step 9.2: Customize Each

**Efficient approach:**
1. Start with one company (e.g., Amazon)
2. Complete all steps (customize, generate, review)
3. Use it as base for similar companies
4. Copy and modify:

```bash
# Copy Amazon config to Netflix (both startups)
cp -r src/companies/amazon src/companies/netflix

# Rename files
cd src/companies/netflix
mv amazon_objective.tex netflix_objective.tex
mv amazon_experience.tex netflix_experience.tex

# Edit for Netflix
nano netflix_objective.tex
nano netflix_experience.tex
cd ../../..

# Generate
make COMPANY=netflix
```

### Step 9.3: Batch Generate

```bash
for company in amazon microsoft facebook netflix; do
    echo "Generating $company..."
    make COMPANY=$company
done
```

---

## Phase 10: Ongoing Maintenance

### Step 10.1: Update Common Information

When your contact info, skills, or education changes:

```bash
# Update common files
nano src/common/header.tex     # New phone number, address
nano src/common/education.tex  # New degree
nano src/common/skills.tex     # New skills

# Regenerate ALL companies
for company in src/companies/*/; do
    company=$(basename "$company")
    echo "Rebuilding $company..."
    make COMPANY="$company"
done
```

### Step 10.2: Add New Experience

When you change jobs:

```bash
# Update all companies
for company in src/companies/*/; do
    company=$(basename "$company")
    nano "src/companies/$company/${company}_experience.tex"
    # Add new position at the top
    # Adjust or remove oldest positions
done

# Regenerate all
for company in src/companies/*/; do
    company=$(basename "$company")
    make COMPANY="$company"
done
```

### Step 10.3: Archive Old Companies

When you're no longer applying to a company:

```bash
# Move to archive (optional)
mkdir -p archive/companies
mv src/companies/oldcompany archive/companies/

# Or delete
rm -rf src/companies/oldcompany output/oldcompany
```

---

## Common Workflows

### Workflow A: Quick Application

When you need a resume quickly:

```bash
# 1. Create from template
./add_company.sh newcompany startup

# 2. Quick customizations
nano src/companies/newcompany/newcompany_objective.tex  # 5 min
nano src/companies/newcompany/newcompany_experience.tex  # 10 min

# 3. Generate and go
make COMPANY=newcompany
open output/newcompany/Your_Name_newcompany.pdf
```

### Workflow B: High-Priority Application

When you want to carefully tailor:

```bash
# 1. Deep research (30 min)
# - Read company blog, news
# - Study job description
# - Check LinkedIn for employees

# 2. Create from skeleton
./add_company.sh dreamcompany

# 3. Carefully craft objective (15 min)
nano src/companies/dreamcompany/dreamcompany_objective.tex

# 4. Tailor every bullet (30 min)
nano src/companies/dreamcompany/dreamcompany_experience.tex

# 5. Generate and review
make COMPANY=dreamcompany
open output/dreamcompany/Your_Name_dreamcompany.pdf

# 6. Get feedback
# - Show to friend/mentor
# - Make revisions
# - Regenerate

# 7. Final review
make COMPANY=dreamcompany
open output/dreamcompany/Your_Name_dreamcompany.pdf
```

### Workflow C: Batch Applications

Applying to many companies at once:

```bash
# 1. Create all from same template
for company in google amazon facebook microsoft apple; do
    ./add_company.sh $company startup
done

# 2. Customize objectives (focus here for differentiation)
for company in google amazon facebook microsoft apple; do
    nano "src/companies/$company/${company}_objective.tex"
done

# 3. Experience may be similar, minor tweaks only
for company in google amazon facebook microsoft apple; do
    nano "src/companies/$company/${company}_experience.tex"
done

# 4. Generate all
for company in google amazon facebook microsoft apple; do
    make COMPANY=$company
done

# 5. Review all
ls output/*/Your_Name_*.pdf
```

---

## Tips for Success

### Efficiency
- **Reuse work:** Copy similar companies, modify slightly
- **Templates:** Use reference templates as starting points
- **Batch operations:** Update multiple companies at once
- **Focus:** Spend most time on objective (highest ROI)

### Quality
- **One page:** Always one page, never more
- **Proofread:** No typos
- **Quantify:** Use numbers and percentages
- **Keywords:** Mirror job description language

### Organization
- **Naming:** Consistent lowercase names
- **Comments:** Add notes in tex files for future reference
- **Version control:** Commit company configs to git
- **Archiving:** Move old companies out of `src/companies/`

### Customization Priorities

| Priority | What to Customize | Time Investment |
|----------|-------------------|-----------------|
| **High** | Objective statement | 5-15 min |
| **High** | Bullet point selection/order | 10-20 min |
| **Medium** | Bullet point wording | 5-10 min per point |
| **Low** | Adding new sections | 15-30 min |
| **Very Low** | Styling changes | Variable |

---

## Troubleshooting

### Problem: Changes not appearing

**Solution:**
```bash
make clean
make COMPANY=google
```

### Problem: PDF is 1.1 pages (spills onto page 2)

**Solutions:**
1. Remove 1-2 bullet points
2. Shorten bullet text
3. Increase negative vspace
4. Remove oldest position

### Problem: Don't know which template to use

**Solution:** Start with `skeleton` (default), gives maximum flexibility.

---

## Next Steps

After completing this workflow:

1. **Review documentation:**
   - [Usage Guide](USAGE_GUIDE.md) - Command reference
   - [Examples](EXAMPLES.md) - Template comparisons
   - [Architecture](ARCHITECTURE.md) - System design

2. **Practice:** Create test companies to learn the system
3. **Refine:** Iterate on your common files
4. **Apply:** Create real company configurations

Good luck with your applications! 🚀
