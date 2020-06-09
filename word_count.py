import nltk
import re
from collections import defaultdict
import glob
from tqdm import tqdm
files = glob.glob('2003/*')
nltk.download('punkt')
d = defaultdict(int)
word_count = 0
for f_name in tqdm(files):
    try:
        f = open(f_name,encoding='ISO-8859-1')
        data =f.read()
        f.close()
        sents = nltk.sent_tokenize(data)
        words = set()
        maybe_latex = []
        for sent in sents:
            maybe_words = nltk.word_tokenize(sent)
            for word in maybe_words:
                if len(word) > 3:
                    if re.findall('[a-zA-Z]+',word):
                            if '\\' in word:
                                maybe_latex.append(word.strip())
                            else:
                                if not re.findall('\d+|_|\-|=|~',word):
                                    d[word] += 1
                                    word_count += 1
    except Exception as e:
        print(e)

common_words = sorted(d.items(),key=lambda x: -x[1])[:500]
print(common_words)
print(word_count)
