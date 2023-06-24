all:
	if test ! -d test ; then mkdir test ; fi
	sudo apt install ragel
	sudo apt install virtualenv

	/bin/bash call_ragel_from_python.sh
	virtualenv venv -p python3 
	./venv/bin/pip install -r requirements.txt
	./venv/bin/python call_ragel.py sound1.tex


simplefields:
	#make adjustments to simple_template
	cat simple_fields|xargs -i sed "s/cite/{}/g" simple_template >> ragel_simple.py

clean:
	rm *.so
	rm *.c
