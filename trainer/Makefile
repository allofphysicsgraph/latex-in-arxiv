clean:
	rm *.aux
	rm *.pdf
	rm *.log

remove_header:
	find compiled -type f -name "*.tex" -exec sed -i -f sed_file "{}" \; 
	find failed -type f -name "*.tex" -exec sed -i -f sed_file "{}" \; 
