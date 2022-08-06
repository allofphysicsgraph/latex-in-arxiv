#!/usr/bin/python3

import sys
import sqlalchemy
import re
import pandas as pd
import os
import nltk
import configparser
from sys import argv
from sumy.utils import get_stop_words
from sumy.summarizers.lsa import LsaSummarizer
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.nlp.stemmers import Stemmer
from sqlalchemy import create_engine
from pudb import set_trace
from nltk.tokenize import RegexpTokenizer
from nltk.tokenize import mwe
from collections import defaultdict
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
from nltk.tokenize import SExprTokenizer
from time import sleep
import pandas as pd
from sys import argv
from os import listdir
import re

# store document as a list of logical groupings, basically paragraphs
txttlng_tokenizer = texttiling.TextTilingTokenizer(
    smoothing_width=50, smoothing_rounds=50000
)

# training a sentence tokenizer on scientific LaTeX documents.
punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
balanced_test_tokenizer=SExprTokenizer(parens='$$',strict=True)


pd.set_option("display.max_columns", 50)

def read_file(path, f_name):
    with open(f"{path}/{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines() if not re.findall(r"^\\def|^\\newcommand", x)]
    data = "\n".join(clean)
    return data


file_data = read_file('.',argv[1])

def replace_tex_with_token_name(csv_file_name,prefix,file_data): 
    with open(csv_file_name,'r') as f:
        csv_data = f.read()
        patterns = re.findall(f'''({prefix}.*?)<T_SPLIT>.*?\n''',csv_data,re.DOTALL)
    for ix,pattern in enumerate(patterns):
        file_data = file_data.replace(pattern,"<T_{}_{}>".format(csv_file_name.replace(".csv",'').upper(),ix))
    return file_data


file_data = replace_tex_with_token_name('equation.csv',r'\\begin{equation}',file_data=file_data)
file_data = replace_tex_with_token_name('cite.csv',r'\\cite',file_data=file_data)
file_data = replace_tex_with_token_name('author.csv',r'\\author',file_data=file_data)
file_data = replace_tex_with_token_name('affiliation.csv',r'\\affiliation',file_data=file_data)
file_data = replace_tex_with_token_name('usepackage.csv',r'\\usepackage',file_data=file_data)
file_data = replace_tex_with_token_name('ref.csv',r'\\ref',file_data=file_data)

#testing a process for replacing math latex in the sentences temporarily for the purposing of tagging
#and then to get the structure the the phrases which define the variables in the tex files.
#steps should include extract all math, equations, etc, determine where the variables are 
#then find their definitions and properties. 
grammar = "NP: {<DT>?<JJ>*<NN>{1,2}}"
cp = nltk.RegexpParser(grammar)

groups = txttlng_tokenizer.tokenize(file_data)
sentences = []
tex_math = []
word_frequency_dist = defaultdict(int)
tex_math_seen = set()
for group in groups:
    for sent in tok_cls.tokenize(group):
        sentences.append(sent)

for sent in sentences:

    words = punkt_trainer.__dict__['_lang_vars'].word_tokenize(sent)
    tags = nltk.pos_tag(words)
    test = balanced_test_tokenizer.tokenize(sent)
    if len(test) > 1:
        regexpTokenizer = nltk.RegexpTokenizer("\$.*?\$")
        math_expressions = regexpTokenizer.tokenize(sent)
        for tex in math_expressions:
            if tex in tex_math_seen:
                tex_math_index = tex_math.index(tex)
            else:
                tex_math.append(tex)
                tex_math_index = tex_math.index(tex)
                tex_math_seen.add(tex)

            sent = sent.replace(tex,"<TEX_MATH_{}>".format(tex_math_index))
        if '$$' in sent:
            regexpTokenizer = nltk.RegexpTokenizer("\$\$.*?\$\$")
            multiline_math_expressions = regexpTokenizer.tokenize(sent)
            for tex in multiline_math_expressions:
                sent = sent.replace(tex,"MULTILINE_TEX_MATH")
        if sent:
            print(sent)
            words = punkt_trainer.__dict__['_lang_vars'].word_tokenize(sent)
            for word in words:
                word_frequency_dist[word]+=1
            print(words)
            print('*'*50,'\n')
            #sleep(5)
    #result = cp.parse(tags)
    #print(result)
    #inp = input()


exit(0)


exit(0)
#set_trace()
#set_trace()
trainer.__dict__['_lang_vars'].word_tokenizetrainer.__dict__['_lang_vars'].word_tokenize
#words = document_summary(data, 0.10)
#words = sorted(words.items(), key=lambda x: -x[1])
#print(words)
#exit(0)


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
                            print(f"error on {start}")
                            self.log_file.write(
                                "{} error on {}".format(self.file_name, start)
                            )
                            self.log_file.write("\n")
                            break
                    matched.append(s[start_offset:current_offset])
                    start_offset = current_offset
        counter = 0
        return matched

    def parse_document(self):
        file_data = self.file_data
        self.dct["frac"].extend(self.regexp_fraction_tokens)

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
            r"\\author",
            r"\\affiliation",
            r"\\begin{abstract}",
            r"\\begin{subequations}",
            r"\\begin{eqnarray}",
            r"\\begin{equation}",
            r"\\ref",
            r"\\pacs",
            r"\\label",
        ]
        balanced_tokens = list(set(balanced_tokens))
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
        self.file_name = file_name
        self.log_file = open("log_file", "a+")
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
    import shutil

    to_csv = False
    manual_iteration = False  # set to true to review each sentence of each file where there is a regexp_token
    file_dct = {}
    path = ""
    files = []
    files.append(argv[1])
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
                    # inp = input()
                    inp = False
                    lst = []
                    if inp == "break":
                        cont = 1
                        continue  # skip to the next file
                    if inp == "quit":
                        sys.exit(0)  # quit application

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
                        if to_csv:
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
        for k, v in tokenizer.dct.items():
            df = pd.DataFrame()
            df[k] = v
            df["filename"] = file
            print(df.head())
            if not df.empty:
                if "/" in file:
                    file_name = [x.strip() for x in re.split("/", file) if x.strip()]
                    file_name = file_name[-1]
                else:
                    file_name = file
                file_name = file_name.replace("_newcmd_", "_")
                # print(file_name)
                if to_csv:
                    df.to_csv(
                        "data/csvs/{}_{}.csv".format(file_name.replace(".tex", ""), k)
                    )
                # print(df.head())
                # enable this line to save to auto save to db
                # basic error checking
                # verify the keys are valid to avoid some invalid matches
                df = df[
                    df.loc[:, k].apply(
                        lambda x: True
                        if re.findall(k + "{", str(x)[:20])
                        and str(x).count("{") == str(x).count("}")
                        and (str(x).count("{") + str(x).count("}")) % 2 == 0
                        else False
                    )
                ]
                df.to_sql(k, engine, if_exists="append")
