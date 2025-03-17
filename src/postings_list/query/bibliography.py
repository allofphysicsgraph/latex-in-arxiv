from sys import argv
from nltk import mwe
import spacy
from common import read_file

nlp = spacy.load("en_core_web_trf")
entity_tokenizer = mwe.MWETokenizer(separator="")

with open(argv[1], "r") as f:
    data = f.read()
doc = nlp(data)


def get_word_list(vocab):
    word_list = sorted(vocab, key=lambda x: -len(x))
    return word_list


import re

match = re.findall(
    r"\\begin{thebibliography}.*?\\end{thebibliography}", data, re.DOTALL
)
if match:
    if len(match) == 1:
        if len(match[0]) > 10:
            thebibliography = match[0]

# resp = [(x.text,x.label_) for x in doc.ents if x.label_ !='MONEY' and re.findall('ORG|PERSON',x.label_)]
resp = [
    x.text
    for x in doc.ents
    if x.label_ != "MONEY" and re.findall("ORG|GPE|PERSON|DATE|CARDINAL", x.label_)
]
bibitems = re.findall(r"\\bibitem{.*?}", thebibliography)
braces = re.findall(r"{.*?}", thebibliography)
commas = re.findall(r",(.*?),", thebibliography)
pages = re.findall(r",\s+(\d+\-\d+),", thebibliography)
inline_math = re.findall(r"(\$.*?\$)", thebibliography)
resp.extend(bibitems)
resp.extend(braces)
resp.extend(commas)
resp.extend(pages)
resp.extend(inline_math)
word_list = get_word_list(resp)
for word in word_list:
    entity_tokenizer.add_mwe(r"{}".format(word))

resp = entity_tokenizer.tokenize(thebibliography)
resp = [x for x in resp if x.strip()]
print(resp)
