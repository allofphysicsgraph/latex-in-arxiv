all:
	if test ! -d test ; then mkdir test ; fi
	sudo apt install ragel
	sudo apt install virtualenv

	/bin/bash call_ragel_from_python.sh
	virtualenv venv -p python3 
	./venv/bin/pip install -r requirements.txt
	screen -d -m -S server ./venv/bin/python ragel_simple.py 
	sleep 3 && ./venv/bin/python test.py sound1.tex

keyword_search:
	ragel keyword_search.rl
	gcc keyword_search.c -o keyword_search.out
	./keyword_search.out sound1.tex 

templates:
	#make adjustments to simple_template
	bash generate_simple_templates.sh
	#make adjustments to simple_template
	bash generate_begin_end_templates.sh
	./venv/bin/black *.py
	#autopep8 --in-place --aggressive --aggressive <filename>


clean:
	rm *.so
	rm *.c
