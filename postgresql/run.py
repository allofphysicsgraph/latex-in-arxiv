import re

with open("offsets", "r") as f:
    data = f.readlines()

for line in [x for x in data if re.findall("\t", x)]:
    resp = [x for x in re.split("\t|\n", line) if x.strip()]
    if len(resp) == 2:
        filename = resp[0]
        idx, length, offset, data_type = re.split("\s+", resp[1])
output = []
output.append((filename, idx, length, offset, data_type))
