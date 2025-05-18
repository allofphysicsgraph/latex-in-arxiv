from nltk import mwe
from sys import argv
import re

with open(argv[1], "r") as f:
    data = f.read()
    english_vocab = re.findall(r'"(.*?)"', data)

english_word_tokenizer = mwe.MWETokenizer(separator="")
word_list = sorted(english_vocab, key=lambda x: -len(x))
for word in word_list:
    english_word_tokenizer.add_mwe(r"{}".format(word))
