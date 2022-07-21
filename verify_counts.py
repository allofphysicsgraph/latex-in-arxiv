#!/usr/bin/python3

from sys import argv
import re

def read_file(f_name):
    with open(f"{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines() if not re.findall(r"^\\def|^\\newcommand", x)]
    data = "\n".join(clean)
    return data


data = read_file(argv[2])
print(len(re.findall(r'{}(\s{{0,5}}|\n){{'.format(re.escape(argv[1])),data,re.DOTALL)))
