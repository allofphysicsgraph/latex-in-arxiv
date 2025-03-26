from common import read_file
import spacy
nlp = spacy.load('en_core_web_trf')
data = read_file('../../common/sound1.tex')
doc = nlp(data)
[x.text for x in doc]
[x.text,x.pos_ for x in doc]
[(x.text,x.pos_) for x in doc]
[x.text for x in  for x in doc.noun_chunks]
[x.text for x in   doc.noun_chunks]
[x.lemma_ for x in   doc if x.pos_ =='VERB']
[x in doc.ents]
[x for x in doc.ents]
[(x.text,x.label_) for x in doc.ents]

