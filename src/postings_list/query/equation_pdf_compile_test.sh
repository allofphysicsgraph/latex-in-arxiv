file_name=$1
temp_name=$(echo $1|sed 's/.tex/_test.tex/g') 
cat template_header $1  template_footer > $temp_name
pdflatex $temp_name
