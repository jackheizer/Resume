\ProvidesClass{personal-resume}[2020/07/25  v1.0.0 'Personal Resume' Class]

\def\@@ptsize{10pt}

\ProcessOptions\relax

\LoadClass[a4paper,\@@ptsize]{article}

\newif\if@showLinks   \@showLinksfalse

\DeclareOption{monochrome}{
  \def\@monochrome{monochrome}
}

\ProcessOptions

% Dependences
%A Few Useful Packages
\RequirePackage[english,french]{babel}
\RequirePackage[utf8]{luainputenc}
\RequirePackage{fontspec} 					                 % for loading fonts
\RequirePackage{url,parskip} 	    % other packages for formatting
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{fullpage}
\RequirePackage[margin=1.5cm]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{longtable}
\RequirePackage{etoolbox}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{fancyhdr}
\RequirePackage{ifthen}
\RequirePackage{calc}


\DeclareUnicodeCharacter{00E9}{\'{e}}
% Define default accent colors
\definecolor{darkgrey}{HTML}{989898}
\definecolor{coboltblue}{RGB}{0, 71, 171}
\colorlet{linkcolor}{coboltblue}
\colorlet{accentcolor}{linkcolor!90}
\colorlet{symbolcolor}{linkcolor!85}

% Setup hyperref package, and colours for links
%\definecolor{linkcolour}{rgb}{0,0.2,0.6}

\if@showLinks
  \hypersetup{%
    breaklinks
  }%
\else
  \hypersetup{%
    pdfborder = {0 0 0},
    breaklinks
  }%
\fi

% Setup fancyhdr package
\fancyhf{}
\fancyhfoffset{0em}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
%\fancyfoot[C]{\thepage}
\pagestyle{fancy}

% Setup CV sections
\titleformat{\section}{\Large\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0pt}{2pt}{2pt}

% Configure list
\setlist[itemize,1]{label=\faAngleRight, nosep, leftmargin=2em}
\setlist[itemize,2]{label=\faAngleRight, nosep, leftmargin=1.5em}

% Setup Array : new column type
\newcolumntype{R}[1]{>{\hfill}m{#1}}

%Italian hyphenation for the word: ''corporations''
\hyphenation{im-pre-se}

% Setup fonts
\defaultfontfeatures{Ligatures=TeX}
%

\setmainfont{SourceSansPro-Light}[
  Path = fonts/,
  BoldFont = SourceSansPro-Regular,
  ItalicFont = SourceSansPro-LightIt
]

\newlength{\leftcolumnlength}
\setlength{\leftcolumnlength}{1.5cm}

\newlength{\rightcolumnlength}
\setlength{\rightcolumnlength}{\dimexpr(\textwidth-\leftcolumnlength-\Gm@lmargin)\relax}

% Override default left column length of (2.5cm)
% Usage: \setleftcolumnlength{<length>}
\newcommand{\setleftcolumnlength}[1]{
  \setlength{\leftcolumnlength}{#1}
  \setlength{\rightcolumnlength}{\dimexpr(\textwidth-\leftcolumnlength-\Gm@lmargin)\relax}
}

% Font Awesome icons aliases
\newcommand{\mailSymbol}{\faAt}
\newcommand{\locationSymbol}{\faMapMarker*}
\newcommand{\infoSymbol}{\faInfo}
\newcommand{\linkedinSymbol}{\faLinkedinIn}
\newcommand{\viadeoSymbol}{\faViadeo}
\newcommand{\mobileSymbol}{\faMobile*}
\newcommand{\phoneSymbol}{\faPhone}
\newcommand{\githubSymbol}{\faGithub}
\newcommand{\stackoverflowSymbol}{\faStackOverflow}
\newcommand{\stackexchangeSymbol}{\faStackExchange}
\newcommand{\mediumSymbol}{\faMedium}
\newcommand{\bitbucketSymbol}{\faBitbucket}
\newcommand{\websiteSymbol}{\faLink}


\newcommand\link[2]{\color{linkcolor}\href{#1}{#2}\color{Black} }
\newcommand\important[1]{\textbf #1}

% Create a tag
% Usage: \cvtag{<tag label>}
\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=darkgrey!70,rounded corners=0.5ex,inner xsep=1ex,inner ysep =0.55ex,text height=1.3ex,text depth=.25ex]{#1};
}

% Render author's name
% Usage: \user{<firstanme>}{<lastname>}
\newcommand\user[2]{\color{accentcolor}{\LARGE #1 \textsc{\textbf{#2}}}\color{Black}}

% Render a text with its symbol
% Usage; \socialtext{<icon>}{<label>}
\newcommand{\socialtext}[2]{\item[\textcolor{symbolcolor}{#1}]#2}

% Render a link with its symbol
% Usage; \sociallink{<icon>}{<label>}
\newcommand{\sociallink}[3]{\item[\textcolor{symbolcolor}{#1}]\link{#2}{#3}}

% Define author's name
% Usage: \name{<firstname>}{<lastname>}
% Usage: \firstname{<firstname>}
% Usage: \lastname{<lastname>}
% Usage: \familyname{<familyname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}

% Define author's tagline
% Usage: \tagline{<tag line>}
\newcommand*{\tagline}[1]{\def\@tagline{#1}}

% Define author's photo
% Usage: \photo[<shape: circular, square, roundedsquare, squircle>]{<diameter>}{<photo>}
% The shape of the author's photo is circular by default.
\newcommand{\photo}[3][circular]{\def\@photo{#3}\def\@photodiameter{#2}\def\@photoshape{#1}}

% Render author's address
% Usage: \address{<address>}
\newcommand*{\address}[2]{\socialtext{\locationSymbol}{#1\\#2}}

% Render author's infos
% Usage: \infos{<infos>}
\newcommand*{\infos}[1]{\socialtext{\infoSymbol}{#1}}

% Render author's linked-in (optional)
% Usage: \linkedin{<linked-in-nick>}
\newcommand*{\linkedin}[1]{\sociallink{\linkedinSymbol}{http://www.linkedin.com/in/#1/fr}{linkedin.com/in/#1}}

% Render author's github (optional)
% Usage: \github{<github-nick>}
\newcommand*{\github}[1]{\sociallink{\githubSymbol}{https://www.github.com/#1}{github.com/#1}}           % Github icon + URL

% Render author's stackoverflow profile (optional)
% Usage: \stackoverflow{<stackoverflow-user-id>}
\newcommand*{\stackoverflow}[1]{\sociallink{\stackoverflowSymbol}{https://www.stackoverflow.com/u/#1}{stackoverflow.com/u/#1}}

% Render author's stackexchange profile (optional)
% Usage: \stackexchange{<stackexchange-user-id>}
\newcommand*{\stackexchange}[1]{\sociallink{\stackexchangeSymbol}{https://stackexchange.com/users/#1}{stackexchange.com/users/#1}}

% Render author's medium (optional)
% Usage: \medium{<medium-nick>}
\newcommand*{\medium}[1]{\sociallink{\mediumSymbol}{https://www.medium.com/@#1}{medium.com/#1}}

% Render author's bitbucket (optional)
% Usage: \bitbucket{<bitbucket-account-name>}
\newcommand*{\bitbucket}[1]{\sociallink{\bitbucketSymbol}{https://bitbucket.com/#1}{bitbucket.com/#1}}

% Render author's email (optional)
% Usage: \email{<email adress>}
\newcommand*{\email}[1]{\sociallink{\mailSymbol}{mailto:#1}{#1}}

% Render a website link (optional)
% Usage: \website{<website name>}{<website adress>}
\newcommand*{\website}[2]{\sociallink{\websiteSymbol}{#1}{#2}}

% Render author's mobile phone (optional)
% Usage: \smartphone{<mobile phone number>}
\newcommand*\smartphone[1]{\socialtext{\mobileSymbol}{#1}}

\newcommand*\phone[1]{\socialtext{\phoneSymbol}{#1}}

% Render author's tagline
\newcommand\resumetitle[1]{\color{accentcolor}\textbf{\large{#1}}\color{black}}

% Define social entries to print in header
\newcommand{\socialinfo}[1]{\def\@socialinfo{\null\hfill%
  % Well... this needs to be fixed
  \parbox{\widthof{\mailSymbol\hspace{1em}\small{jack.heizer@gmail.com}}}{
    \begin{itemize}[]
      #1
    \end{itemize}
  }
}}

% Render CV header
% Needs \@firstname, \@lastname and \@tagline to be defined
\newcommand*{\makecvheader}{
  \begin{minipage}[t]{0.5\textwidth}
    \user{\@firstname}{\@lastname}\\
    \resumetitle{\@tagline}
  \end{minipage}%
  \begin{minipage}[t]{0.5\textwidth}
    \small{\@socialinfo}
  \end{minipage}
  \bigskip
}

% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{#1}
  \fancyfoot[C]{#2}
  \fancyfoot[R]{#3}
}

% Resume part title definition
\newcommand\sectionTitle[2]{\section{\texorpdfstring{\color{accentcolor}#2\enspace \textsc{#1}}{#1}}}

% Define the 'keywords' environment
\newenvironment{keywords}{%
  \renewcommand{\arraystretch}{1.1}

  \begin{tabular}{>{}r>{}p{13cm}}
}{%
  \end{tabular}
}

% Render a scholarshipentry in the scolarship environment
% Usage: \scholarshipentry{<date>}{<description>}
\newcommand\keywordsentry[2]{
  \textbf{#1} &   #2\\
}

% Define a new column type for the scholarship environment
\newcolumntype{Y}{>{\raggedleft}p{\leftcolumnlength}}

% Define the 'scholarship' environment
\newenvironment{scholarship}{%
  \begin{longtable}{R{\leftcolumnlength}|E}
}{%
  \end{longtable}
}

% Usage: \scholarshipentry{<graduation date>}{degree}{school}{location}
%                                         { details }
\newcommand\scholarshipentry[5]{
  \small{\textbf{\textsc{Graduated}}} & \textbf{#2\hfill#4}\\*
  \small{\textbf{#1}} & \textbf{\textsc{#3}}\smallskip\\*
                   & \begin{minipage}[t]{\rightcolumnlength}
                        #5
                      \end{minipage}\\*
}

% Define the 'skills' environment
\newenvironment{skills}{%
  \begin{longtable}{R{\leftcolumnlength}p{\rightcolumnlength}}
}{%
  \end{longtable}
}

% Render a skill in the skills environment
% Usage: \skill{<skill>}{<level>}
\newcommand\skill[2]{
  \textbf{#1}    & \foreach \x in {1,...,5}{{\color{accentcolor!80} \ifnumgreater{\x}{#2}{\faCircle[regular]}{\faCircle}}\enspace } \\
}

\newcolumntype{E}{>{\raggedright\arraybackslash}p{\rightcolumnlength}}

% Define the 'experiences' environment
\newenvironment{experiences}{%
  \begin{longtable}{R{\leftcolumnlength}|E}
}{%
  \end{longtable}
}

% Render an experience in the experiences environment
% Usage:
% \experience
%  {<End date>}      {<Title>}{<Enterprise>}{<Country>}
%  {<Start date}     {
%                      <Experience description (Could be a list)>
%                    }
%                    {<Technology list>}
 \newcommand\experience[7]{
    \small{\textbf{#1}}     & \textbf{#2\hfill#4}\\*
    \small{\textbf{#5}}    & \textbf{\textsc{#3}}\smallskip\\*
                      & \begin{minipage}[t]{\rightcolumnlength}
  					         #6
                   \end{minipage}\\*
                 & \footnotesize{\foreach \n in {#7}{\cvtag{\n}}}\\*
  }

% Render a consultant experience in the experiences environment
% Usage:
% \consultantexperience
%  {<End date>}      {<Consultant title>}{<Consulting Enterprise>}{<Country>}
%  {<Start date}     {<Client title>}{<Client business unit>}
%                    {
%                      <Experience description (Could be a list)>
%                    }
%                    {<Technology list>}
\newcommand\consultantexperience[9]{
  \textbf{#1}    & \textbf{#2, \textsc{#3}, #4}   								\\*
  \textbf{#5}    & \emph{#6} pour \textsc{#7}                       				\\*
  				       & \begin{minipage}[t]{\rightcolumnlength}
  						        #8
                   	\end{minipage}										\\*
                 & \footnotesize{\foreach \n in {#9}{\cvtag{\n}}} 	\\
  }

\newcommand\emptySeparator{\multicolumn{2}{c}{}\\[-0.6em]}



% Define the 'projects' environment
\newenvironment{projects}{%
  \begin{longtable}{l}
}{%
  \end{longtable}
}

% Define the 'project' entry in the 'projects' environment
% Usage:
% \project
%   {<Project name>}{<dates>}
%   {<link1> <link2>}
%   {<Project description>}
%   {<techno1>,<techno2>}
\newcommand\project[5]{
  \begin{minipage}[t]{\dimexpr(\linewidth) - 1.5em}
    \textbf{\textsc{#1}} \hfill \textsc{#2}\smallskip\\
    #3\\
    #4\smallskip\\
    \footnotesize{\foreach \n in {#5}{\cvtag{\n}}}\\
  \end{minipage}
  \\*
}


\newcommand*\twocolumnsection[2]{
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 1em}
    #1
  \end{minipage}
  \hfill
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 1em}
    #2
  \end{minipage}
  }

% Define the 'referencees' environment
\newenvironment{referees}{%
  \medskip\noindent\mbox{}%\hfill%
}{%
  \mbox{}%
}

\newcommand*\referee[5]{
  \hspace{1em}
  \begin{minipage}[t]{\dimexpr(\linewidth/3 - 1em)}%
    \textbf{#1}\\%
    \textbf{#2}\\%
    \textbf{\textsc{#3}}\smallskip%
    \begin{itemize}
      \small{
        \email{#4}%
        \phone{#5}%
      }
    \end{itemize}
  \end{minipage}%
  %\hfill%
}

\newcommand*\refereeMailOnly[4]{
  \hspace{1em}
  \begin{minipage}[t]{\dimexpr(\linewidth/3) - 3em}
    \begin{tabular}{>{}l >{}l}
      \multicolumn{2}{l}{\textbf{#1}}\\
      \multicolumn{2}{l}{\emph{#2}, \textsc{#3}}\\
      \quad \mailSymbol & \href{mailto:#4}{#4} \\
    \end{tabular}
  \end{minipage}%
}

