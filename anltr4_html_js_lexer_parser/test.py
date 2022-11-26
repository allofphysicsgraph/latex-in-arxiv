from antlr4 import *
from  HTMLLexer import  HTMLLexer
import pandas as pd 

data = []
input_stream = FileStream('test.html')
lexer = HTMLLexer(input_stream)
token_stream = CommonTokenStream(lexer)
token_stream.fill()
print('tokens:')
from time import sleep
for ix,tk in enumerate(token_stream.tokens):
    data.append([tk.start,tk.stop,tk.text,lexer.symbolicNames[tk.type]])
    
df = pd.DataFrame(data)
print(df.head())
df.to_csv('parsed_html.csv')
