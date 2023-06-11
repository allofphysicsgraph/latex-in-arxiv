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

nltk.download("stopwords")
nltk.download("averaged_perceptron_tagger")

ignore = ["\\begin{abstract}", "\\end{abstract}"]
punkt_trainer_path = "/home/user/latex-in-arxiv/Punkt_LaTeX_SENT_Tokenizer.pickle"
sentence_piece_model_path = "/home/user/latex-in-arxiv/HEP_TEX.model"

math_standard_function_names = {}

math_standard_function_names["arccos"] = "\\arccos"
math_standard_function_names["arcsin"] = "\\arcsin"
math_standard_function_names["arctan"] = "\\arctan"
math_standard_function_names["cos"] = "\\cos"
math_standard_function_names["cosh"] = "\\cosh"
math_standard_function_names["cot"] = "\\cot"
math_standard_function_names["coth"] = "\\coth"
math_standard_function_names["csc"] = "\\csc"
math_standard_function_names["deg"] = "\\deg"
math_standard_function_names["det"] = "\\det"
math_standard_function_names["exp"] = "\\exp"
math_standard_function_names["gcd"] = "\\gcd"
math_standard_function_names["lim"] = "\\lim"
math_standard_function_names["sec"] = "\\sec"
math_standard_function_names["sin"] = "\\sin"
math_standard_function_names["sinh"] = "\\sinh"
math_standard_function_names["sup"] = "\\sup"
math_standard_function_names["tan"] = "\\tan"
math_standard_function_names["tanh"] = "\\tanh"


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


def spe_sent_tokenizer(sent):
    return [x[1:] for x in sp.encode_as_pieces(sent) if "".join(x[1:]) not in ignore]


# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=10, smoothing_rounds=20
)

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load(punkt_trainer_path)
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())


data = read_file(argv[1])
groups = txttlng_tokenizer.tokenize(data)
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


symbols = set()
[symbols.add(x) for x in re.findall("\$.*?\$", data)]
symbols = sorted(list(symbols), key=lambda x: len(x))
symbols = [strip_tokens(tok) for tok in symbols]
# symbols = [tok for tok in symbols]
single_char_symbols = set()
for symbol in symbols:
    if len(symbol) == 1:
        single_char_symbols.add(symbol)


concordance_dict = defaultdict(list)
for sent in sents:
    maybe_definition = re.findall("\$.*?\$", sent)
    if maybe_definition:
        for match in maybe_definition:
            concordance_dict[match].append(sent)


symbol_definitions = defaultdict(set)
labels = [f"DEF{x}" for x in range(100)]
grammar = r"""
    DEF0: {<DT><JJ><NN><JJ><NN>}
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
    DEF20: {<PRP><RB><VBD><NNP>}
    DEF21: {<NN><NN><NNP><WRB><NNS><NN><TO><VB>}
    DEF22: {<DT><NN><NN><NNP>}
    DEF23: {<PRP><RB><VBD><NNP>}
    DEF24: {<RB><TO><DT><NN>}
    DEF25: {<IN><JJ><NN><NNP><NNP>}
    DEF26: {<WRB><NNP><NNP><CC><NNP><NNP><VBP><NNP><NN><CC><NN><NN>}
    DEF27: {<PRP><RB><VBD><NNP><CC><NNP>}
    DEF28: {<CC><RB><PRP><VBP><NNS><IN><DT><NN><NN><NN>}
    DEF29: {<CC><DT><JJ><NN><IN><NNP><IN><NNP>}
    DEF30: {<DT><JJ><NN><VBZ><RB><VBN><IN><DT><NN><NNP><NN>}
    DEF31: {<PRP><RB><VBD><NNP><CC><NNP><IN><NNP><TO><VB><IN><DT><JJ><NN><IN><NN><IN><JJ>}
    DEF32: {<VBG><JJ><NNP><IN><NNP><IN><NNP><VBZ>}
    DEF33: {<WRB><NNP><NNP><VBZ><DT><NNP><NN><NNP>}
    DEF34: {<DT><NN><NN><NNP>}
    DEF35: {<DT><JJ><NN><IN><NN><VBZ><JJ>}
    DEF36: {<JJ><NN><NNP><RB><VBZ><IN><DT><NN><IN><NN><TO><VBG><NN>}
    DEF37: {<VBG><NN><CC><JJ><VBZ><VBP>}
    DEF38: {<NNP><NN><WDT><VBZ><DT><NN><NN><IN><DT><NNP><NN>}
    DEF39: {<DT><NN><NN><NNP><NNP><MD><VB><VBN><IN><NN>}
    DEF40: {<DT><NN><NN><VBZ><IN><JJ><CC><MD><VB><VBN><IN><DT><JJ><NN><IN><NN>}
    DEF41: {<JJ><NN><IN><NNS><VBZ><RB><VB><IN><DT><JJ><NN><VBN><IN><DT><NN><IN><NN><CC><DT><JJ><NN><SYM>}
    DEF42: {<JJ><VBZ><DT><NN><JJ><NN><IN><DT><NN><IN><NN><IN><NN>}
    DEF43: {<DT><NNS><IN><DT><NNP><NN><NNP><NNP>}
    DEF44: {<DT><JJ><NNP><NN><NN><VBD><IN><DT><JJ><NN><NNP><NNP><NNP><NN><VBZ><JJ>}
    DEF45: {<DT><NN><NN><NNP><NNP>}
    DEF46: {<VBG><IN><NNP><IN><NNP><CC><NNP><VBP><NNP>}
    DEF47: {<NNP><DT><JJS><NN><VBZ><VBN><IN><JJ>}
"""
cp = nltk.chunk.RegexpParser(grammar)
for symbol, sentences in concordance_dict.items():
    for sent in sentences:
        resp = spe_sent_tokenizer(sent)
        test = [x for x in resp if "$" in x]
        if test:
            output = cp.parse(pos_tag(resp))
            for subtree in output.subtrees(filter=lambda t: t.label() in labels):
                # print(subtree)
                DEF = " ".join([x[0] for x in subtree])
                if re.findall("\$.*?\$", DEF):
                    if symbol in DEF:
                        symbol_definitions[symbol].add(DEF)


resolved_symbols = set()
for symbol in symbol_definitions.keys():
    resolved_symbols.add(symbol)

from redis import Redis

redis_client = Redis(decode_responses=True)
print("resolved_symbols")
print(resolved_symbols)
for k, v in symbol_definitions.items():
    for match in v:
        redis_client.lpush(k, match)

sleep(3)
print("unresolved")
unresolved = ["$" + x + "$" for x in symbols if "$" + x + "$" not in resolved_symbols]
print(unresolved)

sleep(3)
for k, v in concordance_dict.items():
    if k in unresolved:
        print(k, v)

print(len(resolved_symbols) / (1.0 * len(symbols)))
