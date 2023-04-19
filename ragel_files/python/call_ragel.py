from collections import defaultdict
from ctypes import *
from nltk.tokenize import mwe
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from sys import argv
from time import sleep
from tqdm import tqdm
import nltk
import os
import re
import sys
#from sklearn.feature_extraction.text import TfidfVectorizer
#from sklearn.metrics.pairwise import cosine_similarity
parsed_document = defaultdict(list)
title = CDLL('./title.so')
author = CDLL('./author.so')
affiliation = CDLL('./affiliation.so')
bibliography = CDLL('./bibliography.so')
equation = CDLL('./equation.so')
definition = CDLL('./definition.so')
algorithm = CDLL('./algorithm.so')
abstract = CDLL('./abstract.so')
slm = CDLL('./slm.so')

keywords = CDLL('./keywords.so')
keywords.test.restype = c_char_p

eqnarray = CDLL('./eqnarray.so')
eqnarray.test.restype = c_char_p

textbf = CDLL('./textbf.so')
textbf.test.restype = c_char_p

itemize = CDLL('./itemize.so')
itemize.test.restype = c_char_p

#tex_email = CDLL('./email.so')
#tex_email.test.restype = c_char_p

textit = CDLL('./textit.so')
textit.test.restype = c_char_p

cite = CDLL('./cite.so')
cite.test.restype = c_char_p

emph = CDLL('./emph.so')
emph.test.restype = c_char_p

figure = CDLL('./figure.so')
figure.test.restype = c_char_p

label = CDLL('./label.so')
label.test.restype = c_char_p

url = CDLL('./url.so')
url.test.restype = c_char_p

bibitem = CDLL('./bibitem.so')
bibitem.test.restype = c_char_p

section = CDLL('./section.so')
section.test.restype = c_char_p

ref = CDLL('./ref.so')
ref.test.restype = c_char_p

title.test.restype = c_char_p
author.test.restype = c_char_p
affiliation.test.restype = c_char_p
bibliography.test.restype = c_char_p
equation.test.restype = c_char_p
definition.test.restype = c_char_p
algorithm.test.restype = c_char_p
abstract.test.restype = c_char_p
slm.test.restype = c_char_p


with open(argv[1],'r') as f:
    data = f.read()

simple_newcommands = [[y[:-1] for y in x.split('\\newcommand{',maxsplit=1) if y][0] for x in re.findall(r'\\newcommand.*',data)]
simple_newcommands = [x.split('}{',maxsplit=1) for x in simple_newcommands]
simple_newcommands = [x for x in simple_newcommands if len(x) == 2]
#for cmd in simple_newcommands:
#    match = cmd[0]
#    sub = cmd[1]
#    data = re.sub('{}[^a-z]'.format(re.escape(match)),'{}'.format(re.escape(sub)),data)
#    print(data)
#exit(0)


s = c_char_p(str.encode(data))
print('title')
parsed_document['title'].append(title.test(s).decode())


print('author')
for match in author.test(s).decode().splitlines():
    parsed_document['author'].append(match)

for match in bibitem.test(s).decode().splitlines():
    parsed_document['bibitem'].append(match)

for match in url.test(s).decode().splitlines():
    parsed_document['url'].append(match)

#for match in tex_email.test(s).decode().splitlines():
#    parsed_document['email'].append(match)

for match in textit.test(s).decode().splitlines():
    parsed_document['textit'].append(match)

for match in textbf.test(s).decode().splitlines():
    parsed_document['textbf'].append(match)

for match in cite.test(s).decode().splitlines():
    parsed_document['cite'].append(match)

for match in keywords.test(s).decode().splitlines():
    parsed_document['keywords'].append(match)
for match in emph.test(s).decode().splitlines():
    parsed_document['emph'].append(match)

for match in label.test(s).decode().splitlines():
    parsed_document['label'].append(match)
for match in ref.test(s).decode().splitlines():
    parsed_document['ref'].append(match)

for match in affiliation.test(s).decode().splitlines():
    parsed_document['affiliation'].append(match)

if re.findall(r'\\begin{eqnarray}',data):
    for match in eqnarray.test(s).decode().splitlines():
        parsed_document['eqnarray'].append(match)

if re.findall(r'\\begin{equation}',data):
    for match in equation.test(s).decode().splitlines():
        parsed_document['equation'].append(match)

if re.findall(r'\\begin{itemize}',data):
    for match in itemize.test(s).decode().splitlines():
        parsed_document['itemize'].append(match)

if re.findall(r'\\begin{figure}',data):
    for match in figure.test(s).decode().splitlines():
        parsed_document['figure'].append(match)

if re.findall(r'\\begin{algorithm}',data):
    for match in algorithm.test(s).decode().splitlines():
        parsed_document['algorithm'].append(match)


if re.findall(r'\\begin{definition}',data):
    for match in definition.test(s).decode().splitlines():
        parsed_document['definition'].append(match)

if re.findall(r'\\begin{abstract}',data):
    for match in abstract.test(s).decode().splitlines():
        parsed_document['abstract'].append(match)

for match in slm.test(s).decode().splitlines():
    parsed_document['slm'].append(match)

#parse thebibliography on another pass
matches=re.findall(r'\\begin{thebibliography}.*?\\end{thebibliography}',data,re.DOTALL)
if matches:
    parsed_document['thebibliography'].append(*matches)
    for match in matches:
        data = data.replace(match,'')

if re.findall(r'\\section',data):
    #update data to exclude thebibliography
    s = c_char_p(str.encode(data))
    for match in section.test(s).decode().splitlines():
        parsed_document['section'].append(match)



# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=50, smoothing_rounds=5000
)

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
balanced_test_tokenizer = SExprTokenizer(parens="$$", strict=True)

parsed_document['paragraphs'] = txttlng_tokenizer.tokenize(data)

for paragraph in tqdm(parsed_document['paragraphs']):
    sentences = tok_cls.sentences_from_text(paragraph)
    for sent in sentences:
        parsed_document['sents'].append(sent)



