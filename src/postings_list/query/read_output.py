from collections import defaultdict
from nltk.tokenize import mwe
from pudb import set_trace
from sys import argv
from tqdm import tqdm
import pandas as pd
import re

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

#print(tokens)
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

zf = df.loc[:, ["type", "token"]]
equations = zf[zf.type == "equation"]
equations = set(equations.token.tolist())
types = [x for x in set(zf.type.tolist()) if x != "equation"]
for eq in equations:
    for typ in types:
        lst = zf[zf.type == typ].token.tolist()
        for xs in lst:
            if typ == "inline":
                xs = xs[1:-1]
            if xs in eq:
                tokens.add(xs)
tokens = list(tokens)
tokens = sorted(tokens, key=lambda x: -len(x))
print(tokens)
for token in tokens:
    tokenizer.add_mwe(r"{}".format(token))

zf = zf[zf.type == "equation"]
zf.drop_duplicates(inplace=True)
zf.to_csv("output.csv", sep="\t", index=False)

for eq in equations:
    print(eq)
    print(tokenizer.tokenize(eq))
    inp = input()


"""
df = df.loc[:, "token"].apply(lambda x: re.sub(r"\n", r"\\\\", x))
df = df.tolist()
for ix,xs in enumerate(df):
    f= open(f'{ix}.tex','w')
    f.write('''\\documentclass[]{article}\n\\usepackage{amsmath}\n\\begin{document}\n''')
    f.write(xs)
    f.write('\n')
    f.write('\\end{document}')
    f.close()

# df.to_csv("output.csv", index=False)
"""
