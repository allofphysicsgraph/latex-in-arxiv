import glob
from collections import defaultdict
import pandas as pd

# https://github.com/alvinwan/tex2py
from tex2py import tex2py
from TexSoup import TexSoup

# https://stackoverflow.com/questions/13208286/how-to-write-latex-in-ipython-notebook
# from IPython.display import display, Math, Latex
# display(Math(r'F(k) = \int_{-\infty}^{\infty} f(x) e^{2\pi i k} dx'))

list_of_files = glob.glob("2003/*")
from collections import defaultdict

results = []
from tqdm import tqdm
from collections import defaultdict

d = defaultdict(list)
from TexSoup import TexSoup

for this_file in tqdm(list_of_files):
    f = open(this_file)
    data = f.read()
    f.close()
    soup = TexSoup(data)
    equations = soup.find_all("equation")
    tex_copy = data
    while True:
        try:
            resp = next(equations)
            tex_copy = tex_copy.replace(str(resp), "")
            d["equations"].append(resp)
        except StopIteration:
            break

    for ix in list(soup.find_all("$")):
        tex_copy = tex_copy.replace(str(ix), "")
        d["expressions"].append(ix)

    for line in list(soup.find_all("thebibliography")):
        tex_copy = tex_copy.replace(str(line), "")
        d["thebibliography"].append(line)

        # except Exception as e:
    #        pass
