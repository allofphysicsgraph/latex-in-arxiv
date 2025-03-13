from TexSoup import TexSoup
from time import time

start = time()
with open("/home/user/latex-in-arxiv/sound1.tex", "r") as f:
    data = f.read()
stop = time() - start
print(stop)
soup = TexSoup(data)
print(len(soup.find_all("$")))
