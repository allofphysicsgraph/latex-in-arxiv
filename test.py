import re
from collections import defaultdict
from nltk.tokenize import mwe
from sys import argv 

if len(argv) != 3:
    print('expected file path as argv[1], filename as argv[2]')
    exit(1)

class Trie(dict):
    from collections import defaultdict

    """A Trie implementation for strings"""
    LEAF = True

    def __init__(self, strings=None):
        super(Trie, self).__init__()
        if strings:
            for string in strings:
                self.insert(string)

    def insert(self, string):
        if len(string):
            self[string[0]].insert(string[1:])
        else:
            # mark the string is complete
            self[Trie.LEAF] = None

    def __missing__(self, key):
        self[key] = Trie()
        return self[key]


def add_new_token(string):
    tokenizer.add_mwe(r"{}".format(string))


def manual_entries(pattern, data):
    resp = re.findall(pattern, data)
    if resp:
        for match in resp:
            add_new_token(match)


def print_symbols_not_used():
    for k, v in symbols_use_count.items():
        if v == 0:
            print(k)

def read_file(path,f_name):
    with open('{}/{}'.format(path,f_name),'r',encoding='ISO-8859-1') as f:
        data = f.read()
    return data

def symbols_not_accounted_for(seen_count):
    for item in sorted(dct.items(), key=lambda x: -x[1]):
        if item[1] > seen_count:
            print(item[0])


dct = defaultdict(int)
tokenizer = mwe.MWETokenizer(separator="")
symbols_use_count = defaultdict(int)

path_to_symbol_list = "latex_math.txt"
with open(path_to_symbol_list) as f:
    symbols = [x.replace("\n", "") for x in f.readlines()]

data = [x.replace('\n','') for x in read_file('.',"latex_misc.txt").splitlines()]
symbols.extend(data)

data = [x.replace('\n','') for x in read_file('.',"english_vocab.txt").splitlines()]
symbols.extend(data)
symbols = sorted(symbols, key=lambda x: -len(x))
for symbol in symbols:
    add_new_token(symbol)

regex_subs = {}
add_new_token(r"\\ ")
from time import sleep
data = read_file(argv[1],argv[2])
#to be used for expanding definitions
'''
for line in data.splitlines():
    if re.findall(r'\\def',line):
        resp = [x for x in line.split('\\def',1) if x]
        if resp:
            resp = resp[0]
            match = re.findall('(.*?)({.*)',resp)
            if match:
                pass
                key ='asdf'
                def_key = match[0][0]
                def_value = match[0][1].strip()[1:-1]
                #freplace('{def_key}','{def_value}'))
'''
f =open('unk','w')
from nltk import word_tokenize
for line in data.splitlines():
    test = re.findall('\$.*?\$',line)
    for math in test:
        tokens = [x for x in tokenizer.tokenize(math) if x.strip() and x not in symbols]
        words =[x for x in word_tokenize(math) if x and x not in symbols]
        if(words != tokens):
            if '\\' in tokens or '$' in tokens:
                #print(line)
                print(math[1:-1])
                print(tokens[1:-1])
                #print(words)
                print('\n\n')
                #inp = input("save")
                #if inp == '1':
                if 1 == 1:
                    f.write(line)
                    f.write('\n')
                #sleep(1)


#print_symbols_not_used()
#symbols_not_accounted_for(50)

