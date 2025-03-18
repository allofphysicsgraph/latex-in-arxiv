# python -m spacy download en_core_web_trf
import re
import spacy
from common import read_file
from sys import argv
from time import sleep
import pandas as pd 
from sqlalchemy import create_engine
from os import listdir
nlp = spacy.load('en_core_web_trf')

from nltk import RegexpTokenizer
reg = RegexpTokenizer(r"\\frac{.*?}{.*?}")

from tqdm import tqdm
files = [x for x in listdir('.') if re.findall('tex$',x)]
#files = [argv[1]]
sos = []
eos = []

for f_name in tqdm(files):
    data = read_file(f_name)
    doc = nlp(data)
    output = []
    for ix,sent in enumerate(doc.sents):
        output.append((f_name,str(sent),ix))
        print(sent)
        #sleep(1)
        s= str(sent)
        for ix in range(20,30):
            sos.append(s[:ix])
            eos.append(s[-ix:])
        print('*'*50)
    df =  pd.DataFrame(output)
    df.columns=['file_name','sentence','sentenece_index']
    #print(df)
    #engine = create_engine("postgresql://arxiv:795e3522169@localhost:5433/latex_in_arxiv")
    #df.to_sql('sentences', engine, if_exists="append", index=False)
#print(sos)
ls = len(sos)
lss = len(set(sos))
print(lss/ls)
print(len(eos),len(set(eos)))
from random import shuffle
shuffle(sos)
sos = [x for x in list(set(sos)) if not re.findall(r'\\',str(x))]
sos = list(set(sos))
sos = sorted(sos,key=lambda x: -len(x))
sos = [x.strip() for x in sos if len(x) >=20]
print(sos)
#print(list(set(eos))[:40])
