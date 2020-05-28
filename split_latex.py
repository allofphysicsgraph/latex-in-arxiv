import re
from time import sleep

f = open(list_of_files[0])
data = f.read()
f.close()
def def_multiline_match(data):
    return re.findall(r'\\lref.*?{.*?}',data,re.DOTALL)

dct = {}
dct['defs'] = []
dct['line_count'] = len(data.splitlines())
dct['blank_lines'] = 0
dct['input_lines'] = []
dct['maybe_art_work'] = []
dct['line_no_accounted_for'] = []
dct['citation']=[]
dct['special_delimiters'] = []
dct['refs'] = []
dct['latex'] = []
count  = 0
for ix,line in enumerate(data.splitlines()[900:]):
    if re.findall(r'\\def\\.*?{.*?}',line):
        dct['defs'].append(line)
        dct['line_no_accounted_for'].append(ix)
    elif not line.strip():
            dct['blank_lines'] += 1
            dct['line_no_accounted_for'].append(ix)
    elif not re.findall(r'[a-zA-Z0-9]',line):
        dct['maybe_art_work'].append(line)
        dct['line_no_accounted_for'].append(ix)
    elif re.findall('%%CITATION.*?=.*?%%',line):
        dct['citation'].append(line)
    elif re.findall("``.*?''",line):
        dct['special_delimiters'].append(line)
    elif re.findall("\\refs.?{.*?}",line):
        dct['refs'].append(line)
    latex = re.findall(r'\$(.*?)\$',line)
    if latex:
        dct['latex'].append(latex)
    else:
        print(line)

