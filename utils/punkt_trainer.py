from common import read_file
from nltk.tokenize.punkt import PunktTrainer
from nltk.tokenize.punkt import PunktSentenceTokenizer
import pickle
import re

file_path = "/dev/shm/"
data = read_file(file_path, "training_set")
tok_cls = PunktSentenceTokenizer
train_cls = PunktTrainer
trainer = train_cls()
trainer.INCLUDE_ALL_COLLOCS = True
trainer.train(data, finalize=True)
f = open("punkt_html_trainer", "wb")
f.write(pickle.dumps(trainer))
f.close()
sbd = tok_cls(trainer.get_params())
for sentence in sbd.sentences_from_text(data):
    print(sentence)
    words = trainer.__dict__["_lang_vars"].word_tokenize(sentence)
    print(words)
    print("*" * 50)
