from collections import defaultdict
from nltk.tokenize import mwe
from pudb import set_trace
from sys import argv
from tqdm import tqdm
import pandas as pd
import re
import numpy as np

tokenizer = mwe.MWETokenizer(separator="")


def read_file(f_name):
    with open("{}".format(f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


with open("vocab", "r") as f:
    vocab = [x[:-1] for x in f.readlines()]

data = read_file(argv[1])
tokens = set()
for token in vocab:
    tokens.add(r"{}".format(token))

# print(tokens)
resp = re.findall(
    "(^|\n){<filepath:(.*?)>,filepath_id:(\d+),token_id:(\d+),parent_id:(\d+),offset:(\d+),length:(\d+),type:([a-z_]+),<tok:(.*?)>}",
    data,
    re.DOTALL,
)
output = []
for ix in range(len(resp)):
    output.append([x for x in resp[ix] if x.strip()])
df = pd.DataFrame(output)
df.columns = [
    "filepath",
    "filepath_id",
    "token_id",
    "parent_id",
    "offset",
    "length",
    "type",
    "token",
]
zf = df.loc[:, ["token"]]
s = set(zf.token.tolist())
tokens = tokens.union(s)
tokens = sorted(list(tokens),key=lambda x:-len(x))
tokens = [x for x in tokens if len(x) <1000]

for token in tokens:
    tokenizer.add_mwe(r"{}".format(token))

data = read_file(argv[2])
output = tokenizer.tokenize(data)
output = [x for x in output if len(x)==1]
f = open('review','w')
f.write(''.join(output))
f.close()
