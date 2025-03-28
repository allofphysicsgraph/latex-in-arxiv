import re
from common import read_file
from sys import argv
from time import sleep
import pandas as pd
from sqlalchemy import create_engine
from os import listdir

data = read_file(argv[1])
file_info = re.findall("<file>(.*?)</file>", data, re.DOTALL)
output = []
for rows in file_info:
    row = [x.strip() for x in re.split("<(.*?)>(.*?)</.*?>", rows) if x.strip()]
    dct = {k: v for k, v in zip(row[::2], row[1::2])}
    print(dct)
    output.append(dct)

df = pd.DataFrame(output)
print(df.head())
# engine = create_engine("postgresql://arxiv:795e3522169@localhost:5433/latex_in_arxiv")
# df.to_sql('arxiv_src_manifest',engine,index=False)

"""
  <file>
    <content_md5sum>cacbfede21d5dfef26f367ec99384546</content_md5sum>
    <filename>src/arXiv_src_0001_001.tar</filename>
    <first_item>astro-ph0001001</first_item>
    <last_item>quant-ph0001119</last_item>
    <md5sum>949ae880fbaf4649a485a8d9e07f370b</md5sum>
    <num_items>2364</num_items>
    <seq_num>1</seq_num>
    <size>225605507</size>
    <timestamp>2010-12-23 00:13:59</timestamp>
    <yymm>0001</yymm>
  </file>
"""
