from collections import defaultdict
from time import sleep
import pandas as pd
import re
from sys import argv

with open(argv[1], "r") as f:
    data = f.read()
    tokens = re.split("(id:[a-f0-9]+: count:\d+ docs:\d+ tf_idf:\d+.\d+ tok:)", data)
output = []
for k, v in zip(tokens[1::2], tokens[2::2]):
    # print(k,v)
    k = re.findall("id:([a-f0-9]+): count:(\d+) docs:(\d+) tf_idf:(\d+.\d+) tok:", k)
    idx, count, docs, tf_idf = k[0]
    output.append([idx, count, docs, tf_idf, v.strip()])

df = pd.DataFrame(output)
df.columns = ["xxh", "count", "docs", "tf_idf", "token"]
print(df.head())
