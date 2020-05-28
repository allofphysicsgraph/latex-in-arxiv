import glob
from collections import defaultdict
import pandas as pd
# https://github.com/alvinwan/tex2py
from tex2py import tex2py
from TexSoup import TexSoup

#https://stackoverflow.com/questions/13208286/how-to-write-latex-in-ipython-notebook
#from IPython.display import display, Math, Latex
#display(Math(r'F(k) = \int_{-\infty}^{\infty} f(x) e^{2\pi i k} dx'))

list_of_files = glob.glob('2003/*')
from collections import defaultdict
results=[]
from tqdm import tqdm 
for this_file in tqdm(list_of_files):
    try:
        f = open(this_file)
        data = f.read()
        f.close()
        soup = TexSoup(data)
        d = defaultdict(list)
        toc = tex2py(data)
        for tag in toc.valid_tags:
            resp = soup.find_all(tag)
            while True:
                try:
                    d[tag].append(next(resp))
                except StopIteration:
                    break
        results.append(d)
        print(len(results))
    except Exception as e:
        pass
import pandas as pd 
df = pd.DataFrame(results)
df.to_csv('latex.csv')
