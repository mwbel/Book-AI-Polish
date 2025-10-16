\ProvidesClass{icmsec}[2004/10/14 v0.2, by Ge Xiangyang and Zhang Lin-bo]
%
% Class Options:
%	preprint	- Preprint (default). TO BE IMPLEMENTED!!!
%	phd		- PhD thesis (default)
%	master		- Master thesis
%	makeindex	- '\uepackage{makeidx}' and '\makeindex'
%	preview		-
%	everb		- Cast verbatim environment
%
% Change log:
%	20040925: v0.2, 增加 makeindex, preview, everb 选项
%	20040920: first version (0.1)

\newif\ifPreprint\Preprinttrue
\newif\ifPhD\PhDtrue
\newif\ifMakeindex\Makeindexfalse
\newif\ifPreview\Previewfalse
\newif\ifEverb\Everbfalse

\DeclareOption{phd}{\PhDtrue\Preprintfalse}
\DeclareOption{master}{\PhDfalse\Preprintfalse}
\DeclareOption{preprint}{\Preprinttrue}
\DeclareOption{makeindex}{\Makeindextrue}
\DeclareOption{preview}{\Previewtrue}
\DeclareOption{everb}{\Everbtrue}
\ProcessOptions

\let\CCTCJKfonts=1
\LoadClass[11pt,twoside]{cctbook}[2004/09/20]
\RequirePackage{ifpdf}
\RequirePackage{graphicx}
\ifMakeindex
  \RequirePackage{makeidx}
  \AtEndDocument{\printindex}
  \makeindex
\fi

\RequirePackage{amsthm}
\RequirePackage{amsmath}

\ifEverb
  \usepackage{everb}
  %\everbsetup{number=false, boxcolor=green, fgcolor=red, escape=12}
  \everbsetup{number=false, escape=12}
  \renewenvironment{verbatim}
    {\medskip\everbatim@{verbatim}[number=false]}
    {\medskip}
\fi

\ifpdf
  \RequirePackage[CJKbookmarks,hyperindex]{hyperref}
\else
  \ifPreview
    \RequirePackage[CJKbookmarks,hypertex,hyperindex]{hyperref}
  \else
    \RequirePackage[CJKbookmarks,dvipdfm,hyperindex]{hyperref}
  \fi
\fi

\endlinechar -1

%------------------------ Page layout ----------------------------------

\headsep=8mm
\headheight=6mm
\topmargin=.5cm
\oddsidemargin=.75cm
\evensidemargin=.75cm
\textwidth=145mm
\textheight=210mm
\footskip=8mm
\doublerulesep=0.5pt

%-------------------------- Cover page ----------------------------
\let\@title\strut \let\@headtitle\strut
\renewcommand\title[2][]{\def\@title{#2}\def\@headtitle{#1}
  \ifx\@headtitle\@empty\def\@headtitle{\@title}\fi}

\let\@author\strut		\def\author#1{\def\@author{#1}}
\let\@supervisor\@empty		\def\supervisor#1{\def\@supervisor{#1}}
\let\@submissiondate\@empty	\def\submissiondate#1{\def\@submissiondate{#1}}
\let\@defensedate\@empty	\def\defensedate#1{\def\@defensedate{#1}}
\let\@chairman\@empty		\def\chairman#1{\def\@chairman{#1}}
\let\@field\@empty		\def\field#1{\def\@field{#1}}
\let\@classification\@empty	\def\classification#1{\def\@classification{#1}}
\let\@UDC\@empty		\def\UDC#1{\def\@UDC{#1}}
\let\@confidentiality\@empty \def\confidentiality#1{\def\@confidentiality{#1}}
\let\@serialno\@empty		\def\serialno#1{\def\@serialno{#1}}

\def\maketitle{
  \frontmatter
  \bgroup
  \def\entry##1##2##3{%
    \multicolumn{##1}{l}{\underline{\hbox to ##2{\hfil##3\hfil}}}}
  \renewcommand\arraystretch{1.5}
  \renewcommand\tabcolsep{\z@}
  \thispagestyle{empty}
  \setcounter{page}{0}
  \pagenumbering{roman}
  \begin{center}
  \begin{tabular}{llcll}
    分类号 & \entry{1}{3.2cm}{\@classification} & \hspace*{5cm}
    密级   & \entry{1}{3.2cm}{\@confidentiality} \\
    UDC    & \entry{1}{3.2cm}{\@UDC} & \hspace*{5cm}
    编号   & \entry{1}{3.2cm}{\@serialno}
  \end{tabular}
  \end{center}
  \vfill
  \begin{center}
    {\Huge 中国科学院研究生院\\[8pt]\ifPhD 博士\else 硕士\fi 学位论文}\\[2cm]
    {\rmfamily\Large\zihao{3}\@title}\\*[-0.7\baselineskip]
    \rule[\z@]{\textwidth}{.4\p@}\\*[2cm]
    {\large\zihao{4}\rmfamily\underline{\@author}}
  \end{center}
  \vfill
  \large\fangsong\zihao{4}
  \def\mlines##1{\vbox to\z@{\hsize 3cm\vss\baselineskip 1em\centering ##1}}
  \begin{center}
  \begin{tabular}{llll}
    指导教师	&\entry{3}{11.6cm}{\@supervisor}\\
		&\entry{3}{11.6cm}{中国科学院数学与系统科学研究院}\\
    申请学位级别&\entry{1}{3.7cm}{\ifPhD 博士\else 硕士\fi} &
    学科专业名称&\entry{1}{5cm}{\@field}\\
    论文提交日期&\entry{1}{3.7cm}{\mlines{\@submissiondate}} &
    论文答辩日期&\entry{1}{5cm}{\mlines{\@defensedate}}\\
    培养单位	&\entry{3}{11.6cm}{中国科学院数学与系统科学研究院}\\
    学位授予单位&\entry{3}{11.6cm}{中国科学院研究生院}\\
    \multicolumn{3}{r}{答辩委员会主席} & \entry{1}{4cm}{\@chairman}
  \end{tabular}
  \end{center}
  \setcounter{page}{1}
  \egroup
  %\standard@zihaofalse
}

%----------------------- Running heads ---------------------------------
\def\ps@myheadings{\global\let\@oddfoot\@empty\global\let\@evenfoot\@empty
  \gdef\@oddhead{\rm\small\leftmark\hss\thepage
	\lower1ex\llap{\rule[\z@]{\textwidth}{0.15\p@}}}
  \gdef\@evenhead{\rm\small\thepage\hss\@headtitle
	\lower1ex\llap{\rule[\z@]{\textwidth}{0.15\p@}}}
}
\pagestyle{empty}

%------------------------ Abstract & Keywords -------------------------
\newenvironment{abstract}[1][]
  {\cleardoublepage\setcounter{page}{1}\pagestyle{myheadings}
   \chapter{摘^^a1^^a1要}
   \def\English##1##2##3{{\clearpage  
   \renewcommand\baselinestretch{1}
     \@openrighttrue\chapter*{##1}
     \begin{center}
       ##2\\
       Directed by ##3
     \end{center}\bigskip\par}}}
     {\cleardoublepage\tableofcontents\aftergroup\mainmatter\setcounter{page}{0}
      \setcounter{chapter}{0}}

%------------------------ Chapters/sections -------------------------
\def\chapterformat{\Large\bfseries\centering}
\def\sectionformat{\large\bfseries}
\def\subsectionformat{\bfseries}
\def\subsubsectionformat{\normalfont\rm}

%----------------------- Theorems -----------------------------------
\newtheorem{theorem}{{定理}}[section]
\newtheorem{proposition}{{命题}}[section]
\newtheorem{lemma}{{引理}}[section]
\newtheorem{corollary}{{推论}}[section]
\newtheorem{definition}{{定义}}[section]
\newtheorem{example}{{例}}[section]
\newtheorem{remark}{{注}}[section]
\newtheorem{notation}{{记号}}[section]
\newtheorem{algorithm}{{算法}}[section]
\renewcommand\proofname{证明}
\newcommand{\resl}{{\rm\mbox{resl}}}
%\makeatletter
%\newcommand{\rmnum}[1]{\romannumeral #1}
%%\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}
%\makeatother
%----------------------------notation--------------------------------
\def\K{\bf K}
\def\E{\bar{\mathbb Q}}
\def\F{\hbox{\bf F}}
\def\L{\hbox{\bf L}}
\def\I{\hbox{\bf I}}
\def\Q{\hbox{\bf Q}}
\def\A{{\mathcal A}}
%\def\S{{\mathcal S}}
\def\C{{\mathcal C}}
\def\M{{\mathcal M}}
\def\Z{\hbox{\bf Z}}
\def\D{{\mathcal D}}
\def\V{{\mathcal V}}
\def\T{{\mathcal T}}
\def\GCD{\mbox{GCD}}

\newcommand{\ord}{{\rm ord}}
\newcommand{\zero}{{\rm zero}}
\newcommand{\Zero}{{\rm Zero}}
\newcommand{\tdeg}{{\rm tdeg}}
\newcommand{\mat}{{\rm Mat}}
\newcommand{\diag}{{\rm\mbox{diag}}}
\newcommand{\proj}{{\rm Proj}}
\newcommand{\prem}{{\rm prem}}
\newcommand{\Ideal}{{\rm Ideal}}
\newcommand{\ID}{{\hbox{\bf ID}}}
\newcommand{\IM}{{\hbox{\bf IM}}}
\newcommand{\SAT}{{\hbox{\bf SAT}}}
\newcommand{\PS}{{\hbox{\bf PS}}}
\newcommand{\DS}{{\hbox{\bf DS}}}
\newcommand{\ini}{{\rm ini}}
\newcommand{\IRR}{{\hbox{\bf IRR}}}

%----------------------- Appendices ---------------------------------
\renewcommand\appendixname{附录\,\Alph{chapter}}

%----------------------- Publications -------------------------------
\newenvironment{publications}[1]
  {\renewcommand\bibname{发表文章目录}\begin{thebibliography}{#1}}
  {\end{thebibliography}}

%----------------------- Acknowledgement ----------------------------
\newcommand\acknowledgement{\backmatter\chapter{致^^a1^^a1谢}}

%----------------------- Caption ------------------------------------
\setlength\abovecaptionskip{7\p@}
\setlength\belowcaptionskip{7\p@}

\raggedbottom

\endlinechar `\^^M
\endinput
