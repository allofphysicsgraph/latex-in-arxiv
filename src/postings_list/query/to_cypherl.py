# coding: utf-8
#will be used to generate cypherl file
import pandas as pd

df = pd.read_csv("offsets", sep="\s+", header=None)
zf = pd.read_csv(
    "tf_idf", sep="id:|: count:| docs:| tok:", engine="python", header=None
)
zf = zf.loc[:, [1, 2, 4]]
zf.set_index(1, inplace=True)
import re

zf.columns = ["count", "token"]
zf = zf[
    zf.token.apply(lambda x: True if re.findall("\$|\\|derivation", str(x)) else False)
]
print(zf)
"""
zf.columns = [0,1]
pd.concat(df,zf)
pd.concat([df,zf])
nf = len(df)
df = pd.merge(df,zf,left_on=0,right_on=0)
df.columns = [1,2]
df.loc[:,[0,1,2]]
df.loc[:,[0,1,2]].to_csv('graph_test.csv',index=False,sep='\t')
df.columns=['Source','Label','Target']
df.columns=['Target','Label','Source']
df.to_csv('/home/user/Desktop/graph_test2.csv',index=False,sep='\t')
"""
