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

pd.set_option("display.max_columns", 50)


def read_file(path, f_name):
    with open("{}/{}".format(path, f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


class Tokenizer:
    def add_new_token(self, tokenizer, string):
        tokenizer.add_mwe(r"{}".format(string))

    def word_lst(self, data):
        nltk_word_list = nltk.word_tokenize(data)
        matched_tokens = set(nltk_word_list).intersection(set(self.tokens))
        unmatched_tokens = set(nltk_words).difference(set(self.tokens))
        return matched_words, unmatched_words

    def balanced(self, start, s, left_symbol=r"{", right_symbol=r"}"):
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
                    matched.append(s[start_offset:current_offset])
                    start_offset = current_offset
        return matched

    def parse_document(self):
        file_data = self.file_data
        self.dct["fractions"].extend(self.regexp_fraction_tokens)

        self.dct["bibliography"].extend(
            self.balanced(r"\\begin{thebibliography}", self.file_data)
        )
        self.dct["cite"].extend(self.balanced(r"\\cite", self.file_data))
        self.dct["date"].extend(self.balanced(r"\\date", self.file_data))
        self.dct["packages"].extend(self.balanced(r"\\usepackage", self.file_data))
        self.dct["title"].extend(self.balanced(r"\\title", self.file_data))
        self.dct["authors"].extend(self.balanced(r"\\author", self.file_data))
        self.dct["affiliations"].extend(self.balanced(r"\\affiliation", self.file_data))
        self.dct["abstract"].extend(self.balanced(r"\\begin{abstract}", self.file_data))
        self.dct["subequations"].extend(
            self.balanced(r"\\begin{subequations}", self.file_data)
        )
        self.dct["equations"].extend(
            self.balanced(r"\\begin{equation}", self.file_data)
        )
        self.dct["equationarray"].extend(
            self.balanced(r"\\begin{eqnarray}", self.file_data)
        )
        self.dct["ref"].extend(self.balanced(r"\\ref", self.file_data))
        self.dct["pacs"].extend(self.balanced(r"\\pacs", self.file_data))
        self.dct["keywords"].extend(self.balanced(r"\\keywords", self.file_data))
        self.dct["label"].extend(self.balanced(r"\\label", self.file_data))
        self.dct["section"].extend(self.balanced(r"\\section", self.file_data))

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
    tokenizer = Tokenizer("sound1.tex")

    for ix, sent in enumerate(tokenizer.sentences):
        resp = [x for x in tokenizer.mwe.tokenize(sent) if x in tokenizer.regexp_tokens]
        if resp:
            print(sent)
            inp = input()
            lst = []
            if inp == "print":
                # print current sentence as a pandas dataframe second line in the df is pos tags
                # this makes it easier to find the relevant patterns in the pos tags that I may care about.
                words = [x[0] for x in tokenizer.tagged_sentences[ix] if x[0].strip()]
                tags = [x[1] for x in tokenizer.tagged_sentences[ix] if x[0].strip()]
                lst.append(words)
                lst.append(tags)
                df = pd.DataFrame(lst)
                print(df.head())

            if inp == "parse":
                # parse LaTeX document into the defaultdict(list) named dct
                print(tokenizer.parse_document())

            if inp == "trace":
                # opens a pudb session where you open an ipython session and explore the data and
                # see how words/sentences are being split up, and to modify the code accordingly.
                set_trace()
