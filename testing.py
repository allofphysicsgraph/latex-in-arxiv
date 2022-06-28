from sys import argv
from nltk.tokenize import mwe
from time import sleep
import re
import nltk
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from pudb import set_trace
from nltk.tag import pos_tag_sents


def add_new_token(string):
    tokenizer.add_mwe(r"{}".format(string))


def read_file(path, f_name):
    with open("{}/{}".format(path, f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


tokenizer = mwe.MWETokenizer(separator="")
latex_tokens = [x.strip() for x in read_file(".", "latex_vocab").splitlines()]
english_tokens = [x.strip() for x in read_file(".", "english_vocab").splitlines()]
file_data = read_file(".", "sound1.tex")

tokens = []
regexp_tokenizer = RegexpTokenizer("\$.*?\$")
regexp_tokens = regexp_tokenizer.tokenize(file_data)
tokens.extend(list(set(regexp_tokens)))
tokens.extend(list(set(latex_tokens)))
tokens.extend(list(set(english_tokens)))
tokens = sorted(tokens, key=lambda x: -1 * len(x))
for token in tokens:
    add_new_token(token)

sents = nltk.sent_tokenize("\n".join(file_data.splitlines()))
tagged_sents = nltk.pos_tag_sents([tokenizer.tokenize(sent) for sent in sents])
tagged_keys = [x[0] for x in tagged_sents]
print(tagged_keys)


"""    word_tokens = tokenizer.tokenize(file_data)
    sents = nltk.sent_tokenize(file_data)
    f = open('training_data','a+')
    for sent in sents:
        for tok in list(set(regexp_tokens)):
            if tok in sent:
                print('tok:{}'.format(tok),sent)"""
