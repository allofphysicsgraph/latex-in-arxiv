from sys import argv
import pandas as pd
import re


def read_file(f_name):
    with open("{}".format(f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


data = read_file(argv[1])
resp = re.findall(
    "(^|\n){<filepath:(.*?)>,filepath_id:(\d+),token_id:(\d+),parent_id:(\d+),offset:(\d+),length:(\d+),type:([a-z_]+),<tok:(.*?)>}",
    data,
    re.DOTALL,
)
output = []
for ix in range(len(resp)):
    output.append([x for x in resp[ix] if x.strip()])
df = pd.DataFrame(output)
df.columns = [
    "filepath",
    "filepath_id",
    "token_id",
    "parent_id",
    "offset",
    "length",
    "type",
    "token",
]
df["offset"] = df.apply(
    lambda x: (
        int(x["offset"]) + 1 if (x["filepath_id"] != x["parent_id"]) else x["offset"]
    ),
    axis=1,
)
df.to_csv("output.csv", index=False)
