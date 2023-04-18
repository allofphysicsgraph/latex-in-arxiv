from ctypes import *
from sys import argv
from collections import defaultdict 
import re 
parsed_document = defaultdict(list)
title = CDLL('./title.so')
author = CDLL('./author.so')
affiliation = CDLL('./affiliation.so')
bibliography = CDLL('./bibliography.so')

title.test.restype = c_char_p
author.test.restype = c_char_p
affiliation.test.restype = c_char_p
bibliography.test.restype = c_char_p


with open('sound1.tex','r') as f:
    data = f.read()

s = c_char_p(str.encode(data))
parsed_document['title'].append(title.test(s).decode())


for match in author.test(s).decode().splitlines():
    parsed_document['author'].append(match)


for match in affiliation.test(s).decode().splitlines():
    parsed_document['affiliation'].append(match)

#parse thebibliography on another pass
matches=re.findall(r'\\begin{thebibliography}.*?\\end{thebibliography}',data,re.DOTALL)
parsed_document['thebibliography'].append(*matches)
for match in matches:
    data = data.replace(match,'')


print(parsed_document)


