;;ORG MODE LATEX CONFIG
(require 'ox-latex)
;; (unless (boundp 'org-latex-classes)
;;   (setq org-latex-classes nil))





(setq org-latex-classes nil)

(add-to-list 'org-latex-classes
  '("article_no_refs_no_headings"
     "\\documentclass[12pt]{article}
                [NO-DEFAULT-PACKAGES]
                [NO-EXTRA]
                \\usepackage{hyperref}
                \\usepackage[utf8]{inputenc}
                \\usepackage{tgbonum}
                \\usepackage{fancyhdr}
                \\usepackage{setspace}
                \\onehalfspacing
                \\usepackage[a4paper, total={6in, 9in}]{geometry}

                \\pagestyle{fancy}
                \\fancyhf{}
                \\renewcommand{\\headrulewidth}{0pt}
                \\renewcommand{\\maketitle}{}

                \\cfoot {Johannes Aengenheyster, i6089238}
                \\rfoot {\\thepage}

                \\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  )


(add-to-list 'org-latex-classes

  '("article_usual"
     "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage[hyphenbreaks]{breakurl}

\\usepackage{tgbonum}
\\usepackage[utf8]{inputenc}
\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\usepackage[T1]{fontenc}
\\usepackage{csquotes}

\\addbibresource{references.bib}


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\onehalfspacing
\\usepackage[a4paper, total={6in, 9in}]{geometry}

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\maketitle}{}

\\cfoot {Johannes Aengenheyster, i6089238}
\\rfoot {\\thepage}

\\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  )

;;\\usepackage[default]{lato}
;; \\usepackage{tgbonum}

(add-to-list 'org-latex-classes

  '("article_compact"
     "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage[hyphenbreaks]{breakurl}
\\usepackage{graphicx}

\\usepackage[utf8]{inputenc}
\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\usepackage[T1]{fontenc}
\\usepackage{csquotes}

\\addbibresource{references.bib}

\\usepackage{enumitem}
\\setlist[1]{itemsep=-5pt}


\\usepackage{tgbonum}
\\usepackage{fancyhdr}
\\usepackage{setspace}
\\onehalfspacing
\\usepackage[a4paper, total={6in, 9in}]{geometry}

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\maketitle}{}

\\cfoot {Johannes Aengenheyster, i6089238}
\\rfoot {\\thepage}

\\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section{%s}")
     ("\\subsection{%s}" . "\\subsection{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph{%s}"))
  )


(add-to-list 'org-latex-classes

  '("notes"
     "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage{breakurl}
\\usepackage{ulem}

\\usepackage[default]{lato}
\\usepackage[utf8x]{inputenc}
\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\usepackage[T1]{fontenc}
\\usepackage{csquotes}


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\onehalfspacing
\\usepackage[a4paper, total={7in, 9in}]{geometry}

\\usepackage{enumitem}
\\setlist[1]{itemsep= -22pt}


\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}

\\rfoot {\\thepage}

\\setlength{\\parindent}{0cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  )

(add-to-list 'org-latex-classes

  ;; \\usepackage{ucs}

  ;; \\setlist[1]{itemsep=-18pt}

  '("notes2"
     "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage{breakurl}
\\usepackage{ulem}
\\usepackage{graphicx}
\\usepackage{pdflscape}
\\usepackage{dcolumn} %% for tables with columns aligned on decimal point
\\usepackage{placeins}  %% for FloatBarrier

\\usepackage[utf8]{inputenc}

\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}

\\addbibresource{/home/johannes/Dropbox/references.bib}


\\usepackage[scaled=.98,space]{erewhon}
\\usepackage{csquotes}


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\onehalfspacing
\\usepackage[a4paper, total={6in, 9in}, right=5cm]{geometry}
\\setlength{\\marginparwidth}{4cm}

\\usepackage[draft]{todonotes}


\\usepackage{enumitem}

\\let\\OLDitemize\\itemize
\\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}

%% undo some weird list item spacing: multiline items are forced into overlap
%% \\renewcommand\\itemize{\\OLDitemize\\setlength{\\itemsep}{-10pt}} 





\\usepackage[T1]{fontenc}


\\singlespace

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}

\\rfoot {\\thepage}

\\setlength{\\parindent}{0cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  )


;; \\textless
;; \\textgreater
;;\\setlist[itemize]{nolistsep, topsep=0pt}


;; \\usepackage[style=apa, backend=biber]{biblatex} 
;; \\usepackage[english, american]{babel}
;; \\DeclareLanguageMapping{american}{american-apa}
;; \\usepackage[T1]{fontenc}




;; \\usepackage{tgbonum}
;;\\usepackage[default]{lato}


;; \\usepackage[default]{lato}

;; \\setlist[1]{itemsep=-5pt}

;; \\usepackage[hidelinks]{hyperref}

(add-to-list 'org-latex-classes

  '("article_usual2"
     "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage[hyphenbreaks]{breakurl}
\\usepackage{rotating}
\\usepackage{wrapfig}
\\usepackage{pdflscape}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{amsmath}
\\usepackage{datetime}
\\usepackage{amsfonts}
\\usepackage[section]{placeins}
\\usepackage{dirtree}
\\usepackage{siunitx}
\\usepackage{afterpage}
\\usepackage{pdflscape}
\\usepackage{svg}
\\usepackage[export]{adjustbox}


\\usepackage{booktabs}
\\usepackage{dcolumn}
\\makeatletter
\\newcolumntype{D}[3]{>{\\textfont0=\\the\\font\\DC@{#1}{#2}{#3}}c<{\\DC@end}}
\\makeatother


\\newcolumntype{L}{>{$}l<{$}}

\\usepackage{bibentry}

\\sisetup{detect-all}

\\sloppy
\\usepackage{scalerel,stackengine}

\\stackMath
\\newcommand\\reallywidehat[1]{%
\\savestack{\\tmpbox}{\\stretchto{%
  \\scaleto{%
    \\scalerel*[\\widthof{\\ensuremath{#1}}]{\\kern-.6pt\\bigwedge\\kern-.6pt}%
    {\\rule[-\\textheight/2]{1ex}{\\textheight}}%WIDTH-LIMITED BIG WEDGE
  }{\\textheight}% 
}{0.5ex}}%
\\stackon[1pt]{#1}{\\tmpbox}%
}

\\usepackage{caption}
\\usepackage[draft]{todonotes}

\\captionsetup{skip=0pt}
\\usepackage[utf8]{inputenc}
\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\DeclareFieldFormat{apacase}{#1}

\\usepackage[T1]{fontenc}
\\usepackage{csquotes}

\\addbibresource{/home/johannes/Dropbox/references.bib}
\\addbibresource{/home/johannes/Dropbox/references2.bib}

\\usepackage{floatrow}

\\usepackage{listings}
\\usepackage{xcolor}
\\usepackage{colortbl}

\\lstset{
  language=R,                    
  basicstyle=\\footnotesize,      
  numbers=left,                  
  numberstyle=\\tiny\\color{gray}, 
  stepnumber=1,                  
  numbersep=5pt,                 
  backgroundcolor=\\color{white}, 
  showspaces=false,              
  showstringspaces=false,        
  showtabs=false,                
  frame=single,                  
  rulecolor=\\color{black},       
  tabsize=2,                     
  captionpos=b,                  
  breaklines=true,               
  breakatwhitespace=false,       
  title=\\lstname,                
  keywordstyle=\\color{red},     
  commentstyle=\\color{blue},  
  stringstyle=\\color{violet},     
  escapeinside={\\%*}{*)},        
  morekeywords={*,...}           
} 




\\usepackage{crimson}
\\usepackage{microtype}


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\singlespace
\\usepackage{longtable}
\\usepackage{subfig}
\\usepackage[a4paper, total={18cm, 24cm}]{geometry}

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\maketitle}{}

\\usepackage{enumitem}
\\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}

\\usepackage{multicol}
\\setlength\\multicolsep{0pt}

\\usepackage{array}
\\usepackage{caption}
\\usepackage{graphicx}
\\usepackage{siunitx}
\\usepackage[normalem]{ulem}
\\usepackage{colortbl}
\\usepackage{multirow}
\\usepackage{hhline}
\\usepackage{calc}
\\usepackage{tabularx}
\\usepackage{threeparttable}
\\usepackage{wrapfig}
\\usepackage{adjustbox}
\\usepackage{hyperref}



\\newlist{propertyList}{itemize}{1}
\\setlist[propertyList]{
  label=\\textbullet,
  noitemsep,
  leftmargin=10pt,
  before=\\begin{multicols}{3},
  after=\\end{multicols}
  }

\\cfoot {Johannes Aengenheyster}
\\rfoot {\\thepage}

\\listfiles

\\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

  )

(add-to-list 'org-latex-classes

  '("article_poetics"
     "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage[hyphenbreaks]{breakurl}
\\usepackage{rotating}
\\usepackage{wrapfig}
\\usepackage{pdflscape}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{amsmath}
\\usepackage{amsfonts}
\\usepackage[section]{placeins}
\\usepackage{dirtree}
\\usepackage{siunitx}
\\usepackage{afterpage}
\\usepackage{pdflscape}
\\usepackage{svg}
\\usepackage[export]{adjustbox}


\\usepackage{booktabs}
\\usepackage{dcolumn}
\\makeatletter
\\newcolumntype{D}[3]{>{\\textfont0=\\the\\font\\DC@{#1}{#2}{#3}}c<{\\DC@end}}
\\makeatother


\\newcolumntype{L}{>{$}l<{$}}

\\usepackage{bibentry}

\\sisetup{detect-all}

\\sloppy
\\usepackage{scalerel,stackengine}

\\stackMath
\\newcommand\\reallywidehat[1]{%
\\savestack{\\tmpbox}{\\stretchto{%
  \\scaleto{%
    \\scalerel*[\\widthof{\\ensuremath{#1}}]{\\kern-.6pt\\bigwedge\\kern-.6pt}%
    {\\rule[-\\textheight/2]{1ex}{\\textheight}}%WIDTH-LIMITED BIG WEDGE
  }{\\textheight}% 
}{0.5ex}}%
\\stackon[1pt]{#1}{\\tmpbox}%
}

\\usepackage{caption}
\\usepackage[draft]{todonotes}

\\captionsetup{skip=0pt}
\\usepackage[utf8]{inputenc}
\\usepackage[style=apa, backend=biber, refsegment=section]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\DeclareFieldFormat{apacase}{#1}

\\usepackage[T1]{fontenc}
\\usepackage{csquotes}

\\addbibresource{/home/johannes/Dropbox/references.bib}
\\addbibresource{/home/johannes/Dropbox/references2.bib}

\\usepackage{floatrow}

\\usepackage{listings}
\\usepackage{xcolor}
\\usepackage{colortbl}

\\lstset{
  language=R,                    
  basicstyle=\\footnotesize,      
  numbers=left,                  
  numberstyle=\\tiny\\color{gray}, 
  stepnumber=1,                  
  numbersep=5pt,                 
  backgroundcolor=\\color{white}, 
  showspaces=false,              
  showstringspaces=false,        
  showtabs=false,                
  frame=single,                  
  rulecolor=\\color{black},       
  tabsize=2,                     
  captionpos=b,                  
  breaklines=true,               
  breakatwhitespace=false,       
  title=\\lstname,                
  keywordstyle=\\color{red},     
  commentstyle=\\color{blue},  
  stringstyle=\\color{violet},     
  escapeinside={\\%*}{*)},        
  morekeywords={*,...}           
} 




\\usepackage{crimson}
\\usepackage{microtype}


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\singlespace
\\usepackage{longtable}
\\usepackage{subfig}
\\usepackage[a4paper, total={18cm, 24cm}]{geometry}

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\maketitle}{}

\\usepackage{enumitem}
\\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}

\\usepackage{multicol}
\\setlength\\multicolsep{0pt}

\\usepackage{array}
\\usepackage{caption}
\\usepackage{graphicx}
\\usepackage{siunitx}
\\usepackage[normalem]{ulem}
\\usepackage{colortbl}
\\usepackage{multirow}
\\usepackage{hhline}
\\usepackage{calc}
\\usepackage{tabularx}
\\usepackage{threeparttable}
\\usepackage{wrapfig}
\\usepackage{adjustbox}
\\usepackage{hyperref}



\\newlist{propertyList}{itemize}{1}
\\setlist[propertyList]{
  label=\\textbullet,
  noitemsep,
  leftmargin=10pt,
  before=\\begin{multicols}{3},
  after=\\end{multicols}
  }

\\rfoot {\\thepage}

\\listfiles

\\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section{%s}")
     ("\\subsection{%s}" . "\\subsection{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph{%s}"))

  )


(add-to-list 'org-latex-classes

  '("article_egos"
     "\\documentclass[12pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage[hyphenbreaks]{breakurl}
\\usepackage{rotating}
\\usepackage{wrapfig}
\\usepackage{pdflscape}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{amsmath}
\\usepackage{amsfonts}
\\usepackage[section]{placeins}
\\usepackage{dirtree}
\\usepackage{siunitx}
\\usepackage{afterpage}
\\usepackage{pdflscape}
\\usepackage{svg}


\\usepackage{booktabs}
\\usepackage{dcolumn}

\\usepackage{bibentry}

\\sisetup{detect-all}

\\sloppy
\\usepackage{scalerel,stackengine}

\\stackMath
\\newcommand\\reallywidehat[1]{%
\\savestack{\\tmpbox}{\\stretchto{%
  \\scaleto{%
    \\scalerel*[\\widthof{\\ensuremath{#1}}]{\\kern-.6pt\\bigwedge\\kern-.6pt}%
    {\\rule[-\\textheight/2]{1ex}{\\textheight}}%WIDTH-LIMITED BIG WEDGE
  }{\\textheight}% 
}{0.5ex}}%
\\stackon[1pt]{#1}{\\tmpbox}%
}

\\usepackage{caption}
\\usepackage[draft]{todonotes}

\\captionsetup{skip=0pt}
\\usepackage[utf8]{inputenc}
\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\DeclareFieldFormat{apacase}{#1}

\\usepackage[T1]{fontenc}
\\usepackage{csquotes}

\\addbibresource{/home/johannes/Dropbox/references.bib}
\\addbibresource{/home/johannes/Dropbox/references2.bib}

\\usepackage{floatrow}

\\usepackage{listings}
\\usepackage{xcolor}
\\usepackage{colortbl}

\\lstset{
  language=R,                    
  basicstyle=\\footnotesize,      
  numbers=left,                  
  numberstyle=\\tiny\\color{gray}, 
  stepnumber=1,                  
  numbersep=5pt,                 
  backgroundcolor=\\color{white}, 
  showspaces=false,              
  showstringspaces=false,        
  showtabs=false,                
  frame=single,                  
  rulecolor=\\color{black},       
  tabsize=2,                     
  captionpos=b,                  
  breaklines=true,               
  breakatwhitespace=false,       
  title=\\lstname,                
  keywordstyle=\\color{red},     
  commentstyle=\\color{blue},  
  stringstyle=\\color{violet},     
  escapeinside={\\%*}{*)},        
  morekeywords={*,...}           
} 




% \\usepackage{crimson}
% \\usepackage{microtype}

% \\usepackage{helvet}
% \\renewcommand{\\familydefault}{\\sfdefault}

\\usepackage{tgtermes} % times font


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\onehalfspacing
\\usepackage{longtable}
\\usepackage{subfig}
% \\usepackage[a4paper, total={18cm, 24cm}]{geometry}
\\usepackage[a4paper, margin=2.5cm]{geometry}

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\maketitle}{}

\\usepackage{enumitem}
\\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}

\\usepackage{multicol}
\\setlength\\multicolsep{0pt}



\\newlist{propertyList}{itemize}{1}
\\setlist[propertyList]{
  label=\\textbullet,
  noitemsep,
  leftmargin=10pt,
  before=\\begin{multicols}{3},
  after=\\end{multicols}
  }

% \\cfoot {Johannes Aengenheyster}
\\rfoot {\\thepage}

\\listfiles

\\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

  )

(add-to-list 'org-latex-classes

  '("article_euram"
     "\\documentclass[12pt]{article}
[NO-DEFAULT-PACKAGES]
[NO-EXTRA]

\\usepackage[hyphens]{url}                
\\usepackage{hyperref}
\\usepackage[hyphenbreaks]{breakurl}
\\usepackage{rotating}
\\usepackage{wrapfig}
\\usepackage{pdflscape}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{amsmath}
\\usepackage{amsfonts}
\\usepackage[section]{placeins}
\\usepackage{dirtree}
\\usepackage{siunitx}
\\usepackage{afterpage}
\\usepackage{pdflscape}
\\usepackage{svg}


\\usepackage{booktabs}
\\usepackage{dcolumn}

\\usepackage{bibentry}

\\sisetup{detect-all}

\\sloppy
\\usepackage{scalerel,stackengine}

\\stackMath
\\newcommand\\reallywidehat[1]{%
\\savestack{\\tmpbox}{\\stretchto{%
  \\scaleto{%
    \\scalerel*[\\widthof{\\ensuremath{#1}}]{\\kern-.6pt\\bigwedge\\kern-.6pt}%
    {\\rule[-\\textheight/2]{1ex}{\\textheight}}%WIDTH-LIMITED BIG WEDGE
  }{\\textheight}% 
}{0.5ex}}%
\\stackon[1pt]{#1}{\\tmpbox}%
}

\\usepackage{caption}
\\usepackage[draft]{todonotes}

\\captionsetup{skip=0pt}
\\usepackage[utf8]{inputenc}
\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\DeclareFieldFormat{apacase}{#1}

\\usepackage[T1]{fontenc}
\\usepackage{csquotes}

\\addbibresource{/home/johannes/Dropbox/references.bib}
\\addbibresource{/home/johannes/Dropbox/references2.bib}

\\usepackage{floatrow}

\\usepackage{listings}
\\usepackage{xcolor}
\\usepackage{colortbl}

\\lstset{
  language=R,                    
  basicstyle=\\footnotesize,      
  numbers=left,                  
  numberstyle=\\tiny\\color{gray}, 
  stepnumber=1,                  
  numbersep=5pt,                 
  backgroundcolor=\\color{white}, 
  showspaces=false,              
  showstringspaces=false,        
  showtabs=false,                
  frame=single,                  
  rulecolor=\\color{black},       
  tabsize=2,                     
  captionpos=b,                  
  breaklines=true,               
  breakatwhitespace=false,       
  title=\\lstname,                
  keywordstyle=\\color{red},     
  commentstyle=\\color{blue},  
  stringstyle=\\color{violet},     
  escapeinside={\\%*}{*)},        
  morekeywords={*,...}           
} 




% \\usepackage{crimson}
% \\usepackage{microtype}

% \\usepackage{helvet}
% \\renewcommand{\\familydefault}{\\sfdefault}

\\usepackage{tgtermes} % times font


\\usepackage{fancyhdr}
\\usepackage{setspace}
\\doublespacing
\\usepackage{longtable}
\\usepackage{subfig}
% \\usepackage[a4paper, total={18cm, 24cm}]{geometry}
\\usepackage[a4paper, margin=2.5cm]{geometry}

\\pagestyle{fancy}
\\fancyhf{}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\maketitle}{}

\\usepackage{enumitem}
\\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}

\\usepackage{multicol}
\\setlength\\multicolsep{0pt}



\\newlist{propertyList}{itemize}{1}
\\setlist[propertyList]{
  label=\\textbullet,
  noitemsep,
  leftmargin=10pt,
  before=\\begin{multicols}{3},
  after=\\end{multicols}
  }

% \\cfoot {Johannes Aengenheyster}
\\rfoot {\\thepage}

\\listfiles

\\setlength{\\parindent}{1.2cm}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

  )

(add-to-list 'org-latex-classes

  '("beamer_presi"
     "\\documentclass[t]{beamer}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{capt-of}
\\usepackage{hyperref}
\\usetheme{default}
\\author{Johannes Aengenheyster}

\\setcounter{tocdepth}{2}

% \\setbeamertemplate{itemizeitem}{\\scriptsize$\\diamond$}
% \\setbeamertemplate{itemize subitem}{\\scriptsize$\\blacktriangleright$}
% \\setbeamertemplate{itemize subsubitem}{\\scriptsize$\\odot$}"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\frame*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}")


     )
  )

(add-to-list 'org-latex-classes

'("beamer_presi2"
     "\\documentclass[aspectratio=169, 14pt, t]{beamer}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{tikz}    
\\usepackage{booktabs}
\\usepackage{dcolumn}

\\setbeamertemplate{itemize items}[circle]
\\usepackage{bibentry}
\\usepackage[style=apa, backend=biber]{biblatex}
\\addbibresource{/home/johannes/Dropbox/references.bib}
\\addbibresource{/home/johannes/Dropbox/references2.bib}
\\setbeamercolor{section in head/foot}{fg=black,bg=white}
\\beamertemplatenavigationsymbolsempty
\\makeatletter
\\setbeamertemplate{footline}{%
  \\begin{beamercolorbox}[ht=2.25ex,dp=3.75ex]{section in head/foot}
    \\insertnavigation{\\paperwidth}
  \\end{beamercolorbox}%
}%
\\makeatother

\\usepackage[style=apa, backend=biber]{biblatex} 
\\usepackage[english, american]{babel}
\\DeclareLanguageMapping{american}{american-apa}
\\DeclareFieldFormat{apacase}{#1}




\\author{Johannes Aengenheyster}

\\setcounter{tocdepth}{2}

"

     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\frame*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
     ;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}")


     )
  )


;; ** elsevier article (added for poetics)

(setq elsearticle-preamble
  (mapconcat 'identity
    (list
      "\\documentclass[11pt, authoryear]{elsarticle}"
      "[NO-DEFAULT-PACKAGES]"
      ;; "[NO-EXTRA]"
      ""
      "\\usepackage[hyphens]{url}"                
      "\\usepackage{hyperref}"
      "\\usepackage[hyphenbreaks]{breakurl}"
      "\\usepackage{rotating}"
      "\\usepackage{wrapfig}"
      "\\usepackage{pdflscape}"
      "\\usepackage{fixltx2e}"
      "\\usepackage{graphicx}"
      "\\usepackage{amsmath}"
      "\\usepackage{amsfonts}"
      "\\usepackage[section]{placeins}"
      "\\usepackage{dirtree}"
      "\\usepackage{siunitx}"
      "\\usepackage{afterpage}"
      "\\usepackage{pdflscape}"
      "\\usepackage{svg}"
      "\\usepackage[export]{adjustbox}"
      ""
      "\\usepackage{booktabs}"
      "\\usepackage{dcolumn}"
      "\\makeatletter"
      "\\newcolumntype{D}[3]{>{\\textfont0=\\the\\font\\DC@{#1}{#2}{#3}}c<{\\DC@end}}"
      "\\makeatother"

      "\\newcolumntype{L}{>{$}l<{$}}"

      "\\sisetup{detect-all}"

      ;; "\\usepackage{natbib}"
      ;; "\\usepackage[english, american]{babel}"
      ;; "\\DeclareLanguageMapping{american}{american-apa}"
      ;; "\\DeclareFieldFormat{apacase}{#1}"
      

      "\\sloppy"
      "\\usepackage{scalerel,stackengine}"

      "\\usepackage{caption}"
      "\\usepackage[draft]{todonotes}"

      "\\captionsetup{skip=0pt}"
      "\\usepackage[utf8]{inputenc}"

      "\\usepackage[T1]{fontenc}"
      "\\usepackage{csquotes}"

      "\\usepackage{floatrow}"

      "\\usepackage{listings}"
      "\\usepackage{xcolor}"
      "\\usepackage{colortbl}"

      "\\lstset{"
      "language=R,"
      "  basicstyle=\\footnotesize,"
      "  numbers=left,"
      "  numberstyle=\\tiny\\color{gray},"
      "  stepnumber=1,"
      "  numbersep=5pt,"
      "  backgroundcolor=\\color{white},"
      "  showspaces=false,"
      "  showstringspaces=false,"
      "  showtabs=false,"
      "  frame=single,"
      "  rulecolor=\\color{black},"
      "  tabsize=2,"
      "  captionpos=b,"
      "  breaklines=true,"
      "  breakatwhitespace=false,"
      "  title=\\lstname,"
      "  keywordstyle=\\color{red},"
      "  commentstyle=\\color{blue},"
      "  stringstyle=\\color{violet},"
      "  escapeinside={\\%*}{*)},"
      "  morekeywords={*,...}"
      "}"
      
      "\\usepackage{crimson}"
      "\\usepackage{microtype}"
      ""
      ""
      "\\usepackage{fancyhdr}"
      "\\usepackage{setspace}"
      "\\singlespace"
      "\\usepackage{longtable}"
      "\\usepackage{subfig}"
      "\\usepackage[a4paper, total={18cm, 24cm}]{geometry}"
      ""
      "\\pagestyle{fancy}"
      "\\fancyhf{}"
      "\\renewcommand{\\headrulewidth}{0pt}"
      "\\renewcommand{\\maketitle}{}"
      ""
      "\\usepackage{enumitem}"
      "\\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}"
      ""
      "\\usepackage{multicol}"
      "\\setlength{\\multicolsep}{0pt}"

      "\\usepackage{array}"
      "\\usepackage{caption}"
      "\\usepackage{graphicx}"
      "\\usepackage{siunitx}"
      "\\usepackage[normalem]{ulem}"
      "\\usepackage{colortbl}"
      "\\usepackage{multirow}"
      "\\usepackage{hhline}"
      "\\usepackage{calc}"
      "\\usepackage{tabularx}"
      "\\usepackage{threeparttable}"
      "\\usepackage{wrapfig}"
      "\\usepackage{adjustbox}"
      "\\usepackage{hyperref}"
      ""
      "\\newlist{propertyList}{itemize}{1}"
      "\\setlist[propertyList]{"
      "label=\\textbullet,"
      "noitemsep,"
      "leftmargin=10pt,"
      "before=\\begin{multicols}{3},"
      "after=\\end{multicols}"
      "}"
      ""
      "\\rfoot {\\thepage}"

      "\\setlength{\\parindent}{1.2cm}"      
      "\\listfiles"

      ""

      )
    "\n")
  )

(add-to-list 'org-latex-classes
  
  `("elsarticle"
     ,elsearticle-preamble
     
     ("\\section{%s}" . "\\section{%s}")
     ("\\subsection{%s}" . "\\subsection{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection{%s}")
     ("\\subsubsubsection{%s}" . "\\paragraph{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph{%s}"))

  )



;; \\usepackage{underscore}


;; ("\\section{%s}" . "\\section{%s}")
;; ("\\subsection{%s}" . "\\subsection{%s}")
;; ("\\subsubsection{%s}" . "\\subsubsection{%s}")
;; ("\\subsubsubsection{%s}" . "\\paragraph{%s}")
;; ("\\subparagraph{%s}" . "\\subparagraph{%s}")

;; \\usepackage{libertine}

;; \\usepackage{amsmath}


;; \\usepackage[default]{lato}
;; \\usepackage{libertinust1math}
;; \\usepackage[bitstream-charter]{mathdesign}


;; ("\\subsubsubsection{%s}" . "\\subsubsubsection*{%s}")


;; (add-to-list 'org-latex-classes

;; '("article_usual21"
;; "\\documentclass[11pt]{article}
;; [NO-DEFAULT-PACKAGES]
;; [NO-EXTRA]

;; \\usepackage[hyphens]{url}                
;; \\usepackage{hyperref}
;; \\usepackage[hyphenbreaks]{breakurl}

;; \\usepackage{fixltx2e}
;; \\usepackage{graphicx}


;; \\usepackage[utf8]{inputenc}
;; \\usepackage[style=apa, backend=biber]{biblatex} 
;; \\usepackage[english, american]{babel}
;; \\DeclareLanguageMapping{american}{american-apa}
;; \\usepackage[T1]{fontenc}
;; \\usepackage{csquotes}

;; \\addbibresource{references.bib}

;; \\usepackage[default]{lato}
;; \\usepackage{fancyhdr}
;; \\usepackage{setspace}
;; \\doublespacing
;; \\usepackage[a4paper, total={6in, 9in}]{geometry}

;; \\pagestyle{fancy}
;; \\fancyhf{}
;; \\renewcommand{\\headrulewidth}{0pt}
;; \\renewcommand{\\maketitle}{}

;; \\usepackage{enumitem}
;; \\setlist[1]{itemsep=-10pt}


;; \\cfoot {Johannes Aengenheyster, i6089238}
;; \\rfoot {\\thepage}

;; \\setlength{\\parindent}{0cm}"

;; ("\\section{%s}" . "\\section*{%s}")
;; ("\\subsection{%s}" . "\\subsection*{%s}")
;; ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
;; )




;; (add-to-list 'org-latex-classes

;; '("article_usual3"
;; "\\documentclass[11pt]{article}
;; [NO-DEFAULT-PACKAGES]
;; [NO-EXTRA]

;; \\usepackage[hyphens]{url}                
;; \\usepackage{hyperref}
;; \\usepackage[hyphenbreaks]{breakurl}

;; \\usepackage{graphicx}
;; \\usepackage{wrapfig}
;; \\usepackage{amscd}


;; \\usepackage{fixltx2e}

;; \\usepackage[utf8]{inputenc}
;; \\usepackage[style=apa, backend=biber]{biblatex} 
;; \\usepackage[english, american]{babel}
;; \\DeclareLanguageMapping{american}{american-apa}
;; \\usepackage[T1]{fontenc}
;; \\usepackage{csquotes}

;; \\addbibresource{references.bib}

;; \\usepackage[default]{lato}
;; \\usepackage{fancyhdr}
;; \\usepackage{setspace}
;; \\onehalfspacing
;; \\usepackage[a4paper, total={6in, 9in}]{geometry}

;; \\pagestyle{fancy}
;; \\fancyhf{}
;; \\renewcommand{\\headrulewidth}{0pt}
;; \\renewcommand{\\maketitle}{}

;; \\usepackage{enumitem}
;; \\setlist[1]{itemsep=-10pt}


;; \\cfoot {Johannes Aengenheyster, i6089238}
;; \\rfoot {\\thepage}

;; \\setlength{\\parindent}{1.2cm}"

;; ("\\section{%s}" . "\\section*{%s}")
;; ("\\subsection{%s}" . "\\subsection*{%s}")
;; ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; ("\\subsubsubsection{%s}" . "\\paragraph*{%s}")
;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
;; )

;; ;; \\doublespacing


;; ;;REFTEX SETUP (i guess)
;; (setq-default TeX-master t)
;; (setq reftex-bibliography-commands '("bibliography" "nobibliograph" "addbibresource"))
;; (setq reftex-default-bibliography (quote ("references.bib")))


;; (defun na-org-mode-reftex-setup ()
;;   (interactive)
;;   (load-library "reftex")
;;   (and (buffer-file-name)
;;        (file-exists-p (buffer-file-name))
;;        (reftex-parse-all))
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation))

;; (add-hook 'org-mode-hook 'na-org-mode-reftex-setup)
;; ;; END OF REFTEX SETUP (i guess)


  ;; (setq reftex-cite-format ;; idk if good here
  ;;   '((?c . "\\cite[]{%l}")
  ;;      (?f . "\\footcite[][]{%l}")
  ;;      (?t . "\\textcite[]{%l}")
  ;;      (?p . "\\parencite[]{%l}")
  ;;      (?o . "\\citepr[]{%l}")
  ;;      (?n . "\\nocite{%l}")))


(setq org-latex-hyperref-template "\\hypersetup{
 colorlinks=false,
 pdfauthor={%a},
 pdftitle={%t},
 pdfkeywords={%k},
 pdfsubject={%d},
 pdfcreator={%c},
 pdflang={%L}}"
  )
