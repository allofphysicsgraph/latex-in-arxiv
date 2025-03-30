import re
from sqlalchemy import create_engine
from sys import argv
from common import read_file
import pandas as pd

data = read_file(argv[1])
data = [tuple(re.split(":\\s+", x, maxsplit=1)) for x in data.splitlines()]
engine = create_engine("postgresql://arxiv:795e3522169@localhost:5432/latex_in_arxiv")
df = pd.DataFrame(data)
df.columns = ["filename", "description"]
df.to_sql("files_by_type", engine, if_exists="append", index=False)
