from collections import defaultdict
from ctypes import *
from nltk import pos_tag
from nltk.tokenize import mwe
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import SExprTokenizer
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from os import listdir
from rank_bm25 import BM25Okapi
from sklearn.feature_extraction.text import CountVectorizer
from sys import argv
from time import sleep
from tqdm import tqdm
import ahocorasick
import configparser
import hashlib
import lzma
import nltk
import numpy
import os
import pandas as pd
import re
import rpyc
import sentencepiece as spm
import sys
from pygments.lexer import RegexLexer
from pygments.token import *
from pygments import highlight
from pygments.formatters import Terminal256Formatter
from pygments.style import Style
from random import shuffle
import inspect

# from redis import Redis

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
        # self.redis_client = Redis(decode_responses=True)
        self.data_set_path = "test/"
        self.return_length = []
        self.debug = True

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
        data = "\n".join(clean)
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

    def exposed_process_data_set(self):
        path = self.data_set_path
        file_names = listdir(path)
        for f_name in tqdm(file_names):
            print(f_name)
            f_name_path = self.data_set_path + f_name
            file_data = self.exposed_read_file(f_name_path)
            # self.redis_client.set(f_name,file_data)
            self.results[f_name].append(file_data)
            self.current_file = f_name
            self.exposed_sentences()


            self.exposed_get_abstract()
            self.exposed_get_affiliation()
            self.exposed_get_align()
            self.exposed_get_aligned()
            self.exposed_get_author()
            self.exposed_get_cases()
            self.exposed_get_cite()
            self.exposed_get_description()
            self.exposed_get_displaymath()
            self.exposed_get_emph()
            self.exposed_get_enumerate()
            self.exposed_get_flushleft()
            self.exposed_get_flushright()
            self.exposed_get_fmfgraph()
            self.exposed_get_gather()
            self.exposed_get_label()
            self.exposed_get_lemma()
            self.exposed_get_list()
            self.exposed_get_lstcode()
            self.exposed_get_lstlisting()
            self.exposed_get_mathletters()
            self.exposed_get_matrix()
            self.exposed_get_minipage()
            self.exposed_get_minted()
            self.exposed_get_multline()
            self.exposed_get_picture()
            self.exposed_get_pmatrix()
            self.exposed_get_proof()
            self.exposed_get_prop()
            self.exposed_get_proposition()
            self.exposed_get_quotation()
            self.exposed_get_quote()
            self.exposed_get_ref()
            self.exposed_get_references()
            self.exposed_get_scope()
            self.exposed_get_section()
            self.exposed_get_split()
            self.exposed_get_subequations()
            self.exposed_get_table()
            self.exposed_get_tabular()
            self.exposed_get_theorem()
            self.exposed_get_title()
            self.exposed_get_titlepage()
            self.exposed_get_url()
            self.exposed_get_verbatim()
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
            self.results[f"{current_file}_sentences"].append(sentence)
     
    def exposed_get_cite(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for cite_match in re.findall(r"\\cite{.{,1000}",data):
            s = c_char_p(str.encode(cite_match))
            cite = CDLL("./cite.so")
            cite.test.restype = c_char_p
            if save or print_results:
                cite.init()
                for match in cite.test(s).decode().splitlines():
                    if save:
                        self.results[f"{current_file}_cite"].append(match)
                    if print_results:
                        print(match)
    def exposed_get_ref(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for ref_match in re.findall(r"\\ref{.{,1000}",data):
            s = c_char_p(str.encode(ref_match))
            ref = CDLL("./ref.so")
            ref.test.restype = c_char_p
            if save or print_results:
                ref.init()
                for match in ref.test(s).decode().splitlines():
                    if save:
                        self.results[f"{current_file}_ref"].append(match)
                    if print_results:
                        print(match)
    def exposed_get_author(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for author_match in re.findall(r"\\author{.{,1000}",data):
            s = c_char_p(str.encode(author_match))
            author = CDLL("./author.so")
            author.test.restype = c_char_p
            if save or print_results:
                author.init()
                for match in author.test(s).decode().splitlines():
                    if save:
                        self.results[f"{current_file}_author"].append(match)
                    if print_results:
                        print(match)
    def exposed_get_title(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for title_match in re.findall(r"\\title{.{,1000}",data):
            s = c_char_p(str.encode(title_match))
            title = CDLL("./title.so")
            title.test.restype = c_char_p
            if save or print_results:
                title.init()
                for match in title.test(s).decode().splitlines():
                    if save:
                        self.results[f"{current_file}_title"].append(match)
                    if print_results:
                        print(match)
    def exposed_get_affiliation(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        s = c_char_p(str.encode(data))
        affiliation = CDLL("./affiliation.so")
        affiliation.test.restype = c_char_p
        if save or print_results:
            affiliation.init()
            for match in affiliation.test(s).decode().splitlines():
                if save:
                    self.results[f"{current_file}_affiliation"].append(match)
                if print_results:
                    print(match)

    def exposed_get_abstract(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{abstract}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{abstract}.{,7500}\\end{abstract}", data, re.DOTALL
                    )
                    for match_abstract in data:
                        s = c_char_p(str.encode(match_abstract))
                        abstract = CDLL("./abstract.so")
                        abstract.test.restype = c_char_p
                        abstract.init()
                        for match in abstract.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_abstract"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_align(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{align}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{align}.{,7500}\\end{align}", data, re.DOTALL
                    )
                    for match_align in data:
                        s = c_char_p(str.encode(match_align))
                        align = CDLL("./align.so")
                        align.test.restype = c_char_p
                        align.init()
                        for match in align.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_align"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_aligned(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{aligned}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{aligned}.{,7500}\\end{aligned}", data, re.DOTALL
                    )
                    for match_aligned in data:
                        s = c_char_p(str.encode(match_aligned))
                        aligned = CDLL("./aligned.so")
                        aligned.test.restype = c_char_p
                        aligned.init()
                        for match in aligned.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_aligned"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_cases(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{cases}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{cases}.{,7500}\\end{cases}", data, re.DOTALL
                    )
                    for match_cases in data:
                        s = c_char_p(str.encode(match_cases))
                        cases = CDLL("./cases.so")
                        cases.test.restype = c_char_p
                        cases.init()
                        for match in cases.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_cases"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_description(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{description}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{description}.{,7500}\\end{description}",
                        data,
                        re.DOTALL,
                    )
                    for match_description in data:
                        s = c_char_p(str.encode(match_description))
                        description = CDLL("./description.so")
                        description.test.restype = c_char_p
                        description.init()
                        for match in description.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_description"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_displaymath(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{displaymath}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{displaymath}.{,7500}\\end{displaymath}",
                        data,
                        re.DOTALL,
                    )
                    for match_displaymath in data:
                        s = c_char_p(str.encode(match_displaymath))
                        displaymath = CDLL("./displaymath.so")
                        displaymath.test.restype = c_char_p
                        displaymath.init()
                        for match in displaymath.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_displaymath"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_enumerate(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{enumerate}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{enumerate}.{,7500}\\end{enumerate}", data, re.DOTALL
                    )
                    for match_enumerate in data:
                        s = c_char_p(str.encode(match_enumerate))
                        enumerate = CDLL("./enumerate.so")
                        enumerate.test.restype = c_char_p
                        enumerate.init()
                        for match in enumerate.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_enumerate"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_flushleft(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{flushleft}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{flushleft}.{,7500}\\end{flushleft}", data, re.DOTALL
                    )
                    for match_flushleft in data:
                        s = c_char_p(str.encode(match_flushleft))
                        flushleft = CDLL("./flushleft.so")
                        flushleft.test.restype = c_char_p
                        flushleft.init()
                        for match in flushleft.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_flushleft"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_flushright(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{flushright}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{flushright}.{,7500}\\end{flushright}", data, re.DOTALL
                    )
                    for match_flushright in data:
                        s = c_char_p(str.encode(match_flushright))
                        flushright = CDLL("./flushright.so")
                        flushright.test.restype = c_char_p
                        flushright.init()
                        for match in flushright.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_flushright"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_fmfgraph(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{fmfgraph}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{fmfgraph}.{,7500}\\end{fmfgraph}", data, re.DOTALL
                    )
                    for match_fmfgraph in data:
                        s = c_char_p(str.encode(match_fmfgraph))
                        fmfgraph = CDLL("./fmfgraph.so")
                        fmfgraph.test.restype = c_char_p
                        fmfgraph.init()
                        for match in fmfgraph.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_fmfgraph"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_gather(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{gather}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{gather}.{,7500}\\end{gather}", data, re.DOTALL
                    )
                    for match_gather in data:
                        s = c_char_p(str.encode(match_gather))
                        gather = CDLL("./gather.so")
                        gather.test.restype = c_char_p
                        gather.init()
                        for match in gather.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_gather"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_lemma(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{lemma}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{lemma}.{,7500}\\end{lemma}", data, re.DOTALL
                    )
                    for match_lemma in data:
                        s = c_char_p(str.encode(match_lemma))
                        lemma = CDLL("./lemma.so")
                        lemma.test.restype = c_char_p
                        lemma.init()
                        for match in lemma.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_lemma"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_list(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{list}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{list}.{,7500}\\end{list}", data, re.DOTALL
                    )
                    for match_list in data:
                        s = c_char_p(str.encode(match_list))
                        list = CDLL("./list.so")
                        list.test.restype = c_char_p
                        list.init()
                        for match in list.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_list"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_lstcode(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{lstcode}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{lstcode}.{,7500}\\end{lstcode}", data, re.DOTALL
                    )
                    for match_lstcode in data:
                        s = c_char_p(str.encode(match_lstcode))
                        lstcode = CDLL("./lstcode.so")
                        lstcode.test.restype = c_char_p
                        lstcode.init()
                        for match in lstcode.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_lstcode"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_lstlisting(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{lstlisting}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{lstlisting}.{,7500}\\end{lstlisting}", data, re.DOTALL
                    )
                    for match_lstlisting in data:
                        s = c_char_p(str.encode(match_lstlisting))
                        lstlisting = CDLL("./lstlisting.so")
                        lstlisting.test.restype = c_char_p
                        lstlisting.init()
                        for match in lstlisting.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_lstlisting"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_mathletters(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{mathletters}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{mathletters}.{,7500}\\end{mathletters}",
                        data,
                        re.DOTALL,
                    )
                    for match_mathletters in data:
                        s = c_char_p(str.encode(match_mathletters))
                        mathletters = CDLL("./mathletters.so")
                        mathletters.test.restype = c_char_p
                        mathletters.init()
                        for match in mathletters.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_mathletters"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_matrix(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{matrix}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{matrix}.{,7500}\\end{matrix}", data, re.DOTALL
                    )
                    for match_matrix in data:
                        s = c_char_p(str.encode(match_matrix))
                        matrix = CDLL("./matrix.so")
                        matrix.test.restype = c_char_p
                        matrix.init()
                        for match in matrix.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_matrix"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_minipage(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{minipage}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{minipage}.{,7500}\\end{minipage}", data, re.DOTALL
                    )
                    for match_minipage in data:
                        s = c_char_p(str.encode(match_minipage))
                        minipage = CDLL("./minipage.so")
                        minipage.test.restype = c_char_p
                        minipage.init()
                        for match in minipage.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_minipage"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_minted(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{minted}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{minted}.{,7500}\\end{minted}", data, re.DOTALL
                    )
                    for match_minted in data:
                        s = c_char_p(str.encode(match_minted))
                        minted = CDLL("./minted.so")
                        minted.test.restype = c_char_p
                        minted.init()
                        for match in minted.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_minted"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_multline(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{multline}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{multline}.{,7500}\\end{multline}", data, re.DOTALL
                    )
                    for match_multline in data:
                        s = c_char_p(str.encode(match_multline))
                        multline = CDLL("./multline.so")
                        multline.test.restype = c_char_p
                        multline.init()
                        for match in multline.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_multline"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_picture(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{picture}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{picture}.{,7500}\\end{picture}", data, re.DOTALL
                    )
                    for match_picture in data:
                        s = c_char_p(str.encode(match_picture))
                        picture = CDLL("./picture.so")
                        picture.test.restype = c_char_p
                        picture.init()
                        for match in picture.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_picture"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_pmatrix(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{pmatrix}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{pmatrix}.{,7500}\\end{pmatrix}", data, re.DOTALL
                    )
                    for match_pmatrix in data:
                        s = c_char_p(str.encode(match_pmatrix))
                        pmatrix = CDLL("./pmatrix.so")
                        pmatrix.test.restype = c_char_p
                        pmatrix.init()
                        for match in pmatrix.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_pmatrix"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_proof(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{proof}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{proof}.{,7500}\\end{proof}", data, re.DOTALL
                    )
                    for match_proof in data:
                        s = c_char_p(str.encode(match_proof))
                        proof = CDLL("./proof.so")
                        proof.test.restype = c_char_p
                        proof.init()
                        for match in proof.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_proof"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_prop(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{prop}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{prop}.{,7500}\\end{prop}", data, re.DOTALL
                    )
                    for match_prop in data:
                        s = c_char_p(str.encode(match_prop))
                        prop = CDLL("./prop.so")
                        prop.test.restype = c_char_p
                        prop.init()
                        for match in prop.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_prop"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_proposition(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{proposition}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{proposition}.{,7500}\\end{proposition}",
                        data,
                        re.DOTALL,
                    )
                    for match_proposition in data:
                        s = c_char_p(str.encode(match_proposition))
                        proposition = CDLL("./proposition.so")
                        proposition.test.restype = c_char_p
                        proposition.init()
                        for match in proposition.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_proposition"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_quotation(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{quotation}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{quotation}.{,7500}\\end{quotation}", data, re.DOTALL
                    )
                    for match_quotation in data:
                        s = c_char_p(str.encode(match_quotation))
                        quotation = CDLL("./quotation.so")
                        quotation.test.restype = c_char_p
                        quotation.init()
                        for match in quotation.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_quotation"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_quote(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{quote}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{quote}.{,7500}\\end{quote}", data, re.DOTALL
                    )
                    for match_quote in data:
                        s = c_char_p(str.encode(match_quote))
                        quote = CDLL("./quote.so")
                        quote.test.restype = c_char_p
                        quote.init()
                        for match in quote.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_quote"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_references(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{references}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{references}.{,7500}\\end{references}", data, re.DOTALL
                    )
                    for match_references in data:
                        s = c_char_p(str.encode(match_references))
                        references = CDLL("./references.so")
                        references.test.restype = c_char_p
                        references.init()
                        for match in references.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_references"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_scope(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{scope}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{scope}.{,7500}\\end{scope}", data, re.DOTALL
                    )
                    for match_scope in data:
                        s = c_char_p(str.encode(match_scope))
                        scope = CDLL("./scope.so")
                        scope.test.restype = c_char_p
                        scope.init()
                        for match in scope.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_scope"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_split(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{split}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{split}.{,7500}\\end{split}", data, re.DOTALL
                    )
                    for match_split in data:
                        s = c_char_p(str.encode(match_split))
                        split = CDLL("./split.so")
                        split.test.restype = c_char_p
                        split.init()
                        for match in split.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_split"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_subequations(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{subequations}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{subequations}.{,7500}\\end{subequations}",
                        data,
                        re.DOTALL,
                    )
                    for match_subequations in data:
                        s = c_char_p(str.encode(match_subequations))
                        subequations = CDLL("./subequations.so")
                        subequations.test.restype = c_char_p
                        subequations.init()
                        for match in subequations.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_subequations"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_table(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{table}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{table}.{,7500}\\end{table}", data, re.DOTALL
                    )
                    for match_table in data:
                        s = c_char_p(str.encode(match_table))
                        table = CDLL("./table.so")
                        table.test.restype = c_char_p
                        table.init()
                        for match in table.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_table"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_tabular(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{tabular}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{tabular}.{,7500}\\end{tabular}", data, re.DOTALL
                    )
                    for match_tabular in data:
                        s = c_char_p(str.encode(match_tabular))
                        tabular = CDLL("./tabular.so")
                        tabular.test.restype = c_char_p
                        tabular.init()
                        for match in tabular.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_tabular"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_theorem(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{theorem}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{theorem}.{,7500}\\end{theorem}", data, re.DOTALL
                    )
                    for match_theorem in data:
                        s = c_char_p(str.encode(match_theorem))
                        theorem = CDLL("./theorem.so")
                        theorem.test.restype = c_char_p
                        theorem.init()
                        for match in theorem.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_theorem"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_titlepage(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{titlepage}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{titlepage}.{,7500}\\end{titlepage}", data, re.DOTALL
                    )
                    for match_titlepage in data:
                        s = c_char_p(str.encode(match_titlepage))
                        titlepage = CDLL("./titlepage.so")
                        titlepage.test.restype = c_char_p
                        titlepage.init()
                        for match in titlepage.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_titlepage"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_verbatim(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{verbatim}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{verbatim}.{,7500}\\end{verbatim}", data, re.DOTALL
                    )
                    for match_verbatim in data:
                        s = c_char_p(str.encode(match_verbatim))
                        verbatim = CDLL("./verbatim.so")
                        verbatim.test.restype = c_char_p
                        verbatim.init()
                        for match in verbatim.test(s).decode().splitlines():
                            if save:
                                # print(match)
                                self.results[f"{current_file}_verbatim"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))



    def exposed_get_slm(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        s = c_char_p(str.encode(data))
        slm = CDLL("./slm.so")
        slm.test.restype = c_char_p
        if save or print_results:
            slm.init()
            for match in slm.test(s).decode().splitlines():
                if save:
                    self.results["slm"].append(match)
                if print_results:
                    print(match)

    def exposed_get_section(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        s = c_char_p(str.encode(data))
        section = CDLL("./section.so")
        section.test.restype = c_char_p
        if save or print_results:
            section.init()
            for match in section.test(s).decode().splitlines():
                if save:
                    self.results[f"{current_file}_section"].append(match)
                if print_results:
                    print(match)
  

    def exposed_get_emph(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for emph_match in re.findall(r"\\emph{.{,1000}",data):
            s = c_char_p(str.encode(emph_match))
            emph = CDLL("./emph.so")
            emph.test.restype = c_char_p
            if save or print_results:
                emph.init()
                for match in emph.test(s).decode().splitlines():
                    if save:
                        self.results[f"{current_file}_emph"].append(match)
                    if print_results:
                        print(match)

    def exposed_get_label(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for label_match in re.findall(r"\\label{.{,1000}",data):
            s = c_char_p(str.encode(label_match))
            label = CDLL("./label.so")
            label.test.restype = c_char_p
            if save or print_results:
                label.init()
                for match in label.test(s).decode().splitlines():
                    if save:
                        self.results[f"{current_file}_label"].append(match)
                    if print_results:
                        print(match)

    def exposed_get_url(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        current_file = self.current_file
        file_data = self.results[current_file][0]
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        s = c_char_p(str.encode(data))
        url = CDLL("./url.so")
        url.test.restype = c_char_p
        if save or print_results:
            url.init()
            for match in url.test(s).decode().splitlines():
                if save:
                    self.results[f"{current_file}_url"].append(match)
                if print_results:
                    print(match)

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

    t = ThreadedServer(
        MyService,
        port=18861,
        protocol_config={"allow_pickle": True, "allow_all_attrs": True},
    )
    print("Ready for rpyc clients \n")
    t.start()
