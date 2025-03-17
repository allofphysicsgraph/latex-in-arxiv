from collections import defaultdict
from ctypes import *
from nltk import pos_tag
from nltk.tokenize import mwe
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from os import listdir
from psycopg2 import connect
from pygments.formatters import Terminal256Formatter
from pygments import highlight
from pygments.lexer import RegexLexer
from pygments.style import Style
from pygments.token import *
from random import shuffle

# from rank_bm25 import BM25Okapi
from sklearn.feature_extraction.text import CountVectorizer
from sys import argv
from time import sleep
from tqdm import tqdm

# import ahocorasick
import configparser
import hashlib
import inspect
import lzma
import nltk
import numpy
import os
import pandas as pd
import re
import rpyc
import sys
import yaml

# python -m spacy download en_core_web_trf
import spacy
from common import read_file
from sys import argv
from time import sleep
import pandas as pd
from sqlalchemy import create_engine


# with open("config.yaml", "r") as f:
#    config = yaml.safe_load(f)


class MyService(rpyc.Service):
    def __init__(self):
        self.nlp = spacy.load("en_core_web_trf")
        self.filename = ""

    def on_connect(self, f_name):
        self.filename = f_name
        pass

    def on_disconnect(self, conn):
        # code that runs after the connection has already closed
        # (to finalize the service, if needed)
        pass

    def exposed_read_file(self, f_name):
        # Unable to reliably process files using utf-8 encoding
        with open(f"{f_name}", "r", encoding="ISO-8859-1") as f:
            data = f.read()
        clean = [
            x
            for x in data.splitlines()
            if not re.findall(
                r"^\\(def|newcommand|documentclass|begin{document}|usepackage)", x
            )
        ]
        data = " ".join(clean)
        return data

    def exposed_get_sentences(self, file_data):
        doc = self.nlp(file_data)
        sentences = []
        for ix, sent in enumerate(doc.sents):
            sentences.append((self.filename, str(sent), ix))
        return sentences

    def exposed_sentences_to_sql(self, sentences):
        df = pd.DataFrame(output)
        df.columns = ["file_name", "sentence", "sentenece_index"]
        engine = create_engine(
            "postgresql://arxiv:795e3522169@localhost:5433/latex_in_arxiv"
        )
        df.to_sql("sentences", engine, if_exists="append", index=False)


if __name__ == "__main__":
    from rpyc.utils.server import ThreadedServer
    from sys import argv

    if len(sys.argv) == 2:
        port = int(sys.argv[1])
    else:
        port = 18863

    t = ThreadedServer(
        MyService,
        port=port,
        protocol_config={"allow_pickle": True, "allow_all_attrs": True},
    )
    print("Ready for rpyc clients \n")
    t.start()
