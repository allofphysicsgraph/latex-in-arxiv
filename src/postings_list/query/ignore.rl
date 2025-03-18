%%{
  machine ignore;

equation_begin = '\\begin{equation}' @{n++; };
equation_end  = '\\end{equation}' @{n--; };
equation_body = any+ - (equation_begin|equation_end);
equation = '\\begin{equation}' @{n=1;}  (equation_begin|equation_end|equation_body)*    equation_end  :> any when{!n};


thebibliography_begin = '\\begin{thebibliography}' @{n++; };
thebibliography_end  = '\\end{thebibliography}' @{n--; };
thebibliography_body = any+ - (thebibliography_begin|thebibliography_end);
thebibliography = '\\begin{thebibliography}' @{n=1;}  (thebibliography_begin|thebibliography_end|thebibliography_body)*    thebibliography_end  :> any when{!n};


figure_begin = '\\begin{figure}' @{n++; };
figure_end  = '\\end{figure}' @{n--; };
figure_body = any+ - (figure_begin|figure_end);
figure = '\\begin{figure}' @{n=1;}  (figure_begin|figure_end|figure_body)*    figure_end  :> any when{!n};



left_brace = '{' @{n++; };
right_brace = '}' @{n--; };
brace_body = any - (left_brace|right_brace);
braces = '{' @{n=0;} (left_brace|right_brace|brace_body)* :> '}' when{!n};

ignore =   '\\newcommand' braces |'\\section' braces |equation| thebibliography|figure;

}%%
