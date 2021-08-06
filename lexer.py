from sys import argv
from collections import defaultdict
from nltk.tokenize import mwe
from nltk import sent_tokenize
import re
import nltk


class Trie(dict):
    #https://github.com/nltk/nltk/blob/develop/nltk/collections.py
    """A Trie implementation for strings"""

    LEAF = True

    def __init__(self, strings=None):
        """Builds a Trie object, which is built around a ``dict``

        If ``strings`` is provided, it will add the ``strings``, which
        consist of a ``list`` of ``strings``, to the Trie.
        Otherwise, it'll construct an empty Trie.

        :param strings: List of strings to insert into the trie
            (Default is ``None``)
        :type strings: list(str)

        """
        super(Trie, self).__init__()
        if strings:
            for string in strings:
                self.insert(string)

    def insert(self, string):
        if len(string):
            self[string[0]].insert(string[1:])
        else:
            if not self[Trie.LEAF]:
                self[Trie.LEAF] = 1
            else:
                self[Trie.LEAF]+=1


    def __missing__(self, key):
        self[key] = Trie()
        return self[key]

def add_new_token(string):
    tokenizer.add_mwe(r"{}".format(string))


def manual_entries(pattern, data):
    resp = re.findall(pattern, data)
    if resp:
        for match in resp:
            add_new_token(match)


def print_symbols_not_used():
    for k, v in symbols_use_count.items():
        if v == 0:
            print(k)


def read_file(path, f_name):
    with open("{}/{}".format(path, f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


def symbols_not_accounted_for(seen_count):
    for item in sorted(dct.items(), key=lambda x: -x[1]):
        if item[1] > seen_count:
            print(item[0])


symbols = list()
dct = defaultdict(int)
tokenizer = mwe.MWETokenizer(separator="")
symbols_use_count = defaultdict(int)

path = "."
data = [x.replace("\n", "") for x in read_file(path, "latex_math.txt").splitlines()]
symbols.extend(data)

#for now only single expressions
path = "."
data = [x.replace("\n", "") for x in read_file(path, "user_defined_symbols_expressions.txt").splitlines()]
symbols.extend(data)


data = [x.replace("\n", "") for x in read_file(path, "latex_misc.txt").splitlines()]
symbols.extend(data)

data = [x.replace("\n", "") for x in read_file(path, "english_vocab.txt").splitlines()]
symbols.extend(data)
symbols = list(set(symbols))
symbols = sorted(symbols, key=lambda x: -len(x))
for symbol in symbols:
    add_new_token(symbol)

file_data = read_file(".", argv[1])


def use_package(s):
    import re

    match = re.match(r"(?P<cmd>\\usepackage)(?P<package>{[a-z]+(,[a-z]+)*})?", s)
    if match:
        cmd = match.group("cmd")
        packages = match.group("package")
        if packages:
            packages = [x.strip() for x in re.split("{|}|,", packages) if x.strip()]
            if packages:
                return {cmd: packages}


def math_mode(s):
    import re

    match = re.findall(r"[^\$](\$\$.*?\$\$)[^\$]", s, re.DOTALL)
    single_line = re.findall(r"[^\$](\$.*?\$)[^\$]", s)
    match.extend(single_line)
    return match


def balanced(start, s, left_symbol=r"{", right_symbol=r"}"):
    # set_trace()
    import re

    # the pattern should include one instance of the left symbol so that balanced=-1
    # if left == right then +- counting fails
    # begin syntax handled automatically, so there is no need to include left_right symbols
    s = re.sub(r'^\\newcommand.*','',re.escape(s))
    if "\\begin" in start:
        match = re.findall(r"\\begin{(.*?)}", start)
        if match:
            match = match[0]
            # print(match)
            left_symbol = f"""\\begin{{{match}}}"""
            right_symbol = f"""\\end{{{match}}}"""
    if left_symbol != right_symbol:
        current_offset = 0
        balanced = 0
        match = re.finditer(r"{}".format(start), s)
        # print(match)
        for m in match:
            if m:
                # print(m)
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
                        print("-1")
                        balanced -= 1
                    current_offset += 1
                print(s[start_offset:current_offset])
                start_offset = current_offset


#balanced(r"\\author{", file_data)
#balanced(r"\\cite{", file_data)
#balanced(r"\\begin{abstract}", file_data)
#print()
#print(r"\usepackage{amsmath,amsfonts,amssymb,latexsym,cite}")
#packages = use_package(r"\usepackage{amsmath,amsfonts,amssymb,latexsym,cite}")
#print(packages)
from time import sleep
results=[]
resp =balanced(r"\\begin{array}",file_data)
if resp:
    results.extend(resp)
resp = balanced(r"\\begin{eqnarray}",file_data)
if resp:
    results.extend(resp)
resp = balanced(r"\\begin{eqnarray*}",file_data)
if resp:
    results.extend(resp)
resp = balanced(r"\\begin{equation}",file_data)
if resp:
    results.extend(resp)
resp = balanced(r"\\begin{equation*}",file_data)
if resp:
    results.extend(resp)

dct = Trie()
math_tex = math_mode(file_data)
for item in math_tex:
    print(item)
    resp = tokenizer.tokenize(item)
    if resp[0] == '$' and resp[-1] == '$':
        resp = resp[1:-1]
        #dct.insert(resp)
        print(resp)
        print('\n\n')
print(dct)