from ctypes import *
from sys import argv
from collections import defaultdict 
import re 
parsed_document = defaultdict(list)
title = CDLL('./title.so')
author = CDLL('./author.so')
affiliation = CDLL('./affiliation.so')
bibliography = CDLL('./bibliography.so')
equation = CDLL('./equation.so')
abstract = CDLL('./abstract.so')
slm = CDLL('./slm.so')

title.test.restype = c_char_p
author.test.restype = c_char_p
affiliation.test.restype = c_char_p
bibliography.test.restype = c_char_p
equation.test.restype = c_char_p
abstract.test.restype = c_char_p
slm.test.restype = c_char_p


with open(argv[1],'r') as f:
    data = f.read()

s = c_char_p(str.encode(data))
parsed_document['title'].append(title.test(s).decode())


for match in author.test(s).decode().splitlines():
    parsed_document['author'].append(match)


for match in affiliation.test(s).decode().splitlines():
    parsed_document['affiliation'].append(match)

if re.findall(r'\\begin{equation}',data):
    for match in equation.test(s).decode().splitlines():
        parsed_document['equation'].append(match)


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

print(parsed_document['slm'])
