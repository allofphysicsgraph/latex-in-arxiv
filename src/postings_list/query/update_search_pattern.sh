#!/bin/bash

#Default pattern
#latex =   parens|brackets|braces|comment|table |abstract |affiliation | align | author | bibitem | center |cite|comment | equation | inline_math | itemize | newcommand | ref| title | section | subsection | url |usepackage;
#
array2=("sum" "int" "limt" "prod" "inline_math" "affiliation" "frac" "usepackage" "bibitem" "ref" "affiliation" "cite" "title" "author" "abstract" "array" "acknowledgement" "acknowledgements" "acknowledgments" "acks" "adjustbox" "algorithm" "algorithmic" "align" "alignat" "aligned" "alignedat" "alltt" "array" "article" "assumption" "aug" "axis" "barticle" "bbook" "block" "bmatrix" "bmisc" "case" "cases" "center" "centering" "claim" "code" "compactenum" "compactitem" "conj" "conjecture" "cor" "coro" "corollary" "dcases" "defi" "defin" "definition" "defn" "deluxetable" "demo" "description" "df" "dfn" "diagram" "displaymath" "document" "eg" "enumerate" "eqnarray" "equ" "equation" "equs" "ex" "exa" "exam" "example" "exercise" "exmp" "fact" "figure" "filecontents" "flalign" "flushleft" "flushright" "fmffile" "fmfgraph" "footnotesize" "frame" "framed" "frontmatter" "gather" "gathered" "indented" "inparaenum" "itemize" "keyword" "keywords" "landscape" "large" "lem" "lema" "lemm" "lemma" "lemme" "linenomath" "linenumbers" "list" "lm" "longlist" "longtable" "lrbox" "lstlisting" "mapleinput" "maplelatex" "math" "mathletters" "mathpar" "matrix" "minipage" "multicols" "multline" "multlined" "mydef" "notation" "note" "obs" "observation" "opening" "overpic" "pf" "pgfonlayer" "pgfscope" "picture" "pmatrix" "pr" "prf" "pro" "prob" "problem" "proof" "proofof" "prooftree" "prop" "property" "propo" "proposition" "prp" "psfrags" "pspicture" "question" "quotation" "quote" "references" "rem" "rema" "remark" "restatable" "rmk" "rotate" "ruledtabular" "sc" "scope" "scriptsize" "section" "sideways" "sidewaystable" "sloppypar" "small" "smallmatrix" "spacing" "split" "subarray" "subeqnarray" "subequations" "subfigure" "subsection" "subtable" "tabbing" "table" "tablenotes" "tabular" "tabularx" "tcolorbox" "teo" "theacknowledgments" "thebibliography" "theo" "theorem" "thm" "threeparttable" "tikzcd" "tikzpicture" "tiny" "titlepage" "trivlist" "turn" "turnpage" "verbatim" "vmatrix" "widetext" "wrapfigure" "xy" ) 

if [ -z "$1" ]; then
  echo "Error: Please provide an argument."
  exit 1
fi


if [[ " ${array2[*]} " == *" $1 "* ]]; then

    echo "Argument '$1' found in array2. Running command2..." ; 
    sed -i -r "s/^latex =.*/latex = $1 ;/g"  latex.rl ; 
    exit
fi
    echo "Argument '$1' not found in either array." ;
exit 0

