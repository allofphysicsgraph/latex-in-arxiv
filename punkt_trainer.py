from new_lexer import read_file
from nltk.tokenize.punkt import PunktTrainer
from nltk.tokenize.punkt import PunktSentenceTokenizer
import pickle
data = read_file('HEP','xaa')
tok_cls=PunktSentenceTokenizer 
train_cls=PunktTrainer
trainer = train_cls()
trainer.INCLUDE_ALL_COLLOCS = True
trainer.train(data,finalize=False)
data = read_file('HEP','xab')
trainer.train(data,finalize=False)
data = read_file('HEP','xac')
trainer.train(data,finalize=True)
f = open('punkt_new_trainer','wb')
f.write(pickle.dumps(trainer))
f.close()
#sbd = tok_cls(trainer.get_params())
#for sentence in sbd.sentences_from_text(text):
#    print(cleanup(sentence))

