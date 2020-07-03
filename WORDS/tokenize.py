import re
import nltk
from nltk.tokenize import mwe
tokenizer = mwe.MWETokenizer(separator='')import functools
TOKEN_MIN_LENGTH = 3

seen = []

def add_new_token(string):
    tokenizer.add_mwe(r'{}'.format(string))
    seen.append(r'{}'.format(string))

with open("arvix_vocab.txt", "r") as f:
    data = f.read()
    arxiv_words = set(data.splitlines())

with open("words_alpha_len_3ge_v1.txt", "r") as f:
    data = f.read()
    regular_words = set(data.splitlines())

verify = set()


def valid_word(word):
    if word in arxiv_words or word in regular_words:
        return word
    else:
        verify.add(word)


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


for ix in set(latex_tokens):
    if len(ix) > 4:
        resp = r"{}".format(ix)
        print(resp)
        add_new_token(resp)
