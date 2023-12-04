%%{
  machine latex;






comment='%' (any{1,100}-'\n') '\n';

math_begin = '\\begin{math}' @{n++; };
   math_end  = '\\end{math}' @{n--; };
	 math_body = any+ - (math_begin|math_end);
   math = '\\begin{math}' @{n=1;}  (math_begin|math_end|math_body)*    math_end  :> any when{!n};

   equation_begin = '\\begin{equation}' @{n++; };
   equation_end  = '\\end{equation}' @{n--; }; 
	 equation_body = any+ - (equation_begin|equation_end);
   equation = '\\begin{equation}' @{n=1;}  (equation_begin|equation_end|equation_body)*    equation_end  :> any when{!n};


eqnarray_begin = '\\begin{eqnarray}' @{n++; };
   eqnarray_end  = '\\end{eqnarray}' @{n--; };
	 eqnarray_body = any+ - (eqnarray_begin|eqnarray_end);
   eqnarray = '\\begin{eqnarray}' @{n=1;}  (eqnarray_begin|eqnarray_end|eqnarray_body)*    eqnarray_end  :> any when{!n};

   figure_begin = '\\begin{figure}' @{n++; };
   figure_end  = '\\end{figure}' @{n--; };
	 figure_body = any+ - (figure_begin|figure_end);
   figure = '\\begin{figure}' @{n=1;}  (figure_begin|figure_end|figure_body)*    figure_end  :> any when{!n};

   array_begin = '\\begin{array}' @{n++; };
   array_end  = '\\end{array}' @{n--; };
	 array_body = any+ - (array_begin|array_end);
   array = '\\begin{array}' @{n=1;}  (array_begin|array_end|array_body)*    array_end  :> any when{!n};

   center_begin = '\\begin{center}' @{n++; };
   center_end  = '\\end{center}' @{n--; };
	 center_body = any+ - (center_begin|center_end);
   center = '\\begin{center}' @{n=1;}  (center_begin|center_end|center_body)*    center_end  :> any when{!n};

   align_begin = '\\begin{align}' @{n++; };
   align_end  = '\\end{align}' @{n--; };
	 align_body = any+ - (align_begin|align_end);
   align = '\\begin{align}' @{n=1;}  (align_begin|align_end|align_body)*    align_end  :> any when{!n};

   tabular_begin = '\\begin{tabular}' @{n++; };
   tabular_end  = '\\end{tabular}' @{n--; };
	 tabular_body = any+ - (tabular_begin|tabular_end);
   tabular = '\\begin{tabular}' @{n=1;}  (tabular_begin|tabular_end|tabular_body)*    tabular_end  :> any when{!n};

   proof_begin = '\\begin{proof}' @{n++; };
   proof_end  = '\\end{proof}' @{n--; };
	 proof_body = any+ - (proof_begin|proof_end);
   proof = '\\begin{proof}' @{n=1;}  (proof_begin|proof_end|proof_body)*    proof_end  :> any when{!n};

   itemize_begin = '\\begin{itemize}' @{n++; };
   itemize_end  = '\\end{itemize}' @{n--; };
	 itemize_body = any+ - (itemize_begin|itemize_end);
   itemize = '\\begin{itemize}' @{n=1;}  (itemize_begin|itemize_end|itemize_body)*    itemize_end  :> any when{!n};

   thebibliography_begin = '\\begin{thebibliography}' @{n++; };
   thebibliography_end  = '\\end{thebibliography}' @{n--; };
	 thebibliography_body = any+ - (thebibliography_begin|thebibliography_end);
   thebibliography = '\\begin{thebibliography}' @{n=1;}  (thebibliography_begin|thebibliography_end|thebibliography_body)*    thebibliography_end  :> any when{!n};

   abstract_begin = '\\begin{abstract}' @{n++; };
   abstract_end  = '\\end{abstract}' @{n--; };
	 abstract_body = any+ - (abstract_begin|abstract_end);
   abstract = '\\begin{abstract}' @{n=1;}  (abstract_begin|abstract_end|abstract_body)*    abstract_end  :> any when{!n};

   enumerate_begin = '\\begin{enumerate}' @{n++; };
   enumerate_end  = '\\end{enumerate}' @{n--; };
	 enumerate_body = any+ - (enumerate_begin|enumerate_end);
   enumerate = '\\begin{enumerate}' @{n=1;}  (enumerate_begin|enumerate_end|enumerate_body)*    enumerate_end  :> any when{!n};

   table_begin = '\\begin{table}' @{n++; };
   table_end  = '\\end{table}' @{n--; };
	 table_body = any+ - (table_begin|table_end);
   table = '\\begin{table}' @{n=1;}  (table_begin|table_end|table_body)*    table_end  :> any when{!n};

   lemma_begin = '\\begin{lemma}' @{n++; };
   lemma_end  = '\\end{lemma}' @{n--; };
	 lemma_body = any+ - (lemma_begin|lemma_end);
   lemma = '\\begin{lemma}' @{n=1;}  (lemma_begin|lemma_end|lemma_body)*    lemma_end  :> any when{!n};

   minipage_begin = '\\begin{minipage}' @{n++; };
   minipage_end  = '\\end{minipage}' @{n--; };
	 minipage_body = any+ - (minipage_begin|minipage_end);
   minipage = '\\begin{minipage}' @{n=1;}  (minipage_begin|minipage_end|minipage_body)*    minipage_end  :> any when{!n};

   picture_begin = '\\begin{picture}' @{n++; };
   picture_end  = '\\end{picture}' @{n--; };
	 picture_body = any+ - (picture_begin|picture_end);
   picture = '\\begin{picture}' @{n=1;}  (picture_begin|picture_end|picture_body)*    picture_end  :> any when{!n};

   theorem_begin = '\\begin{theorem}' @{n++; };
   theorem_end  = '\\end{theorem}' @{n--; };
	 theorem_body = any+ - (theorem_begin|theorem_end);
   theorem = '\\begin{theorem}' @{n=1;}  (theorem_begin|theorem_end|theorem_body)*    theorem_end  :> any when{!n};

   split_begin = '\\begin{split}' @{n++; };
   split_end  = '\\end{split}' @{n--; };
	 split_body = any+ - (split_begin|split_end);
   split = '\\begin{split}' @{n=1;}  (split_begin|split_end|split_body)*    split_end  :> any when{!n};

   pmatrix_begin = '\\begin{pmatrix}' @{n++; };
   pmatrix_end  = '\\end{pmatrix}' @{n--; };
	 pmatrix_body = any+ - (pmatrix_begin|pmatrix_end);
   pmatrix = '\\begin{pmatrix}' @{n=1;}  (pmatrix_begin|pmatrix_end|pmatrix_body)*    pmatrix_end  :> any when{!n};

   verbatim_begin = '\\begin{verbatim}' @{n++; };
   verbatim_end  = '\\end{verbatim}' @{n--; };
	 verbatim_body = any+ - (verbatim_begin|verbatim_end);
   verbatim = '\\begin{verbatim}' @{n=1;}  (verbatim_begin|verbatim_end|verbatim_body)*    verbatim_end  :> any when{!n};

   definition_begin = '\\begin{definition}' @{n++; };
   definition_end  = '\\end{definition}' @{n--; };
	 definition_body = any+ - (definition_begin|definition_end);
   definition = '\\begin{definition}' @{n=1;}  (definition_begin|definition_end|definition_body)*    definition_end  :> any when{!n};

   displaymath_begin = '\\begin{displaymath}' @{n++; };
   displaymath_end  = '\\end{displaymath}' @{n--; };
	 displaymath_body = any+ - (displaymath_begin|displaymath_end);
   displaymath = '\\begin{displaymath}' @{n=1;}  (displaymath_begin|displaymath_end|displaymath_body)*    displaymath_end  :> any when{!n};

   proposition_begin = '\\begin{proposition}' @{n++; };
   proposition_end  = '\\end{proposition}' @{n--; };
	 proposition_body = any+ - (proposition_begin|proposition_end);
   proposition = '\\begin{proposition}' @{n=1;}  (proposition_begin|proposition_end|proposition_body)*    proposition_end  :> any when{!n};

   cases_begin = '\\begin{cases}' @{n++; };
   cases_end  = '\\end{cases}' @{n--; };
	 cases_body = any+ - (cases_begin|cases_end);
   cases = '\\begin{cases}' @{n=1;}  (cases_begin|cases_end|cases_body)*    cases_end  :> any when{!n};

   remark_begin = '\\begin{remark}' @{n++; };
   remark_end  = '\\end{remark}' @{n--; };
	 remark_body = any+ - (remark_begin|remark_end);
   remark = '\\begin{remark}' @{n=1;}  (remark_begin|remark_end|remark_body)*    remark_end  :> any when{!n};

   aligned_begin = '\\begin{aligned}' @{n++; };
   aligned_end  = '\\end{aligned}' @{n--; };
	 aligned_body = any+ - (aligned_begin|aligned_end);
   aligned = '\\begin{aligned}' @{n=1;}  (aligned_begin|aligned_end|aligned_body)*    aligned_end  :> any when{!n};

   prop_begin = '\\begin{prop}' @{n++; };
   prop_end  = '\\end{prop}' @{n--; };
	 prop_body = any+ - (prop_begin|prop_end);
   prop = '\\begin{prop}' @{n=1;}  (prop_begin|prop_end|prop_body)*    prop_end  :> any when{!n};

   subequations_begin = '\\begin{subequations}' @{n++; };
   subequations_end  = '\\end{subequations}' @{n--; };
	 subequations_body = any+ - (subequations_begin|subequations_end);
   subequations = '\\begin{subequations}' @{n=1;}  (subequations_begin|subequations_end|subequations_body)*    subequations_end  :> any when{!n};

   lem_begin = '\\begin{lem}' @{n++; };
   lem_end  = '\\end{lem}' @{n--; };
	 lem_body = any+ - (lem_begin|lem_end);
   lem = '\\begin{lem}' @{n=1;}  (lem_begin|lem_end|lem_body)*    lem_end  :> any when{!n};

   thm_begin = '\\begin{thm}' @{n++; };
   thm_end  = '\\end{thm}' @{n--; };
	 thm_body = any+ - (thm_begin|thm_end);
   thm = '\\begin{thm}' @{n=1;}  (thm_begin|thm_end|thm_body)*    thm_end  :> any when{!n};

   flushright_begin = '\\begin{flushright}' @{n++; };
   flushright_end  = '\\end{flushright}' @{n--; };
	 flushright_body = any+ - (flushright_begin|flushright_end);
   flushright = '\\begin{flushright}' @{n=1;}  (flushright_begin|flushright_end|flushright_body)*    flushright_end  :> any when{!n};

   multline_begin = '\\begin{multline}' @{n++; };
   multline_end  = '\\end{multline}' @{n--; };
	 multline_body = any+ - (multline_begin|multline_end);
   multline = '\\begin{multline}' @{n=1;}  (multline_begin|multline_end|multline_body)*    multline_end  :> any when{!n};

   example_begin = '\\begin{example}' @{n++; };
   example_end  = '\\end{example}' @{n--; };
	 example_body = any+ - (example_begin|example_end);
   example = '\\begin{example}' @{n=1;}  (example_begin|example_end|example_body)*    example_end  :> any when{!n};

   gather_begin = '\\begin{gather}' @{n++; };
   gather_end  = '\\end{gather}' @{n--; };
	 gather_body = any+ - (gather_begin|gather_end);
   gather = '\\begin{gather}' @{n=1;}  (gather_begin|gather_end|gather_body)*    gather_end  :> any when{!n};

   itemdecl_begin = '\\begin{itemdecl}' @{n++; };
   itemdecl_end  = '\\end{itemdecl}' @{n--; };
	 itemdecl_body = any+ - (itemdecl_begin|itemdecl_end);
   itemdecl = '\\begin{itemdecl}' @{n=1;}  (itemdecl_begin|itemdecl_end|itemdecl_body)*    itemdecl_end  :> any when{!n};

   itemdescr_begin = '\\begin{itemdescr}' @{n++; };
   itemdescr_end  = '\\end{itemdescr}' @{n--; };
	 itemdescr_body = any+ - (itemdescr_begin|itemdescr_end);
   itemdescr = '\\begin{itemdescr}' @{n=1;}  (itemdescr_begin|itemdescr_end|itemdescr_body)*    itemdescr_end  :> any when{!n};

   description_begin = '\\begin{description}' @{n++; };
   description_end  = '\\end{description}' @{n--; };
	 description_body = any+ - (description_begin|description_end);
   description = '\\begin{description}' @{n=1;}  (description_begin|description_end|description_body)*    description_end  :> any when{!n};

   tikzpicture_begin = '\\begin{tikzpicture}' @{n++; };
   tikzpicture_end  = '\\end{tikzpicture}' @{n--; };
	 tikzpicture_body = any+ - (tikzpicture_begin|tikzpicture_end);
   tikzpicture = '\\begin{tikzpicture}' @{n=1;}  (tikzpicture_begin|tikzpicture_end|tikzpicture_body)*    tikzpicture_end  :> any when{!n};

   titlepage_begin = '\\begin{titlepage}' @{n++; };
   titlepage_end  = '\\end{titlepage}' @{n--; };
	 titlepage_body = any+ - (titlepage_begin|titlepage_end);
   titlepage = '\\begin{titlepage}' @{n=1;}  (titlepage_begin|titlepage_end|titlepage_body)*    titlepage_end  :> any when{!n};

   bmatrix_begin = '\\begin{bmatrix}' @{n++; };
   bmatrix_end  = '\\end{bmatrix}' @{n--; };
	 bmatrix_body = any+ - (bmatrix_begin|bmatrix_end);
   bmatrix = '\\begin{bmatrix}' @{n=1;}  (bmatrix_begin|bmatrix_end|bmatrix_body)*    bmatrix_end  :> any when{!n};

   lstlisting_begin = '\\begin{lstlisting}' @{n++; };
   lstlisting_end  = '\\end{lstlisting}' @{n--; };
	 lstlisting_body = any+ - (lstlisting_begin|lstlisting_end);
   lstlisting = '\\begin{lstlisting}' @{n=1;}  (lstlisting_begin|lstlisting_end|lstlisting_body)*    lstlisting_end  :> any when{!n};

   quote_begin = '\\begin{quote}' @{n++; };
   quote_end  = '\\end{quote}' @{n--; };
	 quote_body = any+ - (quote_begin|quote_end);
   quote = '\\begin{quote}' @{n=1;}  (quote_begin|quote_end|quote_body)*    quote_end  :> any when{!n};

   corollary_begin = '\\begin{corollary}' @{n++; };
   corollary_end  = '\\end{corollary}' @{n--; };
	 corollary_body = any+ - (corollary_begin|corollary_end);
   corollary = '\\begin{corollary}' @{n=1;}  (corollary_begin|corollary_end|corollary_body)*    corollary_end  :> any when{!n};

   frame_begin = '\\begin{frame}' @{n++; };
   frame_end  = '\\end{frame}' @{n--; };
	 frame_body = any+ - (frame_begin|frame_end);
   frame = '\\begin{frame}' @{n=1;}  (frame_begin|frame_end|frame_body)*    frame_end  :> any when{!n};

   quotation_begin = '\\begin{quotation}' @{n++; };
   quotation_end  = '\\end{quotation}' @{n--; };
	 quotation_body = any+ - (quotation_begin|quotation_end);
   quotation = '\\begin{quotation}' @{n=1;}  (quotation_begin|quotation_end|quotation_body)*    quotation_end  :> any when{!n};
   
   verse_begin = '\\begin{verse}' @{n++; };
   verse_end  = '\\end{verse}' @{n--; };
	 verse_body = any+ - (verse_begin|verse_end);
   verse = '\\begin{verse}' @{n=1;}  (verse_begin|verse_end|verse_body)*    verse_end  :> any when{!n};
   
   tabbing_begin = '\\begin{tabbing}' @{n++; };
   tabbing_end  = '\\end{tabbing}' @{n--; };
	 tabbing_body = any+ - (tabbing_begin|tabbing_end);
   tabbing = '\\begin{tabbing}' @{n=1;}  (tabbing_begin|tabbing_end|tabbing_body)*    tabbing_end  :> any when{!n};
   matrix_begin = '\\begin{matrix}' @{n++; };
   matrix_end  = '\\end{matrix}' @{n--; };
	 matrix_body = any+ - (matrix_begin|matrix_end);
   matrix = '\\begin{matrix}' @{n=1;}  (matrix_begin|matrix_end|matrix_body)*    matrix_end  :> any when{!n};

   list_begin = '\\begin{list}' @{n++; };
   list_end  = '\\end{list}' @{n--; };
	 list_body = any+ - (list_begin|list_end);
   list = '\\begin{list}' @{n=1;}  (list_begin|list_end|list_body)*    list_end  :> any when{!n};
   
   rem_begin = '\\begin{rem}' @{n++; };
   rem_end  = '\\end{rem}' @{n--; };
	 rem_body = any+ - (rem_begin|rem_end);
   rem = '\\begin{rem}' @{n=1;}  (rem_begin|rem_end|rem_body)*    rem_end  :> any when{!n};

   flushleft_begin = '\\begin{flushleft}' @{n++; };
   flushleft_end  = '\\end{flushleft}' @{n--; };
	 flushleft_body = any+ - (flushleft_begin|flushleft_end);
   flushleft = '\\begin{flushleft}' @{n=1;}  (flushleft_begin|flushleft_end|flushleft_body)*    flushleft_end  :> any when{!n};

left_brace = '{' @{n++; };
right_brace = '}' @{n--; };
brace_body = any - (left_brace|right_brace);
braces = '{' @{n=0;} (left_brace|right_brace|brace_body)* :> '}' when{!n};


left_bracket = '[' @{n++;};
right_bracket = ']' @{n--; };
bracket_body = any - (left_bracket|right_bracket);
brackets = '[' @{n=0;} (left_bracket|right_bracket|bracket_body)* :> ']' when{!n};


left_parens = '(' @{n++;};
right_parens = ')' @{n--; };
parens_body = any - (left_parens|right_parens);
parens = '(' @{n=0;} (left_parens|right_parens|parens_body)* :> ')' when{!n};

latex = "," |
math |
"$" (any-"$"){1,80} "$" |
"\\ " |
"\\!" |
"\\" |
"\\"" |
"\\#" |
"\\%" |
"\\&" |
"\\'" |
"\\(" |
"\\)" |
"\\*" |
"\\+" |
"\\," |
"\\-" |
"\\." |
"\\/" |
"\\:" |
"\\;" |
"\\<" |
"\\=" |
"\\>" |
"\\?" |
"\\@" |
"\\[" |
"\]" |
"\^" |
"\_" |
"\`" |
"\{" |
"\|" |
"\}" |
"\~" |
"\$" |
"\\acute" |
"\\addcontentsline" |
"\\address" |
"\\addtocontents" |
"\\addtocounter" |
"\\addtolength" |
"\\ae" |
"\\AE" |
"\\aleph" |
"\\alph" |
"\\Alph" |
"\\alpha" |
"\\amalg" |
"\\and" |
"\\angle" |
"\\appendix" |
"\\approx" |
"\\arabic" |
"\\arccos" |
"\\arcsin" |
"\\arctan" |
"\\arg" |
"\\arraycolsep" |
"\\arrayrulewidth" |
"\\arraystretch" |
"\\ast" |
"\\asymp" |
"\\author" |
"\\backslash" |
"\\bar" |
"\\baselineskip" |
"\\baselinestretch" |
"\\Bbb" |
"\\begin" |
"\\begin{" |
"\\begin[pos]" |
"\\beta" |
"\\bf" |
"\\bibitem" |
"\\bibitem text" |
"\\bibliography" |
"\\bibliographystyle" |
"\\bigcap" |
"\\bigcirc" |
"\\bigcup" |
"\\bigodot" |
"\\bigoplus" |
"\\bigotimes" |
"\\bigskip" |
"\\bigskipamount" |
"\\bigsqcup" |
"\\bigtriangledown" |
"\\bigtriangleup" |
"\\biguplus" |
"\\bigvee" |
"\\bigwedge" |
"\\binname" |
"\\bmod" |
"\\boldmath" |
"\\bot" |
"\\bottomfraction" |
"\\bowtie" |
"\\Box" |
"\\breve" |
"\\bullet" |
"\\cal" |
"\\cap" |
"\\caption" |
"\\caption[loftitle]" |
"\\cc" |
"\\cdot" |
"\\cdots" |
"\\centering" |
"\\chapter" |
"\\chapter*" |
"\\chapter[toctitle]" |
"\\check" |
"\\chi" |
"\\circ" |
"\\circle" |
"\\circle*" |
"\\cite[subcit]" |
"\\cleardoublepage" |
"\\clearpage" |
"\\cline" |
"\\closing" |
"\\clubsuit" |
"\\columnsep" |
"\\columnseprule" |
"\\columnwidth" |
"\\cong" |
"\\contentsline" |
"\\coprod" |
"\\copyright" |
"\\cos" |
"\\cosh" |
"\\cot" |
"\\coth" |
"\\cs" |
"\\csc" |
"\\cup" |
"\\d" |
"\\dag" |
"\\dagger" |
"\\dashbox" |
"\\dashv" |
"\\date" |
"\\day" |
"\\dblfloatpagefraction" |
"\\dblfloatsep" |
"\\dbltextfloatsep" |
"\\dbltopfraction" |
"\\ddag" |
"\\ddagger" |
"\\ddot" |
"\\ddots" |
"\\deg" |
"\\delta" |
"\\Delta" |
"\\det" |
"\\diamond" |
"\\Diamond" |
"\\diamondsuit" |
"\\dim" |
"\\displaystyle" |
"\\div" |
"\\documentstyle" |
"\\documentstyle[substy]" |
"\\dot" |
"\\doteq" |
"\\dotfill" |
"\\doublerulesep" |
"\\downarrow" |
"\\Downarrow" |
"\\ell" |
"\\em" |
"\\emptyset" |
"\\encl" |
"\\end" |
"\\end{" |
"\\epsilon" |
"\\equiv" |
"\\eta" |
"\\evensidemargin" |
"\\exists" |
"\\exp" |
"\\fbox" |
"\\fboxrule" |
"\\fboxsep" |
"\\fill" |
"\\flat" |
"\\floatpagefraction" |
"\\floatsep" |
"\\flushbottom" |
"\\fnsymbol" |
"\\footheight" |
"\\footnote" |
"\\footnotemark" |
"\\footnotesep" |
"\\footnotesize" |
"\\footnotetext" |
"\\footskip" |
"\\forall" |
"\\frac" |
"\\frame" |
"\\framebox" |
"\\framebox[size][pos]" |
"\\frown" |
"\\fussy" |
"\\gamma" |
"\\Gamma" |
"\\gcd" |
"\\ge" |
"\\geq" |
"\\gets" |
"\\gg" |
"\\glossary" |
"\\glossaryentry" |
"\\grave" |
"\\hat" |
"\\hbar" |
"\\headheight" |
"\\headsep" |
"\\heartsuit" |
"\\hfill" |
"\\hline" |
"\\hom" |
"\\hookleftarrow" |
"\\hookrightarrow" |
"\\hrulefill" |
"\\hspace" |
"\\hspace*" |
"\\huge" |
"\\Huge" |
"\\hyphenation" |
"\\iff" |
"\\Im" |
"\\imath" |
"\\in" |
"\\include" |
"\\includeonly" |
"\\index" |
"\\indexentry" |
"\\indexspace" |
"\\inf" |
"\\infty" |
"\\input" |
"\\int" |
"\\intextsep" |
"\\iota" |
"\\it" |
"\\item" |
"\\itemindent" |
"\\itemsep" |
"\\item[text]" |
"\\jmath" |
"\\Join" |
"\\kappa" |
"\\ker" |
"\\kill" |
"\\label" |
"\\labelsep" |
"\\labelwidth" |
"\\lambda" |
"\\Lambda" |
"\\land" |
"\\langle" |
"\\large" |
"\\Large" |
"\\LARGE" |
"\\LaTeX" |
"\\lbrace" |
"\\lbrack" |
"\\lceil" |
"\\ldots" |
"\\le" |
"\\leadsto" |
"\\left*" |
"\\leftarrow" |
"\\Leftarrow" |
"\\lefteqn" |
"\\leftharpoondown" |
"\\leftharpoonup" |
"\\leftmargin" |
"\\leftmargini" |
"\\leftmarginvi" |
"\\leftrightarrow" |
"\\Leftrightarrow" |
"\\leq" |
"\\lfloor" |
"\\lg" |
"\\lhd" |
"\\lim" |
"\\liminf" |
"\\limsup" |
"\\linebreak" |
"\\linebreak[n]" |
"\\linethickness" |
"\\linewidth" |
list |
"\\listoffigures" |
"\\listoftables" |
"\\listparindent" |
"\\ll" |
"\\ln" |
"\\lnot" |
"\\log" |
"\\longleftarrow" |
"\\Longleftarrow" |
"\\longleftrightarrow" |
"\\Longleftrightarrow" |
"\\longmapsto" |
"\\longrightarrow" |
"\\Longrightarrow" |
"\\lor" |
"\\lq" |
"\\makebox" |
"\\makebox[size][pos]" |
"\\makeglossary" |
"\\makeindex" |
"\\maketitle" |
"\\mapsto" |
"\\marginpar" |
"\\marginparpush" |
"\\marginparsep" |
"\\marginparwidth" |
"\\markboth" |
"\\markright" |
"\\max" |
"\\mbox" |
"\\medskip" |
"\\medskipamount" |
"\\mho" |
"\\mid" |
"\\min" |
"\\mit" |
"\\models" |
"\\month" |
"\\mp" |
"\\mu" |
"\\multicolumn" |
"\\nabla" |
"\\natural" |
"\\ne" |
"\\nearrow" |
"\\neg" |
"\\neq" |
"\\newcommand" |
"\\newcounter[name]" |
"\\newenvironment" |
"\\newfont" |
"\\newlength" |
"\\newline" |
"\\newpage" |
"\\newsavebox" |
"\\newtheorem" |
"\\newtheorem[sectyp]" |
"\\ni" |
"\\nl" |
"\\nofiles" |
"\\noindent" |
"\\nolinebreak[n]" |
"\\nonumber" |
"\\nopagebreak[n]" |
"\\normalmarginpar" |
"\\normalsize" |
"\\not" |
"\\not=" |
"\\notin" |
"\\nu" |
"\\nwarrow" |
"\\o" |
"\\O" |
"\\obeycr" |
"\\oddsidemargin" |
"\\odot" |
"\\oe" |
"\\OE" |
"\\oint" |
"\\omega" |
"\\Omega" |
"\\ominus" |
"\\onecolumn" |
"\\opening" |
"\\oplus" |
"\\oslash" |
"\\otimes" |
"\\overline" |
"\\owns" |
"\\P" |
"\\pagebreak[n]" |
"\\pagenumbering" |
"\\pageref" |
"\\pagestyle" |
"\\paragraph*" |
"\\paragraph[toctitle]" |
"\\parallel" |
"\\parbox[pos]" |
"\\parindent" |
"\\parsep" |
"\\parskip" |
"\\part*" |
"\\partial" |
"\\partopsep" |
"\\part[toctitle]" |
"\\pdfoutput=1" |
"\\perp" |
"\\phi" |
"\\Phi" |
"\\pi" |
"\\Pi" |
"\\pm" |
"\\pmod" |
"\\poptabs" |
"\\pounds" |
"\\Pr" |
"\\prec" |
"\\preceq" |
"\\prime" |
"\\prod" |
"\\propto" |
"\\protect" |
"\\ps" |
"\\psi" |
"\\Psi" |
"\\pushtabs" |
"\\put" |
"\\raggedbottom" |
"\\raggedleft" |
"\\raggedright" |
"\\raisebox" |
"\\rangle" |
"\\rbrace" |
"\\rbrack" |
"\\rceil" |
"\\Re" |
"\\ref" |
"\\renewcommand" |
"\\renewenvironment" |
"\\restorecr" |
"\\reversemarginpar" |
"\\rfloor" |
"\\rhd" |
"\\rho" |
"\\right*" |
"\\rightarrow" |
"\\Rightarrow" |
"\\rightharpoondown" |
"\\rightharpoonup" |
"\\rightleftharpoons" |
"\\rightmargin" |
"\\rm" |
"\\roman" |
"\\Roman" |
"\\rq" |
"\\rule[height]" |
"\\S" |
"\\savebox" |
"\\sbox" |
"\\sc" |
"\\scriptscriptstyle" |
"\\scriptsize" |
"\\scriptstyle" |
"\\searrow" |
"\\sec" |
"\\section*" |
"\\section[toctitle]" |
"\\setcounter" |
"\\setlength" |
"\\setminus" |
"\\settowidth" |
"\\sf" |
"\\sharp" |
"\\shortstack[pos]" |
"\\sigma" |
"\\Sigma" |
"\\signature" |
"\\sim" |
"\\simeq" |
"\\sin" |
"\\sinh" |
"\\sl" |
"\\sloppy" |
"\\small" |
"\\smallint" |
"\\smallskip" |
"\\smallskipamount" |
"\\smile" |
"\\spadesuit" |
"\\sqcap" |
"\\sqcup" |
"\\sqrt[3]" |
"\\sqsubset" |
"\\sqsubseteq" |
"\\sqsupset" |
"\\sqsupseteq" |
"\\ss" |
"\\stackrel" |
"\\star" |
"\\stop" |
"\\subparagraph*" |
"\\subparagraph[toctitle]" |
"\\subsection*" |
"\\subsection[toctitle]" |
"\\subset" |
"\\subseteq" |
"\\subsubsection*" |
"\\subsubsection[toctitle]" |
"\\succ" |
"\\succeq" |
"\\sum" |
"\\sup" |
"\\supset" |
"\\supseteq" |
"\\surd" |
"\\swarrow" |
"\\symbol" |
"\\t" |
"\\tabbing" |
"\\tabbingsep" |
"\\tabcolsep" |
"\\tableofcontents" |
"\\tan" |
"\\tanh" |
"\\tau" |
"\\TeX" |
"\\textfloatsep" |
"\\textfraction" |
"\\textheight" |
"\\textstyle" |
"\\textwidth" |
"\\thanks" |
"\\theta" |
"\\Theta" |
"\\thicklines" |
"\\thinlines" |
"\\thinspace" |
"\\thispagestyle" |
"\\tilde" |
"\\times" |
"\\tiny" |
"\\title" |
"\\to" |
"\\today" |
"\\top" |
"\\topfraction" |
"\\topmargin" |
"\\topsep" |
"\\topskip" |
"\\triangle" |
"\\triangleleft" |
"\\triangleright" |
"\\tt" |
"\\twocolumn" |
"\\twocolumn[text]" |
"\\typein[\cs]" |
"\\typeout" |
"\\u" |
"\\unboldmath" |
"\\underbrace" |
"\\underline" |
"\\unitlength" |
"\\unlhd" |
"\\unrhd" |
"\\uparrow" |
"\\Uparrow" |
"\\updownarrow" |
"\\Updownarrow" |
"\\uplus" |
"\\upsilon" |
"\\Upsilon" |
"\\usebox" |
"\\usecounter" |
"\\v" |
"\\value" |
"\\varepsilon" |
"\\varphi" |
"\\varpi" |
"\\varrho" |
"\\varsigma" |
"\\vartheta" |
"\\vdash" |
"\\vdots" |
"\\vec" |
"\\vee" |
"\\vert" |
"\\Vert" |
"\\vfill" |
"\\vline" |
"\\vspace" |
"\\vspace*" |
"\\wedge" |
"\\widehat" |
"\\widetilde" |
"\\wp" |
"\\wr" |
"\\xi" |
"\\Xi" |
"\\year" |
"\\zeta" |

"\\affiliation" braces |
"\\arabic" braces |
"\\author" braces |
"\\autoref" braces |
"\\bar" braces |
"\\begin" braces |
"\\bibitem" braces |
"\\caption" braces |
"\\centerline" braces |
"\\cite" braces |
"\\date" braces |
"\\documentclass" braces |
"\\documentclass" brackets braces |
"\\dot" braces |
"\\email" braces |
"embraces" |
"\\emph" braces |
"\\end" braces |
"\\eq" braces |
"\\eqref" braces |
"\\f" braces |
"\\fmf" braces |
"\\fmfforce" braces |
"\\footnote" braces |
"\\frac" braces braces | 
"\\frace" braces |
"\\frame" brackets braces |
"\\frametitle" braces |
"\\hat" braces |
"\\hbox" braces |
"\\hspace" braces |
"\\ket" braces |
"\\label" braces |
"\\mathbb" braces |
"\\mathbf" braces |
"\\mathcal" braces |
"\\mathrm" braces |
"\\mbox" braces |
"\\newcommand" braces |
"\\newcommand" braces braces{1,2} |
"\\overline" braces |
"\\phantom" braces |
"\\ref" braces |
"\\renewcommand" braces |
"\\section" braces |
"\\setcounter" braces |
"\\setlength" braces |
"\\sqrt" braces |
"\\stackrel" braces |
"\\subsection" braces |
"\\textbf" braces |
"\\text" braces |
"\\textit" braces |
"\texttt" braces |
"\\tilde" braces |
"\\title" braces |
"\\underline" braces |
"\\url" braces |
"\\usepackage" braces |
"\\vec" braces |
"\\vspace" braces |
"\\widehat" braces |
"\\widetilde" braces | 

abstract  |
align  |
aligned  |
array  |
bmatrix  |
braces  |
brackets  |
cases  |
center  |
comment |
corollary  |
definition  |
description  |
displaymath  |
enumerate  |
eqnarray  |
equation  |
example  |
figure  |
flushleft  |
flushright  |
frame  |
gather  |
itemdecl  |
itemdescr  |
itemize  |
lemma  |
lstlisting  |
matrix  |
minipage  |
multline  |
parens  |
picture  |
pmatrix  |
proof  |
prop  |
proposition  |
quote  |
rem  |
remark  |
split  |
subequations  |
table  |
tabular  |
thebibliography  |
theorem  |
thm  |
tikzpicture  |
titlepage  |
verbatim  ;

}%%
