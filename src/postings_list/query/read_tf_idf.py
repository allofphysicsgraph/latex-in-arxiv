from sqlalchemy import create_engine
from sys import argv
import pandas as pd
import re

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

table_name = [x for x in re.split("_tf_idf", argv[1]) if x.strip()]
if table_name:
    table_name = table_name[0].replace('./','')
    print(table_name)

engine = create_engine("postgresql://arxiv:795e3522169@localhost:5433/latex_in_arxiv")
df.to_sql(table_name, engine, if_exists="append", index=False)
