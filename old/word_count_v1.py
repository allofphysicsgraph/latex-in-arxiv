import re
import nltk
from nltk.tokenize import mwe
import functools
from collections import defaultdict
from os import listdir
from tqdm import tqdm

nltk.download("punkt")
nltk.download("stopwords")
path = "."
notseen = defaultdict(int)  # default starts at 0
notseen_latex = defaultdict(int)
notseen_names = defaultdict(int)
files = [x for x in listdir(path) if "." in x]
print(files)


def read_file(f_name):
    with open("{}".format(f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


def valid_word(word):
    if (
        (word not in arxiv_words)
        and (word not in regular_words)
        and (word not in latex_symbols)
        and (word not in stopwords)
    ):
        return False
    return True


tokenizer = mwe.MWETokenizer(separator="")
TOKEN_MIN_LENGTH = 3
seen = []

with open("./WORDS/arxiv_vocab_1.txt", "r") as f:
    data = f.read()
    arxiv_words = set(data.splitlines())

with open("WORDS/words_alpha_len_3ge_v1.txt", "r") as f:
    data = f.read()
    regular_words = set(data.splitlines())

with open("WORDS/latex_symbols", "r") as f:
    data = f.read()
    latex_symbols = set(data.splitlines())

stopwords = set(nltk.corpus.stopwords.words("english"))


def add_new_token(string):
    tokenizer.add_mwe(r"{}".format(string))
    seen.append(r"{}".format(string))


for symbol in latex_symbols:
    add_new_token(symbol)

for word in arxiv_words:
    add_new_token(word)

for word in regular_words:
    add_new_token(word)

for f_name in tqdm(files[:5]):
    data = read_file(f_name)
    word_list = tokenizer.tokenize(data)
    # print(word_list)
    for word in word_list:
        word = word.strip()
        if not valid_word(word):
            if "\\" in word:
                notseen_latex[word] += 1
            else:
                notseen[word] += 1

for ix in sorted(notseen.items(), key=lambda x: -x[1]):
    if len(ix[0]) > 5:
        if not re.findall("/|\\d+|~|\\+|\\^|\\=|^\\-|_|\\|", ix[0]):
            if ix[1] > 15:
                print(ix[0].strip())

tokenizer.tokenize("\\frac{2}{3}")


def tokenize_sentences(text):
    return nltk.tokenize.sent_tokenize(text)


@functools.lru_cache(maxsize=100000)
def valid_token(word):
    if len(word) < TOKEN_MIN_LENGTH:
        return False
    for char in word:
        category = unicodedata.category(char)
        if category[0] == "L":  # letter
            return True
        if category[0] == "P":
            return True
        if category[0] == "N":
            return True
        else:
            print("unicode category", category[0])
    return False


def tokenize_words(text):
    return [
        normalize_word(word)
        for word in nltk.tokenize.word_tokenize(text)
        if valid_token(word)
    ]


# for ix in set(latex_tokens):
#    if len(ix) > 4:
#        resp = r"{}".format(ix)
#        print(resp)
#        add_new_token(resp)
