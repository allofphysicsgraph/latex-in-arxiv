# coding: utf-8
import stanza
import pandas as pd

from collections import defaultdict
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
import nltk
from os import listdir
import re
from time import sleep
from nltk.tokenize import mwe
from nltk import pos_tag


print("RUN make in ../postings_list/tok_to_id/ to generate sample_data")


#!pip install stanza
def read_file(f_name):
    with open("{}".format(f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


tokenizer = mwe.MWETokenizer(separator="")


def add_new_token(string):
    tokenizer.add_mwe("{}".format(string))


def get_paragraphs(file_data):
    paragraphs = txttlng_tokenizer.tokenize(file_data)
    return paragraphs


def sentences_from_file(file_data):
    sentences = tok_cls.sentences_from_text(file_data)
    return sentences


def sentences_from_paragraphs(paragraphs):
    output = []
    for paragraph in paragraphs:
        sentences = tok_cls.sentences_from_text(paragraph)
        for sentence in sentences:
            output.append(sentence)
    return output


def symbol_concordance(sentences):
    concordance_dict = defaultdict(list)
    for sentence in sentences:
        maybe_definition = re.findall("\$.*?\$", sentence)
        if maybe_definition:
            for match in maybe_definition:
                concordance_dict[match].append(sentence)
    return concordance_dict


def get_symbol_definition(concordance_dict):
    symbol_definitions = defaultdict(set)
    labels = [f"DEF{x}" for x in range(100)]
    grammar = r"""
        DEF0: {<DT><JJ><NN><JJ><NN>}

    """
    cp = nltk.chunk.RegexpParser(grammar)
    for symbol, sentences in concordance.items():
        for sent in sentences:
            [add_new_token(x) for x in re.findall("\$.*?\$", sent)]
            resp = tokenizer.tokenize(sent)
            resp = [x for x in resp if x.strip()]
            test = [x for x in resp if "$" in x]
            if test:
                output = cp.parse(pos_tag(resp))
                for subtree in output.subtrees(filter=lambda t: t.label() in labels):
                    # print(subtree)
                    DEF = " ".join([x[0] for x in subtree])
                    if re.findall("\$.*?\$", DEF):
                        if symbol in DEF:
                            symbol_definitions[symbol].add(DEF)
    return symbol_definitions


if 1 == 1:
    txttlng_tokenizer = texttiling.TextTilingTokenizer(
        w=20, k=6, smoothing_width=2, smoothing_rounds=5
    )
    punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
    tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
    results = defaultdict(list)
    from sys import argv

    file_data = read_file("/tmp/sample_data")
    for paragraph in get_paragraphs(file_data):
        results["paragraphs"].append(paragraph)

    for sentence in sentences_from_paragraphs(results["paragraphs"]):
        results["sentences_from_paragraphs"].append(sentence)

    # there are cases where extracting the paragraphs fail is too slow
    # or may not be of interest

    for sentence in sentences_from_file(file_data):
        results["sentences_file"].append(sentence)

    sentences = results["sentences_from_paragraphs"]
    concordance = symbol_concordance(sentences)
    # using mwe tokenizer for now
    latex = read_file("../common/latex.rl")
    latex = [x for x in re.split('"\s+[a-z]+\s+\||\n|\s+\|', latex) if x.strip()]
    latex = [x for x in latex if "\\" in x]
    latex = set(latex)
    latex = sorted(latex, key=lambda x: -len(x))
    latex = [x.replace("\\\\", "\\") for x in latex]

    vocab = read_file("../postings_list/query/vocab.rl")
    vocab = [x for x in re.split('"|\n|\|', vocab) if x.strip()]
    vocab = set(vocab)
    vocab = sorted(vocab, key=lambda x: -len(x))

    for value in latex:
        add_new_token(value)

    for value in vocab:
        add_new_token(value)
    tokens = tokenizer.tokenize(file_data)
    # print(concordance)
    symbol_defs = get_symbol_definition(concordance)
    for k, v in symbol_defs.items():
        print(k, v)


tf_idf_tokens = [
    x.strip() for x in re.findall("<[0-9a-f]{16}>", file_data) if x.strip()
]
seen = set()
tok_lst = []
keep = []
for sent in sentences:
    match = False
    for tok in set(tf_idf_tokens):
        if re.findall(tok, sent):
            match = True
            sent = sent.replace(tok, "LTX{}".format(tf_idf_tokens.index(tok)))
    if match:
        keep.append(sent)
        match = False

for s in keep:
    print(s)
    print("\n", "*" * 50)

nlp = stanza.Pipeline("en", processors="tokenize,mwt,pos,lemma,depparse")
doc = nlp(
    "Two dimensionless fundamental physical constants, the fine structure constant X."
)

for s in doc.sentences:
    l = []
    for x in s.dependencies:
        l.append(x)

    df = pd.DataFrame(l)
    # print(df)
    X = df.itertuples()
    while True:
        try:
            resp = next(X)[1:]
            src = resp[0].to_dict()
            dst = resp[2].to_dict()
            edge = resp[1]
            # print(edge)
            # print('edge {}'.format(resp[1])
            src_ID = src["id"]
            src_TXT = src["text"]
            dst_ID = dst["id"]
            dst_TXT = dst["text"]

            print(f"MERGE (t0:{src_TXT} {{id:{src_ID},txt:'{src_TXT}'}})")
            print(f"MERGE (t1:{dst_TXT} {{id:{dst_ID},txt:'{dst_TXT}'}})")
            print(f"CREATE (t0)-[r:{edge}]->(t1);")
        except:
            break
    # print(df.tail())
