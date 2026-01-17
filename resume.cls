% =============================================================================
% resume.cls - Custom LaTeX Resume Class
% =============================================================================
% DESCRIPTION:
%   This custom LaTeX class provides styling and commands for generating
%   professional one-page resumes. It includes custom formatting for sections,
%   experience items, and education entries.
%
% USAGE:
%   In your .tex file: \documentclass{resume}
%
% FEATURES:
%   - 11pt font on letter-size paper with 0.5in margins
%   - Section headers with horizontal rules
%   - Custom commands for experience and education items
%   - No page numbers (single-page resumes only)
%
% CUSTOMIZATION:
%   - Font size: Change 11pt in \LoadClass line below
%   - Margins: Modify geometry package settings
%   - Section style: Adjust \titleformat command
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/01/01 Custom Resume Class]

% =============================================================================
% BASE CLASS
% =============================================================================
% Load article class with 11pt font on letter-size paper
% Available sizes: 10pt, 11pt (default), 12pt
\LoadClass[11pt,letterpaper]{article}

% =============================================================================
% REQUIRED PACKAGES
% =============================================================================

% geometry: Set page margins
% Default: 0.5 inch on all sides for maximum space
\usepackage[left=0.5in, top=0.5in, right=0.5in, bottom=0.5in]{geometry}

% hyperref: Enable clickable links (email, LinkedIn, etc.)
% hidelinks: Don't show colored boxes around links
\usepackage[hidelinks]{hyperref}

% enumitem: Customize bullet points and list formatting
\usepackage{enumitem}

% titlesec: Customize section heading formatting
\usepackage{titlesec}

% etoolbox: Programming tools for LaTeX
\usepackage{etoolbox}

% =============================================================================
% SECTION FORMATTING
% =============================================================================
% Customize section headers to have:
%   - Large bold font
%   - No indentation
%   - Horizontal line below
%   - Custom spacing (8pt before, 4pt after)
%
% To customize:
%   - Font: Change \large\bfseries
%   - Line: Remove [\titlerule] to remove horizontal line
%   - Spacing: Adjust {8pt}{4pt} values
\titleformat{\section}{\large\bfseries\large}{}{0pt}{}[\titlerule]
\titlespacing{\section}{0pt}{8pt}{4pt}

% =============================================================================
% CUSTOM COMMANDS
% =============================================================================

% -----------------------------------------------------------------------------
% \educationItem - Format education entries
% -----------------------------------------------------------------------------
% USAGE:
%   \educationItem{Degree}{Dates}{Institution}{Location}
%
% EXAMPLE:
%   \educationItem{MS in Computer Science}{Aug. 2018 -- May 2020}{Stanford University}{Stanford, CA}
%
% PARAMETERS:
%   #1: Degree name (e.g., "BS in Computer Science")
%   #2: Date range (e.g., "Sept. 2015 -- May 2019")
%   #3: Institution name (e.g., "MIT")
%   #4: Location (e.g., "Cambridge, MA")
%
% OUTPUT FORMAT:
%   Degree Name                                                     Date Range
%   Institution Name                                                Location
% -----------------------------------------------------------------------------
\newcommand{\educationItem}[4]{
  \vspace{4pt}                                    % Add space before entry
  \noindent\textbf{#1} \hfill #2 \\             % Degree (bold) | Dates (right-aligned)
  \noindent{#3} \hfill {#4} \par                % Institution | Location (right-aligned)
  \vspace{2pt}                                    % Add space after entry
}

% -----------------------------------------------------------------------------
% \experienceItem - Format work experience headers
% -----------------------------------------------------------------------------
% USAGE:
%   \experienceItem{Job Title}{Company, Location}{Date Range}
%
% EXAMPLE:
%   \experienceItem{Senior Software Engineer}{Google, Mountain View, CA}{Jan. 2020 -- Present}
%
% PARAMETERS:
%   #1: Job title (e.g., "Software Engineer")
%   #2: Company and location (e.g., "Google, Mountain View, CA")
%   #3: Date range (e.g., "Jan. 2020 -- Present" or "Jun. 2018 -- Dec. 2019")
%
% OUTPUT FORMAT:
%   Job Title           Company, Location                    Date Range (italic)
%
% NOTE:
%   This command only formats the header. Follow it with:
%   - \vspace{-8pt} to reduce space
%   - \begin{itemize} for bullet points
%
% FULL EXAMPLE:
%   \experienceItem{Senior Software Engineer}{Google, Mountain View, CA}{Jan. 2020 -- Present}
%   \vspace{-8pt}
%   \begin{itemize}[leftmargin=0.15in, label={$\bullet$}]
%       \item Built scalable microservices serving 10M+ users
%       \vspace{-8pt}
%       \item Reduced API latency by 40\% through optimization
%   \end{itemize}
% -----------------------------------------------------------------------------
\newcommand{\experienceItem}[3]{
  \vspace{4pt}                                         % Add space before entry
  \noindent\textbf{#1} \hfill #2 \hfill \textit{#3} \par  % Title | Company | Dates (italic)
  \vspace{2pt}                                         % Add space after entry
}

% =============================================================================
% PAGE FORMATTING
% =============================================================================

% Disable page numbers (resumes should be single-page)
% This prevents "1" from appearing at bottom of page
\pagenumbering{gobble}

% =============================================================================
% NOTES ON SPACING
% =============================================================================
% To control vertical spacing in your resume, use \vspace{} command:
%
%   \vspace{6pt}   - Add 6pt of space
%   \vspace{-8pt}  - Remove 8pt of space (negative values reduce space)
%
% Common spacing patterns:
%
%   After section headers:
%     \section{Experience}
%     \vspace{-2pt}
%
%   After experienceItem:
%     \experienceItem{Title}{Company}{Dates}
%     \vspace{-8pt}   % Typical: -8pt to -12pt
%
%   Between bullet points:
%     \item First point
%     \vspace{-8pt}   % Typical: -6pt to -10pt
%     \item Second point
%
% Tips:
%   - Start with provided values
%   - Adjust incrementally to fit resume to one page
%   - Negative values tighten spacing, positive values loosen it
% =============================================================================

% =============================================================================
% CUSTOMIZATION EXAMPLES
% =============================================================================
%
% To change margins:
%   \usepackage[left=0.75in, top=0.75in, right=0.75in, bottom=0.75in]{geometry}
%
% To change font size:
%   \LoadClass[10pt,letterpaper]{article}  % Smaller font
%   \LoadClass[12pt,letterpaper]{article}  % Larger font
%
% To change section heading format:
%   \titleformat{\section}{\Large\bfseries}{}{0pt}{}[\titlerule]  % Larger headings
%   \titleformat{\section}{\large\bfseries}{}{0pt}{}               % No line below
%
% To enable page numbers:
%   Comment out: % \pagenumbering{gobble}
%
% To add custom commands:
%   \newcommand{\mycommand}[args]{definition}
% =============================================================================
