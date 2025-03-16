from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
import nltk
from sys import argv
import re

# depends on nltk 3.8 which has a CVE
# also depends on 285M file punkt_html_trainer.
# send an email or post an issue if you want a copy of the pickled punkt model.
# I find that it is performs better than the default sentence punkt english model.

punkt_trainer = nltk.data.load("punkt_html_trainer", format="pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer

tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
with open(argv[1], "r") as f:
    data = f.read()
    match = re.findall(
        r"\\begin{thebibliography}.*?\\end{thebibliography}", data, re.DOTALL
    )
    if match:
        match = match[0]
        data = data.replace(match, "")
    print(data)

tok_cls.sentences_from_text(data)
sentences = tok_cls.sentences_from_text(data)
from time import sleep

for ix in range(len(sentences)):
    print(sentences[ix])
    print("*" * 50)
    sleep(2)
