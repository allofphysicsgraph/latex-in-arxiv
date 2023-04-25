# Sentencepiece python module
#!pip install sentencepiece
#!pip install nltk


import configparser
import nltk
import numpy
import os
import pandas as pd
import re
import sentencepiece as spm
import sys
from collections import defaultdict
from nltk.tokenize import mwe
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from sys import argv
from time import sleep
from tqdm import tqdm
nltk.download("stopwords")


def read_file(f_name):
    with open(f"{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines()]
    data = "\n".join(clean)
    return data


# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
sp = spm.SentencePieceProcessor()
sp.load("HEP_TEX.model")
file_data = read_file(argv[1])
# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=100, smoothing_rounds=25000
)

if 1 == 1:
    sentence_count = 0
    try:
        lst = []
        groups = txttlng_tokenizer.tokenize(file_data)
        sents = []
        for ig, group in enumerate(groups):
            sentences = tok_cls.sentences_from_text(group)
            for ix, sent in enumerate(sentences):
                # sents.append(sent)
                print(sent)
                print(sp.encode_as_pieces(sent))
                sleep(5)
                lst.append((argv[1], sentence_count, sp.encode_as_pieces(sent)))
                sentence_count += 1
        df = pd.DataFrame(lst)
    except Exception as e:
        print(e)
