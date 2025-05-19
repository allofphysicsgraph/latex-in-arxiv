from sys import argv
import re


def read_file(f_name):
    with open("{}".format(f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


data = read_file(argv[1])
resp = re.findall(
    "(^|\n){<filepath:(.*?)>,id:(\d+),offset:(\d+),length:(\d+),type:([a-z_]+),<tok:(.*?)>}",
    data,
    re.DOTALL,
)
# print(data[:1000])
from time import sleep

output = []
for ix in range(len(resp)):
    output.append([x for x in resp[ix] if x.strip()])

import pandas as pd

df = pd.DataFrame(output)
df.columns = ["filepath", "id", "offset", "length", "type", "token"]
print(df.head())
