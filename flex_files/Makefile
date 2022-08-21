all:
	rsync -axr ../2003/* . --progress
	/bin/bash build_flex_files.sh
	/bin/bash run_all_flex_scripts.sh
	#python replace_latex_w_token_named.py sound1.tex

clean:
	rm *.tex
	rm *.csv
	rm *.out
