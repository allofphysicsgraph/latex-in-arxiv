import re
from sqlalchemy import create_engine
from sys import argv
from common import read_file
import pandas as pd

data = read_file(argv[1])
engine = create_engine("postgresql://arxiv:795e3522169@localhost:5432/latex_in_arxiv")

file_name = re.findall("ID=(.*?)\\s", data.splitlines()[0])[0]
data = re.split("Sentence #(\\d+ \\(\\d+) tokens\\):", data)
output = []
for tpl in list(zip(data[1::2], data[2::2])):
    sent_index, token_count = tpl[0].replace("(", "").split(" ")
    sentence = tpl[1].strip()
    output.append((sent_index, token_count, sentence))
print(file_name)
df = pd.DataFrame(output)
df["file_name"] = file_name
df.columns = ["sentence_index", "token_count", "sentence", "file_name"]
print(df.head())
df.to_sql("sentences_corenlp_2", engine, if_exists="append", index=False)
