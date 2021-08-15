from sumy.summarizers.lsa import LsaSummarizer
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.stemmers import Stemmer
from sumy.nlp.tokenizers import Tokenizer
from sumy.nlp.stemmers import Stemmer
from sumy.utils import get_stop_words
from time import sleep
from sys import argv


with open(argv[1]) as f:
    document = f.read()


tokenizer = Tokenizer("english")
stemmer = Stemmer("english")
parser = PlaintextParser(document, tokenizer)


stop_words = [x for x in get_stop_words("english") if len(x) > 1]
summarizer = LsaSummarizer(stemmer)
summarizer.stop_words = stop_words


for sent in summarizer(parser.document, len(document.splitlines())/2):
    print(sent)
    #sleep(5)
    print()
