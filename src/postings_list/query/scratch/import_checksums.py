import re
from sqlalchemy import create_engine
from sys import argv
from common import read_file
import pandas as pd

data = read_file(argv[1])
data = [tuple(re.split("\\s+", x)) for x in data.splitlines()]
engine = create_engine("postgresql://arxiv:795e3522169@localhost:5432/latex_in_arxiv")
df = pd.DataFrame(data)
df.columns = ["sha256", "filename"]
df.to_sql("file_checksums", engine, if_exists="append", index=False)
