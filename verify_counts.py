#!/usr/bin/python3

from sys import argv
import re

def read_file(f_name):
    """
        >>> python verify_counts.py author sound1.tex
        arg 1, tex cntrl sequence name such as abstract,
        arg 2, tex filename
    """
    with open(f"{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines() if not re.findall(r"^\\def|^\\newcommand", x)]
    data = "\n".join(clean)
    return data


data = read_file(argv[2])
print(len(re.findall(r'{}(\s{{0,5}}|\n){{'.format(re.escape(argv[1])),data,re.DOTALL)))
