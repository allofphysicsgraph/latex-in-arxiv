all:
	rsync -axr ../2003/* . --progress
	/bin/bash build_flex_files.sh
	/bin/bash run_all_flex_scripts.sh
	#python replace_latex_w_token_named.py sound1.tex

clean:
	find . -type f -name "*.out" -exec rm "{}" \; 
	find . -type f -name "*.csv" -exec rm "{}" \; 
	find . -type f -name "*.tex" -exec rm "{}" \; 
	find . -type f -name "*~" -exec rm "{}" \; 
	find . -type f -name ".*~" -exec rm "{}" \; 
