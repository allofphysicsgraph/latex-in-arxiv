# coding: utf-8
# will be used to generate cypherl file
from collections import defaultdict
from time import sleep
import pandas as pd
import re

with open("offsets", "r") as f:
    offsets = re.split("(\.\/.*?tex)\n", f.read())

offsets = [x for x in offsets if x.strip()]
filenames = offsets[::2]
rows = offsets[1::2]


files_to_offsets = defaultdict(pd.DataFrame)
for ix, fileData in enumerate(rows):
    tuples = []
    for row in rows[ix].splitlines():
        tuples.append(re.split("\s+", row))
    tmp_df = pd.DataFrame(tuples)
    tmp_df.columns = ["id", "offset", "length"]
    files_to_offsets[filenames[ix]] = tmp_df

with open("tf_idf", "r") as f:
    data = f.read()
    data = data.replace("\\n", "\\\\n")
lines = re.split("\\nid:|^id:", data)
tf_idf_out = []
for ix in range(len(lines)):  # len(lines)):
    resp = re.split(": count:| docs:| tf_idf:| tok:", lines[ix])
    if len(resp) == 5:
        tf_idf_out.append(resp)

tf_idf_df = pd.DataFrame(tf_idf_out)
df = pd.DataFrame()
sm = 0
for k, v in files_to_offsets.items():
    temp_df = v
    v["filename"] = k
    if len(df) == 0:
        df = v
        sm += len(v)
    else:
        df = pd.concat([df, v])
        sm += len(v)


tf_idf_df.columns = ["id", "count", "doc_count", "tf_idf", "token"]
zf = pd.merge(df, tf_idf_df, left_on="id", right_on="id")
zf['length'] = zf['length'].apply(lambda x: int(x))
zf = zf[zf['length']>1] 
zf = zf[zf.token.apply(lambda x: True if re.findall('\$.*?\$',x) else False)] 
zf = zf[zf.token.apply(lambda x: False if re.findall('abstract',x) else True)] 
print(len(zf))
print(zf.head())
