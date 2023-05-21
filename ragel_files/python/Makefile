all:
	sudo apt install ragel
	sudo apt install virtualenv

	/bin/bash call_ragel_from_python.sh
	virtualenv venv -p python3 
	source venv/bin/activate
	pip install -r requirements.txt
	python call_ragel.py

clean:
	rm *.so
	rm *.c
