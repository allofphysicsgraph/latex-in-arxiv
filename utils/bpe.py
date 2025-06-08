import re
from collections import defaultdict
from sys import argv
from nltk.tokenize import mwe
from pudb import set_trace
from tqdm import tqdm

tokenizer = mwe.MWETokenizer(separator="")

with open(argv[1], "r") as f:
    corpus = f.read()
corpus = corpus.replace(" ", "_")
lst = list(corpus)
vocab = set(lst)
vocab.add("_")
seen = set()


def run():
    d = defaultdict(int)
    sorted_vocab = sorted(list(vocab), key=lambda x: -len(x))
    tokenizer = mwe.MWETokenizer(separator="")
    for token in sorted_vocab:
        tokenizer.add_mwe(r"{}".format(token))
    lst = tokenizer.tokenize(corpus)
    l = zip(lst, lst[1:])
    for tpl in list(l):
        d["".join(tpl)] += 1
    r = sorted(d.items(), key=lambda x: -x[1])
    counter = 0
    while counter < len(r):
        if r[counter][0] not in seen:
            new = r[counter][0]
            vocab.add(new)
            seen.add(new)
            break
        else:
            counter += 1
    return tokenizer


for k in tqdm(range(1000)):
    tokenizer = run()
print(tokenizer.tokenize(corpus))
