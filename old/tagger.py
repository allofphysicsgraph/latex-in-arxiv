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

f = open("training_sents", "a+")
sents = nltk.sent_tokenize("\n".join(file_data.splitlines()))
tagged_sents = nltk.pos_tag_sents([tokenizer.tokenize(sent) for sent in sents])
of_interest = ["WRB", "NNP", "VBZ", "DT"]
for ix, sent in enumerate(tagged_sents):
    resp = [x[0] for x in sent if x[0] in regexp_tokens]
    if resp:
        pos_tags = [x[1] for x in sent if x[0].strip()]  # strip ws tags
        lst = list(nltk.ngrams(pos_tags, len(of_interest)))
        if tuple(of_interest) in lst:
            print("*" * 50, "\n", sents[ix], sent, pos_tags, "\n\n")
            f.write(sents[ix])
            f.write("\n")
            f.write(" ".join(resp))
            f.write("\n")
            f.write(str(sent))
            f.write("\n")
            f.write("*" * 50)
            f.write("\n")
            # set_trace()
        # if len(set(of_interest).intersection(set(pos_tags))) == len(set(of_interest)):
        #    set_trace()
        #    sleep(5)
        # print('*'*50,sents[ix],resp,sent)

f.close()
