from common import read_file
import ahocorasick
import nltk

nltk.download("punkt")

file = read_file(".", "english.vocab")
file_data = file.splitlines()

A = ahocorasick.Automaton(ahocorasick.STORE_INTS)
for word in file_data:
    A.add_word(word)

sound = read_file(".", "sound1.tex")
s = set()
for word in nltk.word_tokenize(sound):
    try:
        A.get(word)
    except Exception as e:
        s.add(word)
print(s)
