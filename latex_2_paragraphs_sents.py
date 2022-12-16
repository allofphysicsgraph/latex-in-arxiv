import sys
import re
import os
import nltk
import configparser
from time import sleep
from sys import argv
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from collections import defaultdict


def read_file(f_name, path="."):
    with open(f"{path}/{f_name}", "r", encoding="ISO-8859-1") as f:
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


def pda(init_pattern, push_tok, pop_tok, bal=0, data=""):
    """>>> pda(r'\\title','{','}',bal=0,data=sents[0])"""
    
    from collections import defaultdict
    import re
    
    keep = defaultdict(list)
    match = re.findall(init_pattern, data)
    if match:
        key = match[0]
        current_idx = data.index(match[0]) + len(init_pattern) - 1
        while current_idx < len(data):
            search = data[current_idx : current_idx + max(len(push_tok), len(pop_tok))]
            keep[key].append(search)
            if push_tok in search:
                bal += 1
            if pop_tok in search:
                bal -= 1
            if bal == 0:
                return {key: "".join(keep[key][1:-1])}
            current_idx += max(len(push_tok), len(pop_tok))


# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=250, smoothing_rounds=550000
)

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
balanced_test_tokenizer = SExprTokenizer(parens="$$", strict=True)

file_data = read_file(argv[1])
groups = txttlng_tokenizer.tokenize(file_data)
print(len(groups))
from time import sleep
from tqdm import tqdm

sents = []
for group in tqdm(groups):
    # print('*'*80,'\n')
    sentences = tok_cls.sentences_from_text(group)
    for sent in sentences:
        sents.append(sent)
        # print(sent,'\n','*'*25,'\n')
        # sleep(1)

# bp
import networkx as nx
import numpy

tfidf_vectorizer = TfidfVectorizer(
    max_features=200000, stop_words="english", use_idf=True
)
tfidf_matrix = tfidf_vectorizer.fit_transform(sents)
print(tfidf_matrix.shape)
dist = 1 - cosine_similarity(tfidf_matrix)
print(dist)

G = nx.Graph()
edge_count = 0
for coord_xy in numpy.argwhere(dist < 0.6):
    if dist[coord_xy[0], coord_xy[1]] > 0.001:
        G.add_edge(coord_xy[0], coord_xy[1], weight=dist[coord_xy[0], coord_xy[1]])

from collections import defaultdict

clique_sizes = defaultdict(int)

for this_clique in nx.enumerate_all_cliques(G):
    clique_sizes[len(this_clique)] += 1
#
