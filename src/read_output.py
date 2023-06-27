import re
from collections import defaultdict
from sys import argv
with open('/dev/shm/output','r') as f:
    data = [x.strip() for x in f.readlines()]
    
with open(argv[1],'r') as f:
    file_data = f.read()

dct = defaultdict(list)
for line in data:
    key,start,stop = line.rsplit(':',maxsplit=2)
    start,stop = int(start),int(stop)
    dct[key].append(file_data[start:stop])

from time import sleep
for k,v in dct.items():
    print(k,v)
    #sleep(2)

