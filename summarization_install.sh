sudo apt install virtualenv
virtualenv venv -p python3
source venv/bin/activate
pip install -r old/requirements.txt
python -c "import nltk;nltk.download('punkt')"
