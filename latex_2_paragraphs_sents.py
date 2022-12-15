import sys
import sqlalchemy
import re
import pandas as pd
import os
import nltk
import configparser
from sys import argv
from sumy.utils import get_stop_words
from sumy.summarizers.lsa import LsaSummarizer
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.nlp.stemmers import Stemmer
from sqlalchemy import create_engine
from pudb import set_trace
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from collections import defaultdict
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from nltk.tokenize import SExprTokenizer
from time import sleep
import re

def read_file(f_name,path='.'):
    with open(f"{path}/{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines() if not re.findall(r"^\\def|^\\newcommand", x)]
    data = "\n".join(clean)
    return data

# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=750, smoothing_rounds=550000
)

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
balanced_test_tokenizer=SExprTokenizer(parens='$$',strict=True)

file_data = read_file(argv[1])
groups = txttlng_tokenizer.tokenize(file_data)
print(len(groups))
from time import sleep
from tqdm import tqdm
for group in tqdm(groups):
    print('*'*80,'\n')
    sentences = tok_cls.sentences_from_text(group)
    for sent in sentences:
        print(sent,'\n','*'*25,'\n')
        sleep(1)
