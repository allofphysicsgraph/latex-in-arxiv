#!wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
#!tar xzvf hep-th-2003.tar.gz
#!ls -hal 2003/ | wc -l
import glob
import re
list_of_files = glob.glob('2003/*')
# how many files are in the corpus?
len(list_of_files)

# load data from the first file
with open(list_of_files[1], 'r') as f:
    data = f.read()

from collections import defaultdict
#dealing with the latex that fills one line or less
tokens = ['\def','\input','\\tolerance']


def count_strings(match_string,string):
    if string.count(match_string):
        return True
    else:
        return False

def begin_pattern(string):
    resp = re.findall(r'\\begin{(.*?)}',string)
    if resp:
        resp = resp[0]
        return resp
    

regex_patterns = {}

begin_pattern('\\begin{figure}')


dct = defaultdict(list)
for line in data.splitlines():
    ignore_line = False
    for tok in tokens:
        if tok in line:
            ignore_line = True

    if not ignore_line:
        if line:
            if line.count('%') < 10:
                if len(line) > 3:
                    if count_strings('$',line):
                        dct['latex_single_dollar'].append(re.findall(r'\$(.*?)\$',line))

                    if count_strings('\\begin',line):
                        begin_word = begin_pattern(line)
                        resp = re.findall(r'\\begin{'+begin_word+r'}.*?\\end{'+begin_word+'}',data,re.DOTALL)
                        print(resp)
                    if count_strings('\\begin',line):
                        print(line)




