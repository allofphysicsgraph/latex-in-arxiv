import re
from sys import argv

with open(argv[1], "r") as f:
    data = f.readlines()

with open("offsets_cleaned", "w") as f:
    for ix in range(len(data) - 1):
        if re.findall("tex", data[ix]):
            if re.findall("tex", data[ix + 1]):
                continue
            else:
                f.write(data[ix])
        else:
            f.write(data[ix])
    f.write(data[ix + 1])
