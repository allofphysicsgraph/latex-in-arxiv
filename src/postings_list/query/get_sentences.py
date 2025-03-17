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


from tqdm import tqdm
files = [x for x in listdir('.') if re.findall('tex$',x)]
#files = [argv[1]]
for f_name in tqdm(files):
    data = read_file(f_name)
    doc = nlp(data,parse=False,tag=False,entity=False)
    output = []
    for ix,sent in enumerate(doc.sents):
        output.append((f_name,str(sent),ix))
    df =  pd.DataFrame(output)
    df.columns=['file_name','sentence','sentenece_index']
    #print(df.head())
    engine = create_engine("postgresql://arxiv:795e3522169@localhost:5433/latex_in_arxiv")
    df.to_sql('sentences', engine, if_exists="append", index=False)
