import sys
import re
import os
import nltk
import configparser
from time import sleep
from sys import argv

from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from collections import defaultdict
from nltk import pos_tag
from time import sleep
from tqdm import tqdm

import sentencepiece as spm

ignore = ["\\begin{abstract}", "\\end{abstract}"]
punkt_trainer_path = "/home/user/latex-in-arxiv/Punkt_LaTeX_SENT_Tokenizer.pickle"
sentence_piece_model_path = "/home/user/latex-in-arxiv/HEP_TEX.model"


def read_file(f_name):
    with open(f"{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [
        x
        for x in data.splitlines()
        if not re.findall(
            r"^\\(def|newcommand|documentclass|begin{document}|usepackage)", x
        )
    ]
    data = "\n".join(clean)
    return data


def concordance(symbol):
    for sent in sents:
        if f"${symbol}$" in sent:
            yield sent


# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=10, smoothing_rounds=20
)

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load(punkt_trainer_path)
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())


file_data = read_file(argv[1])
groups = txttlng_tokenizer.tokenize(file_data)
print(len(groups))
sp = spm.SentencePieceProcessor()
sp.load(sentence_piece_model_path)


sents = []
for group in tqdm(groups):
    sentences = tok_cls.sentences_from_text(group)
    for sent in sentences:
        sents.append(sent)


def strip_tokens(tok):
    if tok[0] == "$":
        tok = tok[1:]
    if tok[-1] == "$":
        tok = tok[:-1]
    return tok


data = read_file(argv[1])

symbols = set()
[symbols.add(x) for x in re.findall("\$.*?\$", data)]
symbols = sorted(list(symbols), key=lambda x: len(x))
symbols = [strip_tokens(tok) for tok in symbols]
# symbols = [tok for tok in symbols]
single_char_symbols = set()
for symbol in symbols:
    if len(symbol) == 1:
        single_char_symbols.add(symbol)


definitions = set()
labels = [f"DEF{x}" for x in range(20)]
grammar = r"""
    DEF: {<DT><JJ><NN><JJ><NN>}
    DEF1: {<DT><JJ><NN><NN><NN>}
    DEF2: {<WRB><NN><VBZ><DT><NN><.*>*}
    DEF3: {<WRB><NN><CC><NN><VBP><JJ><NN><CC><NN>}
    DEF4: {<WRB><NN><VBZ><DT><JJ><NN>}
    DEF5: {<PRP$><NN><VBZ><VBN><IN><DT><NN><NN><NNP>}
    DEF6: {<WRB><NN><VBZ><DT><NN><IN><DT><NN>}
    DEF7: {<CC><NN><VBZ><DT><NN><NN>}
    DEF8: {<NN><VBZ><DT><JJ><NN>}
    DEF9: {<NN><VBZ><DT><NN><NN>}
    DEF10: {<CC><NN><VBZ><DT><NN>}
    DEF11: {<CC><NNP><JJ><NN>}
    DEF12: {<NN><VBZ><DT><NN><NN>}
    DEF13: {<WRB><NN><VBZ><DT><JJ><NN>}
    DEF14: {<WRB><NN><VBZ><DT><JJ><NN><IN><NN>}
    DEF15: {<DT><NN><NN><IN><NNP><CC><NNP><IN><DT><NN><IN><IN><JJ>}
    DEF16: {<JJ><NNP><VBZ><VBN><IN><JJ><NNS>}
    DEF17: {<JJ><NN><IN><DT><NN><IN><NN><IN><JJ><NN><NN>}
    DEF18: {<NN><VBZ><VBN><IN><DT><NN><NN><NNP>}
    DEF19: {<IN><NNS><IN><NN><NN><NNP>}
"""
cp = nltk.chunk.RegexpParser(grammar)
for sent in sents:
    resp = [x[1:] for x in sp.encode_as_pieces(sent) if "".join(x[1:]) not in ignore]
    test = [x for x in resp if "$" in x]
    if test:
        output = cp.parse(pos_tag(resp))
        for subtree in output.subtrees(filter=lambda t: t.label() in labels):
            # print(subtree)
            DEF = " ".join([x[0] for x in subtree])
            if re.findall("\$.*?\$", DEF):
                definitions.add(DEF)

resolved = set()

resolved.add("M")
resolved.add("a")
resolved.add("u")
resolved.add("e")
resolved.add("\\alpha")
resolved.add("c")
resolved.add("m")
resolved.add("f")
resolved.add("G")
resolved.add("K")
resolved.add("\\rho")
resolved.add("\\hbar")
resolved.add("A")
resolved.add("m_e")
resolved.add("k")
resolved.add("v_u")
resolved.add("$E_{\\rm R}$")

#print the list of unresolved symbols
for symbol in [x for x in symbols if x not in resolved]:
    print(symbol)

#print the list of symbol definitions
for definition in sorted(definitions):
    print(definition)
