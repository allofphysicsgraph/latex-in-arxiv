from collections import defaultdict
from ctypes import *
from nltk import pos_tag
from nltk.tokenize import mwe
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from os import listdir
from psycopg2 import connect
from pygments.formatters import Terminal256Formatter
from pygments import highlight
from pygments.lexer import RegexLexer
from pygments.style import Style
from pygments.token import *
from random import shuffle
from rank_bm25 import BM25Okapi
from redis import Redis
from sklearn.feature_extraction.text import CountVectorizer
from sys import argv
from time import sleep
from tqdm import tqdm
import ahocorasick
import configparser
import hashlib
import inspect
import lzma
import nltk
import numpy
import os
import pandas as pd
import re
import rpyc
import sentencepiece as spm
import sys
import yaml

from ragel_begin_end import RagelBeginEnd
from ragel_simple import RagelSimple

with open("config.yaml", "r") as f:
    config = yaml.safe_load(f)

token_list = []


class QueryLexer(RegexLexer):
    tokens = {"root": token_list}


class MyStyle(Style):
    styles = {
        Token.Text: "ansiblack bg:ansiblue",
    }


nltk.download("stopwords")
nltk.download("averaged_perceptron_tagger")

ignore = ["\\begin{abstract}", "\\end{abstract}"]
files = [x for x in listdir(".")]
shuffle(files)
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
# sp.load("HEP_TEX.model")

# the block comparisons are slow and need to be optimized
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    w=20, k=6, smoothing_width=2, smoothing_rounds=5
)


class MyService(rpyc.Service):
    def __init__(self):
        self.results = defaultdict(list)
        self.current_file = ""
        self.redis_client = Redis(decode_responses=True)
        self.data_set_path = "test/"
        self.return_length = []
        self.debug = True
        self.postgres = True

    def on_connect(self, conn):
        print(
            """
                #decompress Punkt_LaTeX_SENT_Tokenizer.pickle.xz
                #decompress HEP_TEX.model.xz
                c = rpyc.connect('127.0.0.1',18861)
                c.root.read_file('sound1.tex','file_data')
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

    def db_cursor(self):
        conn = connect(
            dbname=config["dbname"],
            user=config["user"],
            password=config["password"],
            host=config["host"],
            port=config["port"],
        )
        cursor = conn.cursor()
        return conn, cursor

    def exposed_build_word_tokenizers(self):
        """Tokenization seems difficult to get right, so every file with the extension of .vocab will be used in word tokenization.
         The process that has yielded the most success for me, is to break the tex documents into sections, and process them according
         to the type of text.

         For Example
          macros,
          equations,
          bibliography,
          and document body

          all have differnt expressions that should be used for tokenization.
        The purpose for maintining wordlists is for improved accuracy on word and phrase tokenization.
        """
        english_word_tokenizer = mwe.MWETokenizer(separator="")
        word_list = self.exposed_read_file("english.vocab")
        word_list = sorted(word_list.splitlines(), key=lambda x: -len(x))
        for word in word_list:
            english_word_tokenizer.add_mwe(r"{}".format(word))
        self.results["english_word_tokenizer"].append(english_word_tokenizer)

    def exposed_get_comments(self, data):
        comments = re.findall("%.*", data)
        return comments

    def exposed_read_file(self, f_name):
        # Unable to reliably process files using utf-8 encoding
        with open(f"{f_name}", "r", encoding="ISO-8859-1") as f:
            # from redis import Redis
            # client = Redis()
            # client.set('current_file',f_name)
            data = f.read()
        clean = [
            x
            for x in data.splitlines()
            if not re.findall(
                r"^\\(def|newcommand|documentclass|begin{document}|usepackage)", x
            )
        ]
        data = " ".join(clean)
        # avoid including thebibliography in the TextTiling
        matches = re.findall(
            r"\\begin{thebibliography}.*?\\end{thebibliography}", data, re.DOTALL
        )
        if matches:
            for match in matches:
                # print(match)
                self.results[f"{f_name}_thebibliography"].append(match)
                # print(len(data))
                data = data.replace(match, "")
        # print(len(data))

        comments = self.exposed_get_comments(data)
        for comment in comments:
            data.replace(comment, "")

        self.current_file = f_name
        return data

    def exposed_process_data_set(self, path=False, file_names=[]):
        # if not path:
        #    path = self.data_set_path
        # file_names = listdir(path)
        for f_name in tqdm(file_names):
            print(f_name)
            # f_name_path = self.data_set_path + f_name
            file_data = self.exposed_read_file(f_name)
            # self.redis_client.set(f_name,file_data)
            self.results[f_name].append(file_data)
            self.current_file = f_name
            self.exposed_sentences()

            x = RagelBeginEnd()
            y = RagelSimple()

            x.exposed_get_abstract(data=file_data, current_file=f_name)
            x.exposed_get_equation(data=file_data, current_file=f_name)
            x.exposed_get_figure(data=file_data, current_file=f_name)

            y.exposed_get_caption(data=file_data, current_file=f_name)
            y.exposed_get_bibitem(data=file_data, current_file=f_name)
            y.exposed_get_usepackage(data=file_data, current_file=f_name)
            y.exposed_get_affiliation(data=file_data, current_file=f_name)
            y.exposed_get_author(data=file_data, current_file=f_name)
            y.exposed_get_title(data=file_data, current_file=f_name)
            y.exposed_get_section(data=file_data, current_file=f_name)
            y.exposed_get_label(data=file_data, current_file=f_name)
            y.exposed_get_cite(data=file_data, current_file=f_name)
            y.exposed_get_ref(data=file_data, current_file=f_name)

            # self.exposed_get_align()
            # self.exposed_get_aligned()
            # self.exposed_get_author()
            # self.exposed_get_cases()
            # self.exposed_get_description()
            # self.exposed_get_displaymath()
            # self.exposed_get_emph()
            # self.exposed_get_enumerate()
            # self.exposed_get_flushleft()
            # self.exposed_get_flushright()
            # self.exposed_get_fmfgraph()
            # self.exposed_get_gather()
            # self.exposed_get_label()
            # self.exposed_get_lemma()
            # self.exposed_get_list()
            # self.exposed_get_lstcode()
            # self.exposed_get_lstlisting()
            # #self.exposed_get_mathletters()
            # self.exposed_get_matrix()
            # self.exposed_get_minipage()
            # self.exposed_get_minted()
            # self.exposed_get_multline()
            # self.exposed_get_picture()
            # self.exposed_get_pmatrix()
            # self.exposed_get_proof()
            # self.exposed_get_prop()
            # self.exposed_get_proposition()
            # self.exposed_get_quotation()
            # self.exposed_get_quote()
            # self.exposed_get_references()
            # self.exposed_get_scope()
            # self.exposed_get_split()
            # self.exposed_get_subequations()
            # self.exposed_get_table()
            # self.exposed_get_tabular()
            # self.exposed_get_theorem()
            # self.exposed_get_title()
            # self.exposed_get_titlepage()
            # self.exposed_get_url()
            # self.exposed_get_verbatim()

    def exposed_print_length(self):
        print(
            max(self.return_length),
            sum(self.return_length) / (1.0 * len(self.return_length)),
        )

    def exposed_paragraphs(self):
        current_file = self.current_file
        file_data = self.results[current_file][0]
        paragraphs = txttlng_tokenizer.tokenize(file_data)
        for paragraph in paragraphs:
            # print(paragraph)
            self.results[f"{current_file}_paragraphs"].append(paragraph)

    def exposed_sentences(self):
        current_file = self.current_file
        file_data = self.results[current_file][0]
        sentences = tok_cls.sentences_from_text(file_data)
        # for paragraph in self.results[f"{current_file}_paragraphs"]:
        for sentence in sentences:
            # print(sentence)
            # print("*" * 50)
            # self.results[f"{current_file}_sentences"].append(sentence)
            if self.postgres:
                conn, cursor = self.db_cursor()
                length = len(sentence)
                sentence = sentence.replace("'", "''")
                cursor.execute(
                    f"insert into sentences (filename,sentence,len) values ('{current_file}','{sentence}',{length});"
                )
                conn.commit()

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

    def exposed_rank_bm25(self):
        tokenized_corpus = []
        tokenizer = self.results["english_word_tokenizer"]
        if len(tokenizer) == 1:
            tokenizer = tokenizer[0]
        for sentence in self.results["sentences"]:
            tokens = tokenizer.tokenize(sentence)
            tokens = [x.strip() for x in tokens if len(x.strip()) > 1 and x.strip()]
            tokenized_corpus.append(tokens)
        bm25 = BM25Okapi(tokenized_corpus)
        self.results["bm25"].append(bm25)

    def exposed_query_rank_bm25(self, query_string):
        bm25 = self.results["bm25"][0]
        tokenizer = self.results["english_word_tokenizer"]
        if len(tokenizer) == 1:
            tokenizer = tokenizer[0]
        tokenized_query = tokenizer.tokenize(query_string)
        doc_scores = bm25.get_scores(tokenized_query)
        resp = bm25.get_top_n(tokenized_query, self.results["sentences"], n=5)

        tokens = [
            x.strip() for x in tokenized_query if len(x.strip()) > 1 and x.strip()
        ]
        for word in tokens:
            token_list.append((r"{}".format(word), Text))
        x = QueryLexer()

        for match in resp:
            print(match, "*" * 50, "\n")
            print(highlight(match, x, Terminal256Formatter(style=MyStyle)))

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

    def exposed_bag_of_words(self):
        X = set(self.results["sentences"])
        vectorizer = CountVectorizer(stop_words="english")
        X_vec = vectorizer.fit_transform(X)
        print(vectorizer.vocabulary_)

    def exposed_preprocessing(self):
        df = pd.Series(self.results["sentences"])
        print(df.head())

    def exposed_print_tokenized_sentences(self):
        tokenizer = self.results["english_word_tokenizer"]
        if len(tokenizer) == 1:
            tokenizer = tokenizer[0]
            print(tokenizer)
            for sentence in self.results["sentences"]:
                print(tokenizer.tokenize(sentence))


if __name__ == "__main__":
    from rpyc.utils.server import ThreadedServer
    from sys import argv

    if len(sys.argv) == 2:
        port = int(sys.argv[1])
    else:
        port = 18861

    t = ThreadedServer(
        MyService,
        port=port,
        protocol_config={"allow_pickle": True, "allow_all_attrs": True},
    )
    print("Ready for rpyc clients \n")
    t.start()
