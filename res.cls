
%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{res}
\NeedsTeXFormat{LaTeX2e}

%-------------------------------------------------------------------------------
%                Class options
%-------------------------------------------------------------------------------
% Options for draft or final
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% Inherit options of article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}


\pdfgentounicode=1

%-------------------------------------------------------------------------------
%                3rd party packages
%-------------------------------------------------------------------------------
\usepackage[default]{roboto}

\usepackage{mathdesign}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage[cmintegrals,cmbraces]{newtxmath}

\RequirePackage{latexsym}
\RequirePackage[empty]{fullpage}
\RequirePackage{titlesec}
\RequirePackage{marvosym}
\RequirePackage[usenames,dvipsnames]{color}
\RequirePackage{verbatim}
\RequirePackage{enumitem} % Handles list environments
\RequirePackage[hidelinks]{hyperref} % Settings for hyperlinks
\RequirePackage{fancyhdr} % Create header and footer
\RequirePackage[english]{babel}
\RequirePackage{csquotes}
\RequirePackage{tabularx} % Allows tables with automatically varying column widths
\RequirePackage[export]{adjustbox} % Allows for easy resizing of tables or figures to fit page width
\RequirePackage{indentfirst} % Allows first paragraph in new section to have indentation

\input{glyphtounicode}

% To use bib file for publication information
% Sorting=ydnt gives reverse year then name then title
% Maxbibnames and minbibnames define number of authors before et al.
% Uniquelist requires additional authors to be added such that each publication has a unique list of authors
\usepackage[backend=biber,style=authoryear,sorting=ydnt, maxbibnames=1, minbibnames=1,uniquelist=false]{biblatex}
% \addbibresource{citations.bib} % Read in citations from citations.bib - uncomment if using biblatex to generate publications list
\setlength\bibitemsep{1em} % Set separation between multiple citations
%-------------------------------------------------------------------------------
%                Configuration for document layout and style
%-------------------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{} % Clear all header and footer fields
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\setlength{\footskip}{4.4pt}

% Adjust margins
\addtolength{\oddsidemargin}{-0.5in}
\addtolength{\evensidemargin}{-0.5in}
\addtolength{\textwidth}{1in}
\addtolength{\topmargin}{-.5in}
\addtolength{\textheight}{1.0in}

\urlstyle{same}

\raggedbottom
\raggedright
\newlength{\oldtabcolsep} % Define variable for original table column separation
\setlength{\oldtabcolsep}{\tabcolsep} % Save original table column separation for later use
\setlength{\tabcolsep}{0pt} % Change table column separation to 0pt

% Sections formatting
\titleformat{\section}{
  \vspace{-4pt}\bfseries\scshape\raggedright\large
}{}{0em}{}[\titlerule \vspace{-5pt}]


%-------------------------------------------------------------------------------
%                Configuration for resume entry elements
%-------------------------------------------------------------------------------

% For a single bulleted item, useful for narrative descriptions of experience
\newcommand{\resumeItem}[1]{
  \item{
    {#1 \vspace{-2pt}}
  }
}

% For a volunteer experience or education item (includes location but no supervisor info or hours worked)
\newcommand{\resumeSubheading}[4]{
  \vspace{-2pt}\item
    \begin{tabular*}{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{#1} & #2 \\
      \textit{#3} & \textit{ #4} \\
    \end{tabular*}\vspace{-7pt}
}

% For a volunteer experience or job related training item without a location
\newcommand{\resumeSubheadingShort}[2]{
  \vspace{-2pt}\item
    \begin{tabular*}{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{#1} & #2 \\
    \end{tabular*}\vspace{-7pt}
}


\newcommand{\resumeSubheadingWork}[4]{
  \vspace{-2pt}\item
    \begin{tabularx}{0.97\textwidth}[t]{l >{\raggedleft\arraybackslash}X}
      \textbf{#1} & #2 \\ % Job Title & Date
      \textit{#3} & \textit{#4} \\ % Employer Name & Job Address
    \end{tabularx}\vspace{-7pt}
}


% Optional style for multiple work positions
\newcommand{\resumeSubSubheading}[2]{
    \item
    \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
      \textit{#1} & \textit{ #2} \\
    \end{tabular*}\vspace{-7pt}
}

% Optional style for projects
\newcommand{\resumeProjectHeading}[2]{
    \item
    \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
      #1 & #2 \\
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\resumeSubItem}[1]{\resumeItem{#1}\vspace{-4pt}}

\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}

% Define list environments start and end
\newcommand{\resumeSubHeadingListStart}{\begin{itemize}[leftmargin=0.15in, label={}]}
\newcommand{\resumeSubHeadingListEnd}{\end{itemize}}
\newcommand{\resumeItemListStart}{\begin{itemize}}
\newcommand{\resumeItemListEnd}{\end{itemize}\vspace{-5pt}}

% Usage: \cvpub{<citation>}
\newcommand*{\cvpub}[1]{%
	\leftskip 1.1cm
    \parindent -0.7cm
    {#1}\vspace{3pt}
}
