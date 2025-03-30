from sqlalchemy import create_engine
from sys import argv
import pandas as pd
import re

output = []
with open(argv[1], "r") as f:
    data = f.read()
    for match in re.findall("(.*?)\t([a-f0-9]+) (\\d+)  (\\d+) (\\d+)", data):
        if len(match) == 5:
            file_path, xxh, offset, length, data_type_id = match
            output.append((file_path, xxh, offset, length, data_type_id))
columns = ["file_path", "xxh", "offset", "length", "data_type_id"]
df = pd.DataFrame(output)
df.columns = columns

print(df.head())
engine = create_engine("postgresql://arxiv:795e3522169@localhost:5433/latex_in_arxiv")
# df.to_sql(table_name, engine, if_exists="append", index=False)
