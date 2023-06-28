import re
from collections import defaultdict
from sys import argv
from time import sleep
import pandas as pd
from pudb import set_trace

# TODO handle pairs that do not get resolved
# copy document (document,start,stop,byte_count,type,word) from '/dev/shm/pairs' CSV;
# time psql -d latexinarxiv -c "copy document (document,start,stop,byte_count,type,word) from '/dev/shm/pairs' CSV;"

"""
 time psql -d latexinarxiv -c "copy document (document,start,stop,byte_count,type,word) from '/dev/shm/pairs' CSV;"
COPY 34

real    0m0.035s
user    0m0.017s
sys     0m0.004s


time python read_output.py
real    0m0.413s
user    0m0.681s
sys     0m1.146s


"""


# with open(argv[1], "r") as f:
#    file_data = f.read()

# testing proper alignment for begin.*?end pairs
# pairs is obtained from running keyword_search.out texfile > /dev/shm/pairs
df = pd.read_csv("/dev/shm/pairs")
# print(df.head())
exit(0)
"""
df.sort_values(1, inplace=True)
df["resolved"] = False
df["type"] = df[0].apply(lambda x: "begin" if re.findall(r"\\begin{", x) else "end")
df["word"] = df[0].apply(lambda x: re.findall(r"\\[a-z]+{(.*?)}", x)[0])
test_dict = df.groupby("type").count()[0].to_dict()
# print(test_dict["begin"], test_dict["end"])
if test_dict["begin"] == test_dict["end"]:
    print("counts ok")

while len(df.index.tolist()) > 0:
    df_idx_lst = df.index.tolist()
    t1_idx, t2_idx = df_idx_lst[:2]
    t1 = df.loc[t1_idx]
    t2 = df.loc[t2_idx]

    if t1.type == "begin" and t2.type == "end":
        if t1.word == t2.word:
            if t2[1] > t1[2]:  # ensure that end starts before begin
                result = file_data[t1[1] : t2[2]]
                # drop rows for the existing matches
                keep_rows = [
                    x for x in df_idx_lst if x != t1_idx and x != t2_idx
                ]
                df = df.loc[keep_rows]
                df.reset_index(drop=True, inplace=True)
    else:
        print('ERROR')
        exit(1)"""
