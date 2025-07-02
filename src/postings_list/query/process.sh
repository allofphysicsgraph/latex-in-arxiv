pdflatex "$1" -halt-on-error
mv "$1" processed/
mv *.log processed/
mv *.pdf processed/
