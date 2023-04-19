from ctypes import *
from sys import argv
from collections import defaultdict 
import re 
from pudb import set_trace
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

eqnarray = CDLL('./eqnarray.so')
eqnarray.test.restype = c_char_p

textbf = CDLL('./textbf.so')
textbf.test.restype = c_char_p

itemize = CDLL('./itemize.so')
itemize.test.restype = c_char_p

email = CDLL('./email.so')
email.test.restype = c_char_p

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

for match in email.test(s).decode().splitlines():
    parsed_document['email'].append(match)

for match in textit.test(s).decode().splitlines():
    parsed_document['textit'].append(match)

for match in textbf.test(s).decode().splitlines():
    parsed_document['textbf'].append(match)

for match in cite.test(s).decode().splitlines():
    parsed_document['cite'].append(match)

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

for match in abstract.test(s).decode().splitlines():
    parsed_document['abstract'].append(match)

#set_trace()
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


print(parsed_document['eqnarray'])
