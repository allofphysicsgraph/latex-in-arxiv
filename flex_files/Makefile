all:
	xz -d ../Punkt_LaTeX_SENT_Tokenizer.pickle.xz
	rsync -axr ../sound1.tex . 
	/bin/bash build_flex_files.sh
	/bin/bash run_all_flex_scripts.sh
	python replace_latex_w_token_name.py sound1.tex

clean:
	rm *.csv
	rm *.out
