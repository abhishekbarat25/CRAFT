# Template Examples

Comparison of included templates and guidance on choosing the right one.

## Available Templates

| Template | Location | Focus | Best For | Content |
|----------|----------|-------|----------|---------|
| `skeleton` | `src/skeleton/` | Documentation | Starting from scratch | Blank with inline docs |
| `example` | `src/templates/` | Balanced | General purpose | Placeholder content |
| `startup` | `src/templates/` | Innovation | Startups, tech companies | Innovation-focused |
| `enterprise` | `src/templates/` | Leadership | Large corporations | Leadership-focused |

## Template Selection Guide

### When to Use Each Template

**Use `skeleton` (default) when:**
- You want maximum customization flexibility
- You prefer comprehensive inline documentation
- You're creating a highly tailored resume
- You want to understand each section as you write

**Use `example` when:**
- You want a balanced, general-purpose starting point
- You're unsure about company culture
- You need placeholder text as reference
- You're new to resume writing

**Use `startup` when:**
- Applying to startups (< 200 employees)
- Tech companies (Google, Meta, etc.)
- R&D or innovation-focused roles
- Individual contributor positions emphasizing technical depth

**Use `enterprise` when:**
- Applying to Fortune 500 companies
- Management or leadership roles
- Consulting positions
- Regulated industries (finance, healthcare, government)

---

## Template Comparison

### Skeleton Template (Default)

**Location:** `src/skeleton/`

**Characteristics:**
- Blank files with comprehensive inline documentation
- Explains each section's purpose
- Provides examples and tips inline
- Multiple format options shown
- Industry-specific examples included

**Objective Style:**
```latex
% Extensively documented with tips and examples
\section{Professional Summary}
\begin{itemize}...
```

**Experience Emphasis:**
- Comprehensive documentation on writing bullets
- Examples for different industries
- Tailoring strategies explained
- Action verb suggestions

**Best For:**
- First-time users who want to learn the system
- Users who want maximum control
- Applications requiring deep customization

**Create with:**
```bash
./add_company.sh google
```

---

### Example Template

**Location:** `src/templates/example/`

**Characteristics:**
- Balanced approach
- Placeholder content for reference
- General corporate language
- Mix of technical and soft skills

**Objective Style:**
```latex
[Role] with [X] years seeking opportunities in [area] to [value].
```

**Experience Emphasis:**
- Mix of technical and leadership
- Quantifiable achievements
- Standard corporate language
- No specific industry bias

**Sample Bullet:**
```latex
\item Led development of microservices platform serving 50k+ users
```

**Best For:**
- General applications
- When company culture is unknown
- Starting point for customization
- Traditional corporate environments

**Create with:**
```bash
./add_company.sh google example
```

---

### Startup Template

**Location:** `src/templates/startup/`

**Characteristics:**
- Innovation and speed focused
- Technical depth emphasized
- Impact and growth metrics
- Dynamic, energetic tone

**Objective Style:**
```latex
...seeking to build innovative solutions in a fast-paced environment.
```

**Experience Emphasis:**
- New technologies and tools
- Speed of delivery (e.g., "in 3 weeks")
- Cost savings and efficiency
- Growth metrics (e.g., "0 to 100k users")
- Open source contributions
- Full-stack versatility

**Sample Bullets:**
```latex
\item Built MVP in 2 weeks using React and Node.js, acquiring first 1000 users
\vspace{-8pt}
\item Reduced AWS costs by 40\% through infrastructure optimization
\vspace{-8pt}
\item Open-sourced internal tool, gaining 500+ GitHub stars
```

**Keywords Used:**
- Innovative, cutting-edge, modern
- Fast-paced, agile, iterative
- Scale, growth, users
- MVP, prototype, launch

**Best For:**
- Series A-C startups
- FAANG companies (technical roles)
- Product-focused tech companies
- Individual contributor roles
- Remote/distributed teams

**Create with:**
```bash
./add_company.sh google startup
```

---

### Enterprise Template

**Location:** `src/templates/enterprise/`

**Characteristics:**
- Leadership and process focused
- Reliability and scale emphasized
- Team size and stakeholders mentioned
- Professional, formal tone

**Objective Style:**
```latex
...seeking to lead teams and deliver reliable, scalable systems.
```

**Experience Emphasis:**
- Team size managed (e.g., "Led team of 12")
- Process improvement and documentation
- Compliance and certifications
- Uptime and reliability metrics (e.g., "99.99% uptime")
- Cross-functional coordination
- Budget and timeline management

**Sample Bullets:**
```latex
\item Led team of 8 engineers delivering SOC2-compliant platform on time and under budget
\vspace{-8pt}
\item Improved system reliability from 98\% to 99.95\% uptime through monitoring and automation
\vspace{-8pt}
\item Coordinated with 5 stakeholder teams across 3 time zones for successful Q4 launch
```

**Keywords Used:**
- Reliable, scalable, production-grade
- Leadership, management, mentorship
- Process, compliance, governance
- Stakeholders, cross-functional, coordination

**Best For:**
- Fortune 500 companies
- Management positions (Engineering Manager, Director, VP)
- Consulting roles
- Regulated industries (finance, healthcare, government)
- Roles emphasizing reliability over speed

**Create with:**
```bash
./add_company.sh google enterprise
```

---

## Detailed Feature Comparison

### Objective/Summary Section

| Template | Format | Tone | Length | Focus |
|----------|--------|------|--------|-------|
| Skeleton | Flexible | Documented | Variable | Educational |
| Example | Paragraph | Neutral | 2-3 lines | Balanced |
| Startup | Paragraph | Dynamic | 1-2 lines | Innovation |
| Enterprise | Bullet list | Professional | 3-4 bullets | Leadership |

### Experience Bullets

| Template | Emphasis | Metrics | Team Size | Tech Detail |
|----------|----------|---------|-----------|-------------|
| Skeleton | Varies | Explained | Explained | Explained |
| Example | Balanced | Yes | Sometimes | Moderate |
| Startup | Impact | Growth, speed | Rarely | High |
| Enterprise | Process | Reliability | Always | Low |

---

## Customization Strategies

### For Innovation-Focused Companies

**Start with:** `startup` template

**Keywords to add:**
- Innovative, cutting-edge, next-generation
- Fast-paced, agile, iterative
- Scale, growth, viral

**Metrics to highlight:**
- User growth (0 → 100k)
- Speed (built in X weeks)
- Cost savings
- Performance improvements

**Example customization:**
```latex
\item Architected real-time notification system scaling from 0 to 1M daily users
\vspace{-8pt}
\item Reduced API latency by 60\% through Redis caching and query optimization
```

### For Leadership-Focused Companies

**Start with:** `enterprise` template

**Keywords to add:**
- Reliable, scalable, production-grade
- Leadership, mentorship, team
- Process, compliance, quality
- Strategic, roadmap, vision

**Metrics to highlight:**
- Team size (Led team of X)
- Uptime/reliability (99.X%)
- Budget/timeline adherence
- Stakeholder coordination

**Example customization:**
```latex
\item Led cross-functional team of 15 delivering \$2M project 2 weeks ahead of schedule
\vspace{-8pt}
\item Mentored 5 junior engineers, 3 promoted to senior roles within 18 months
```

---

## Creating Custom Templates

### Approach 1: Start from Skeleton

```bash
./add_company.sh mycompany
# Fully customize from scratch with inline guidance
```

### Approach 2: Modify Existing Template

```bash
./add_company.sh mycompany startup
# Edit to add your specific spin
nano src/companies/mycompany/mycompany_objective.tex
nano src/companies/mycompany/mycompany_experience.tex
```

### Approach 3: Mix Templates

```bash
# Use startup for objective, enterprise for experience
./add_company.sh mycompany startup
# Then manually copy elements from enterprise template
```

---

## Bullet Writing Formulas

### Startup Style

**Formula:** `[Action Verb] [What] resulting in [Growth/Speed Metric]`

**Examples:**
```latex
\item Built ML recommendation engine, increasing user engagement by 35\%
\item Shipped mobile app in 6 weeks, acquiring 10k users in first month
\item Reduced deployment time from 2 hours to 5 minutes through CI/CD automation
```

### Enterprise Style

**Formula:** `[Led/Managed] [Team Size] [Action] resulting in [Reliability/Process Metric]`

**Examples:**
```latex
\item Led team of 10 engineers migrating legacy system to microservices with zero downtime
\item Managed \$5M budget for cloud infrastructure, delivering 15\% cost savings
\item Established code review process reducing production bugs by 40\%
```

### Technical Depth Style

**Formula:** `[Technical Action] [Specific Technology] achieving [Performance Metric]`

**Examples:**
```latex
\item Optimized PostgreSQL queries and added connection pooling, reducing API latency from 500ms to 50ms
\item Implemented WebSocket-based real-time updates using Node.js and Redis pub/sub
\item Architected event-driven microservices using Kafka, processing 1M+ messages/day
```

---

## Action Verbs by Category

### Technical (Startup)
Architected, Implemented, Built, Developed, Designed, Optimized, Deployed

### Leadership (Enterprise)
Led, Managed, Mentored, Coordinated, Directed, Oversaw, Established

### Impact (Both)
Increased, Reduced, Improved, Delivered, Achieved, Accelerated, Streamlined

### Innovation (Startup)
Pioneered, Created, Launched, Introduced, Initiated, Prototyped, Experimented

### Process (Enterprise)
Established, Standardized, Documented, Implemented, Formalized, Institutionalized

---

## Quick Reference

### Choosing a Template

**Ask yourself:**

1. **Company size?**
   - < 200 employees → `startup`
   - > 1000 employees → `enterprise`
   - Unknown → `example`

2. **Role level?**
   - Individual contributor → `startup` or `example`
   - Team lead / Manager → `enterprise`
   - Senior IC → `example`

3. **Industry?**
   - Tech startup → `startup`
   - Finance/Healthcare → `enterprise`
   - Consulting → `enterprise`
   - General → `example`

4. **Company culture?**
   - "Move fast" → `startup`
   - "Do it right" → `enterprise`
   - Unknown → `example`

### Customization Checklist

After choosing a template:

- ☐ Replace all placeholder text
- ☐ Add company-specific keywords from job posting
- ☐ Adjust tone to match company culture
- ☐ Reorder bullets to emphasize relevant experience
- ☐ Quantify achievements with metrics
- ☐ Remove less relevant bullet points if over one page
- ☐ Proofread for typos and grammar

---

## Examples by Industry

### Software Engineering at Tech Startup

**Template:** `startup`
**Focus:** Technical depth, speed, growth
**Sample objective:**
```latex
\section{Objective}
\noindent Software Engineer with 5+ years building scalable web applications
seeking to develop innovative products in a fast-paced startup environment.
```

### Engineering Manager at Enterprise

**Template:** `enterprise`
**Focus:** Leadership, reliability, process
**Sample objective:**
```latex
\section{Professional Summary}
\begin{itemize}[leftmargin=0.15in, label={$\bullet$}]
    \item Engineering Manager with 10+ years leading teams of 8-15 engineers
    \vspace{-8pt}
    \item Proven track record delivering reliable systems serving 10M+ users
    \vspace{-8pt}
    \item Expert in Agile processes, technical mentorship, and stakeholder management
\end{itemize}
```

### Product Engineer at Growing Company

**Template:** `example` or `startup`
**Focus:** Balance of technical and product
**Sample objective:**
```latex
\section{Objective}
\noindent Product Engineer with 6+ years building user-facing features
seeking to bridge engineering and product to deliver customer value.
```

---

## Next Steps

1. **Review templates:** Look at files in `src/templates/`
2. **Test generation:** Create test companies from each template
3. **Compare output:** See which style fits your background
4. **Choose and customize:** Start with closest match, then tailor

For more guidance:
- [QUICKSTART.md](QUICKSTART.md) - Get started in 10 minutes
- [WORKFLOW.md](WORKFLOW.md) - Complete step-by-step process
- [USAGE_GUIDE.md](USAGE_GUIDE.md) - Command reference
