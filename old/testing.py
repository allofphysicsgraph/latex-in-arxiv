import pandas as pd
from sys import argv
from nltk.tokenize import mwe
from time import sleep
import re
import nltk
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from pudb import set_trace
from nltk.tag import pos_tag_sents

pd.set_option("display.max_columns", 50)


def read_file(path, f_name):
    with open("{}/{}".format(path, f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


class Tokenizer:
    def add_new_token(self, tokenizer, string):
        tokenizer.add_mwe(r"{}".format(string))

    def __init__(self, file_name):
        self.tokens = []
        self.file_data = read_file(".", file_name)

        self.mwe = mwe.MWETokenizer(separator="")
        self.regexp = RegexpTokenizer("\$.*?\$")

        self.latex_tokens = [
            x.strip() for x in read_file(".", "latex_vocab").splitlines()
        ]
        self.english_tokens = [
            x.strip() for x in read_file(".", "english_vocab").splitlines()
        ]
        self.regexp_tokens = self.regexp.tokenize(self.file_data)

        self.tokens.extend(list(set(self.regexp_tokens)))
        self.tokens.extend(list(set(self.latex_tokens)))
        self.tokens.extend(list(set(self.english_tokens)))
        self.tokens = sorted(self.tokens, key=lambda x: -1 * len(x))

        for token in self.tokens:
            self.add_new_token(self.mwe, token)


tokenizer = Tokenizer("sound1.tex")


sents = nltk.sent_tokenize("\n".join(tokenizer.file_data.splitlines()))
tagged_sents = nltk.pos_tag_sents([tokenizer.mwe.tokenize(sent) for sent in sents])
for ix, sent in enumerate(sents):
    resp = [x for x in tokenizer.mwe.tokenize(sent) if x in tokenizer.regexp_tokens]
    if resp:
        print(sent)
        inp = input()
        lst = []
        if inp == "p":
            words = [x[0] for x in tagged_sents[ix] if x[0].strip()]
            tags = [x[1] for x in tagged_sents[ix] if x[0].strip()]
            lst.append(words)
            lst.append(tags)
            df = pd.DataFrame(lst)
            print(df.head())
