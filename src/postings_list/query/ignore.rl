%%{
  machine ignore;

  ignore = thebibliography | figure | '\\raisebox' braces 
| "\\usepackage" braces | '\\hspace' '*'? braces | '\\vspace' '*' braces |  '{' '-' digit? '.'?  digit ('em}'|'ex}') ;
}%%
