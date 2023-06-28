import re
from collections import defaultdict
from sys import argv
from time import sleep


with open(argv[1], "r") as f:
    file_data = f.read()

# testing proper alignment for begin.*?end pairs
# pairs is obtained from running keyword_search.out texfile > /dev/shm/pairs
with open("/dev/shm/pairs", "r") as f:
    pairs = [x.strip() for x in f.readlines()]

pairs = pairs[1:-1]
if len(pairs) % 2 == 0:
    new_pairs = list(zip(pairs[0::2], pairs[1::2]))
    # print(new_pairs)
    for start, stop in new_pairs:
        # print(start,stop)
        start_pattern, stop_pattern = False, False
        if "\\begin" in start:
            if "\\end" in stop:
                start_pattern = re.findall(r"\\begin{(.*?)}", start)
                # print(start, stop)
                if start_pattern:
                    if len(start_pattern) == 1:
                        start_pattern = start_pattern[0]

                stop_pattern = re.findall(r"\\end{(.*?)}", stop)
                # print(stop,stop)
                if stop_pattern:
                    if len(stop_pattern) == 1:
                        stop_pattern = stop_pattern[0]

                if start_pattern and stop_pattern:
                    # print(start_pattern,stop_pattern)
                    print(start, stop)
                    # key,start,stop = line.rsplit(':',maxsplit=2)

exit(0)
dct = defaultdict(list)
for line in data:
    key, start, stop = line.rsplit(":", maxsplit=2)
    start, stop = int(start), int(stop)
    dct[re.escape(key)].append(file_data[start:stop])
print(dct)
from time import sleep

for k, v in dct.items():
    if re.findall(r"\\begin|\\end", k):
        resp = re.findall(r"\\begin{(.*?)}|\\end{(.*?)}", k)
        print(resp)
        exit(0)
        match = [x for x in resp[0] if x]
        if match:
            match = match[0]
            # print(match)
            # print(dct.keys())
            q = r"\\begin{{{}}}".format(match)
            print(q)
            if q not in dct.keys():
                print(k)
