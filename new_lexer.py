#!/usr/bin/python3

from sys import argv
from pudb import set_trace
import pandas as pd
from sys import argv
from nltk.tokenize import mwe
from time import sleep
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from nltk.tag import pos_tag_sents
from collections import defaultdict
import nltk
import re
from sumy.summarizers.lsa import LsaSummarizer
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.stemmers import Stemmer
from sumy.nlp.tokenizers import Tokenizer
from sumy.nlp.stemmers import Stemmer
from sumy.utils import get_stop_words
from sys import argv


pd.set_option("display.max_columns", 50)


def read_file(path, f_name):
    with open("{}/{}".format(path, f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines() if not re.findall(r"^\\def", x)]
    data = "\n".join(clean)
    return data


def document_summary(document):
    sents = []
    tokenizer = Tokenizer("english")
    stemmer = Stemmer("english")
    parser = PlaintextParser(document, tokenizer)
    stop_words = [x for x in get_stop_words("english") if len(x) > 1]
    summarizer = LsaSummarizer(stemmer)
    summarizer.stop_words = stop_words
    for sent in summarizer(parser.document, len(document.splitlines()) / 2):
        sents.append(sent)
    return sents


class Tokenizer:
    def add_new_token(self, tokenizer, string):
        tokenizer.add_mwe(r"{}".format(string))

    def word_lst(self, data):
        nltk_word_list = nltk.word_tokenize(data)
        matched_words = set(nltk_word_list).intersection(set(self.tokens))
        unmatched_words = set(nltk_word_list).difference(set(self.tokens))
        return matched_words, unmatched_words

    def balanced(self, start, s, left_symbol=r"{", right_symbol=r"}"):
        counter = 0
        matched = []
        lr_match_twice = 0
        s = re.sub(r"\\newcommand.*", "", self.file_data)
        if "\\begin" in start:
            match = re.findall(r"\\begin{(.*?)}", start)
            if match:
                match = match[0]
                left_symbol = f"""\\begin{{{match}}}"""
                right_symbol = f"""\\end{{{match}}}"""
        if left_symbol != right_symbol:
            current_offset = 0
            balanced = 0
            match = re.finditer(r"{}".format(start), s)
            for m in match:
                if m:
                    start_offset = m.start()
                    current_offset = m.end() + 1
                    balanced = -1
                    while balanced != 0:

                        if (
                            s[current_offset : current_offset + len(right_symbol)]
                            == right_symbol
                        ):
                            balanced += 1
                        if (
                            s[current_offset : current_offset + len(left_symbol)]
                            == left_symbol
                        ):
                            balanced -= 1
                        current_offset += 1
                        counter += 1
                        if counter > 500000:
                            print("error on {}".format(start))
                            shutil.move(path + file, "2003_errors/")
                    matched.append(s[start_offset:current_offset])
                    start_offset = current_offset
        counter = 0
        return matched

    def parse_document(self):
        file_data = self.file_data
        self.dct["fractions"].extend(self.regexp_fraction_tokens)

        balanced_tokens = [
            r"\\begin{acknowledgments}",
            r"\\begin{theorem}",
            r"\\begin{prop}",
            r"\\begin{definition}",
            r"\\begin{quote}",
            r"\\begin{twomatrix}",
            r"\\begin{thm}",
            r"\\begin{small}",
            r"\\begin{matrix}",
            r"\\begin{description}",
            r"\\begin{flushleft}",
            r"\\begin{cases}",
            r"\\begin{widetext}",
            r"\\begin{proof}",
            r"\\begin{multline}",
            r"\\begin{align*}",
            r"\\begin{gather}",
            r"\\begin{minipage}",
            r"\\begin{alignat}",
            r"\\begin{fmfgraph}",
            r"\\begin{eq}",
            r"\\begin{titlepage}",
            r"\\begin{displaymath}",
            r"\\begin{flushright}",
            r"\\begin{fmfgraph*}",
            r"\\begin{aligned}",
            r"\\begin{enumerate}",
            r"\\begin{table}",
            r"\\begin{subequations}",
            r"\\begin{pmatrix}",
            r"\\begin{split}",
            r"\\begin{equation\*}",
            r"\\begin{itemize}",
            r"\\begin{eqnarray\*}",
            r"\\begin{picture}",
            r"\\begin{abstract}",
            r"\\begin{tabular}",
            r"\\begin{thebibliography}",
            r"\\begin{document}",
            r"\\begin{figure}",
            r"\\begin{align}",
            r"\\begin{center}",
            r"\\begin{array}",
            r"\\begin{eqnarray}",
            r"\\begin{equation}",
            r"\\section\*",
            r"\\cite",
            r"\\date",
            r"\\usepackage",
            r"\\title",
            r"\\affiliation",
            r"\\title",
            r"\\author",
            r"\\affiliation",
            r"\\begin{abstract}",
            r"\\begin{subequations}",
            r"\\begin{eqnarray}",
            r"\\begin{equation}",
            r"\\ref",
            r"\\pacs",
            r"\\label",
            r"\\section",
        ]
        print(len(balanced_tokens))

        balanced_tokens = [x for x in balanced_tokens if re.findall(x, self.file_data)]
        print(len(balanced_tokens))
        for tok in balanced_tokens:
            key_name = False
            if "\\begin" in tok:
                key_name = re.findall(r"{(.*?)}", tok)
                if key_name:
                    key_name = key_name[0]
                    print(tok, key_name)
            else:
                key_name = tok.replace("\\\\", "")
                print(tok, key_name)
            if key_name:
                self.dct[key_name].extend(
                    self.balanced(r"{}".format(tok), self.file_data)
                )
        # set_trace()

    def __init__(self, file_name):
        self.tokens = []
        self.dct = defaultdict(list)
        self.file_data = read_file(".", file_name)
        self.nltk_word = nltk.word_tokenize
        self.nltk_sent_tokenize = nltk.sent_tokenize
        self.mwe = mwe.MWETokenizer(separator="")

        # TODO error checking on what is matched
        self.regexp = RegexpTokenizer("\$.*?\$")  # to split the latex document
        self.regexp_math = RegexpTokenizer(
            "\$(.*?)\$"
        )  # for tokenizing equations, arrays etc
        self.regexp_fractions = RegexpTokenizer(r"\\frac{.*?}{.*?}")
        self.regexp_fraction_tokens = self.regexp_fractions.tokenize(self.file_data)
        self.regexp_fraction_tokens = [
            x
            for x in self.regexp_fraction_tokens
            if (x.count("{") + x.count("}")) % 2 == 0 and x.count("{") == x.count("}")
        ]  # TODO cover additional cases

        self.latex_tokens = [
            x.strip() for x in read_file(".", "latex_vocab").splitlines()
        ]
        self.english_tokens = [
            x.strip() for x in read_file(".", "english_vocab").splitlines()
        ]
        self.regexp_tokens = self.regexp.tokenize(self.file_data)
        self.regexp_math_tokens = self.regexp_math.tokenize(self.file_data)

        self.tokens.extend(list(set(self.regexp_tokens)))
        self.tokens.extend(list(set(self.regexp_math_tokens)))
        self.tokens.extend(list(set(self.regexp_fraction_tokens)))
        self.tokens.extend(list(set(self.latex_tokens)))
        self.tokens.extend(list(set(self.english_tokens)))
        self.tokens = sorted(self.tokens, key=lambda x: -1 * len(x))

        for token in self.tokens:
            self.add_new_token(self.mwe, token)

        self.sentences = self.nltk_sent_tokenize(self.file_data)
        self.tagged_sentences = nltk.pos_tag_sents(
            [self.mwe.tokenize(sent) for sent in self.sentences]
        )


def symbol_definitions(sentence):
    lst = []
    match = re.findall(r"where \$[a-zA-Z]\$ is.*?(?:\$|$)", sentence, re.DOTALL)
    if match:
        lst.extend(match)
    match = re.findall(r"\$[a-zA-Z]\$ is the.*?(?:and \$|$|, )", sentence, re.DOTALL)
    if match:
        lst.extend(match)
    match = re.findall(r"and \$.*?\$.*?(?:$)", sentence, re.DOTALL)
    if match:
        lst.extend(match)
    match = re.findall(r"and ([a-zA-Z]+\s){1,3}\$.*?\$\.", sentence, re.DOTALL)
    if match:
        lst.extend(match)

    match = re.findall(r"\$[a-zA-Z]\$-function", sentence)
    if match:
        lst.extend(match)
    return lst


if __name__ == "__main__":
    from os import listdir
    import shutil
    from random import shuffle

    manual_iteration = False # set to true to review each sentence of each file where there is a regexp_token
    files = [x for x in listdir("2003") if x.endswith(".tex")]
    shuffle(files)
    file_dct = dict()
    path = "2003/"
    files = listdir(path)
    path = "./"
    files = ["sound1.tex"]

    for file in files:
        try:
            print(file)
            tokenizer = Tokenizer(path + file)
            print("read file")
            tokenizer.parse_document()
            print("parse doc")
            file_dct[file] = tokenizer.dct
        except Exception as e:
            print(e)
            shutil.move(path + file, "2003_errors/")
            break
        cont = 0
        if manual_iteration:
            for ix, sent in enumerate(tokenizer.sentences):
                resp = [
                    x
                    for x in tokenizer.mwe.tokenize(sent)
                    if x in tokenizer.regexp_tokens
                ]
                if resp:
                    print(sent)
                    #inp = input()
                    inp = False
                    lst = []
                    if inp == "break":
                        cont = 1
                        continue  # skip to the next file
                    if inp == "quit":
                        exit(0)  # quit application

                    if inp == "print":
                        # print current sentence as a pandas dataframe append second line of pos tags
                        words = [
                            x[0] for x in tokenizer.tagged_sentences[ix] if x[0].strip()
                        ]
                        tags = [
                            x[1] for x in tokenizer.tagged_sentences[ix] if x[0].strip()
                        ]
                        lst.append(words)
                        lst.append(tags)
                        df = pd.DataFrame(lst)
                        print(df.head())

                    if (
                        inp == "save"
                    ):  # needs more thought on how the data should be saved
                        words = [
                            x[0] for x in tokenizer.tagged_sentences[ix] if x[0].strip()
                        ]
                        tags = [
                            x[1] for x in tokenizer.tagged_sentences[ix] if x[0].strip()
                        ]
                        lst.append(words)
                        lst.append(tags)
                        df = pd.DataFrame(lst)
                        # save.append(df)
                        df.to_csv(
                            "data/training_data/{}_{}_training_sent".format(
                                file.replace(".tex", ""), ix
                            ),
                            index=False,
                        )

                    if inp == "parse":
                        # parse LaTeX document into the defaultdict(list) named dct
                        print(tokenizer.parse_document())

                    if inp == "trace":
                        # opens a pudb session for tracing/viewing results
                        set_trace()
                if cont == 1:
                    break
    for k,v in tokenizer.dct.items():
        df = pd.DataFrame()
        df[k]=v
        df.to_csv('{}_{}.csv'.format(file.replace('.tex',''),k))
