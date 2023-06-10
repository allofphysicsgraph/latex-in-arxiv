from collections import defaultdict
from nltk import pos_tag
from nltk.tokenize import mwe
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from sys import argv
from time import sleep
from tqdm import tqdm
import ahocorasick
import configparser
import nltk
import numpy
import os
import pandas as pd
import re
import rpyc
import sentencepiece as spm
import sys
import lzma
from os import listdir
import hashlib

# Sentencepiece python module
#!pip install sentencepiece
#!pip install nltk

nltk.download("stopwords")
nltk.download("averaged_perceptron_tagger")

ignore = ["\\begin{abstract}", "\\end{abstract}"]
files = [x for x in listdir(".")]
model_files = [x for x in files if x.endswith(".xz")]
decompressed_model_files = ["Punkt_LaTeX_SENT_Tokenizer.pickle", "HEP_TEX.model"]
verify_hash = {
    "Punkt_LaTeX_SENT_Tokenizer.pickle": "a436f489188951661aa0d958ff44946389c0b545ec69fa06377123ad3aa5ceaa",
    "HEP_TEX.model": "1a87d630bbee0c818fe9c723170b83d13dd1bedede8b9ab2a2faeeb5df864127",
}
for model in decompressed_model_files:
    if model not in files:
        print("###Extracting Models")
        with lzma.open(f"{model}.xz") as f:
            file_content = f.read()
            h = hashlib.new("sha256")
            h.update(file_content)
            assert h.hexdigest() == verify_hash[model]

        with open(f"{model}", "wb") as f:
            f.write(file_content)


punkt_trainer_path = "Punkt_LaTeX_SENT_Tokenizer.pickle"
sentence_piece_model_path = "HEP_TEX.model"

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
sp = spm.SentencePieceProcessor()
sp.load("HEP_TEX.model")

txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=100, smoothing_rounds=25000
)



class MyService(rpyc.Service):
    def __init__(self):
        self.results = defaultdict(list)

    def on_connect(self, conn):
        print(
            """
                #decompress Punkt_LaTeX_SENT_Tokenizer.pickle.xz
                #decompress HEP_TEX.model.xz
                c = rpyc.connect('127.0.0.1',18861)
                c.root.read_file('sound1.tex')
                c.root.paragraphs()
                c.root.sentences()
                c.root.symbol_concordance()
                
                results will be stored in self.results
              """
        )

    def on_disconnect(self, conn):
        # code that runs after the connection has already closed
        # (to finalize the service, if needed)
        pass

    def strip_tokens(tok):
        if tok[0] == "$":
            tok = tok[1:]
        if tok[-1] == "$":
            tok = tok[:-1]
        return tok

    def exposed_read_file(self, f_name):
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
        self.results["file_data"].append(data)

    def concordance(self, symbol):
        for sent in self.results["sentences"]:
            if f"${symbol}$" in sent:
                yield sent

    def spe_sent_tokenizer(self, sent):
        return [
            x[1:] for x in sp.encode_as_pieces(sent) if "".join(x[1:]) not in ignore
        ]

    def exposed_paragraphs(self):
        if len(self.results["file_data"]) == 0:
            print("please run file_data(path_to_filename)")
            return

        file_data = self.results["file_data"][0]
        paragraphs = txttlng_tokenizer.tokenize(file_data)
        for paragraph in paragraphs:
            # print(paragraph)
            self.results["paragraphs"].append(paragraph)

    def exposed_sentences(self):
        for paragraph in self.results["paragraphs"]:
            sentences = tok_cls.sentences_from_text(paragraph)
            for sentence in sentences:
                self.results["sentences"].append(sentence)

    def exposed_symbols(self):
        symbols = set()
        [symbols.add(x) for x in re.findall("\$.*?\$", data)]
        symbols = sorted(list(symbols), key=lambda x: len(x))
        symbols = [strip_tokens(tok) for tok in symbols]
        for symbol in symbols:
            if len(symbol) == 1:
                self.results["single_char_symbol"].append(symbol)

    def exposed_symbol_concordance(self):
        concordance_dict = defaultdict(list)
        for sentence in self.results["sentences"]:
            maybe_definition = re.findall("\$.*?\$", sentence)
            if maybe_definition:
                for match in maybe_definition:
                    concordance_dict[match].append(sentence)
        self.results["symbol_concordance"].append(concordance_dict)
        # print(self.results['concordance'])

    def exposed_get_symbol_definition(self):
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
        for symbol, sentences in self.results["symbol_concordance"].items():
            for sent in sentences:
                resp = spe_sent_tokenizer(sent)
                test = [x for x in resp if "$" in x]
                if test:
                    output = cp.parse(pos_tag(resp))
                    for subtree in output.subtrees(
                        filter=lambda t: t.label() in labels
                    ):
                        # print(subtree)
                        DEF = " ".join([x[0] for x in subtree])
                        if re.findall("\$.*?\$", DEF):
                            if symbol in DEF:
                                symbol_definitions[symbol].add(DEF)
        # for definition in symbol_definitions:
        #    self.results['symbol_definitions'].append(definition)

    def exposed_resolved_symbols(self):
        resolved_symbols = set()
        print(self.results["symbol_definitions"])
        # for symbol in self.results[symbol_definitions'][0].keys():
        #    resolved_symbols.add(symbol)
        # for symbol in resolved_symbols:
        #    self.results['resolved_symbols'].append(symbol)
        # print(self.results['resolved_symbols'])

    def exposed_get_results(self):
        print(self.results.keys())
        # print(self.results['symbol_concordance'])
        # print(self.results['symbol_definitions'])


if __name__ == "__main__":
    from rpyc.utils.server import ThreadedServer

    t = ThreadedServer(
        MyService,
        port=18861,
        protocol_config={"allow_pickle": True, "allow_all_attrs": True},
    )
    print("Ready for rpyc clients \n")
    t.start()


"""


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

print(len(resolved_symbols) / (1.0 * len(symbols)))"""
