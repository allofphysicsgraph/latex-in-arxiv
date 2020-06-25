import nltk
from time import sleep
from collections import defaultdict
import re
from sys import argv

if len(argv)<2:
    print('provide name of file to read as argument')

with open(argv[1],'r') as f:
    data = f.read()

#creates a dictionary with a default value of list
latex = defaultdict(list)

def find_latex(pattern,data=data,multiline=True,autocommit=False):
    temp = defaultdict(list)
    iterator = re.finditer(r'{}'.format(pattern),data,re.DOTALL)
    while True:
        try:
            resp = next(iterator)
            print(resp)
            temp[resp.span()].append(resp.group()) 
        except StopIteration:
            break
    
    if not autocommit:
        save = input('save?')
        if save == str(1):
            latex.update(temp)
    else:
        latex.update(temp)
        
def remove_latex(data):
    for k in latex.keys():
        data = data[:k[0]] +' '*(k[1]-k[0])+data[k[1]:]
    return data

find_latex(r'\\subsection{.*?}',autocommit=True)
find_latex(r'\\begin{quote}',autocommit=True)
find_latex(r'\\eqn.*?}\n',autocommit=True)
find_latex('\$.*?\$',autocommit=True)
find_latex(r'\\def.*?}\n',autocommit=True)
find_latex(r'\\nref.*?}\n',autocommit=True)
find_latex(r'%*\\vskip\s*(\d+pt|\d+mm)',autocommit=True)
find_latex(r'\\vfill\\eject',autocommit=True)
find_latex(r'\\bigskip',autocommit=True)
find_latex(r'\\centerline.*?}\n',autocommit=True)
find_latex(r'\\Date.*?}\n',autocommit=True)
find_latex(r'{\\it\s+.*?}\s+',autocommit=True)
find_latex(r'\\newsec.*?}\n',autocommit=True)
find_latex(r'{.*?}',autocommit=True)
find_latex(r'\\.*?\s',autocommit=True)
lst = [r'\\vfill',r'\\eject',r'\\bye',r'\\end',r'\\noindent',r'\\smallskip']
for ix in lst:
    find_latex(ix,autocommit=True)

#show the text after LaTeX has been removed
data = remove_latex(data)
sents = nltk.sent_tokenize(data)
for sent in sents:
    print('\n')
    print(sent)
    print('\n')
    print('*'*50)
    sleep(1)

for ix in sorted(latex.items(),key=lambda x:sum(x[0])):
    resp = ix[1][0]
    if resp:
        print(resp)
