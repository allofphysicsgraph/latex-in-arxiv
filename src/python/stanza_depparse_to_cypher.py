# coding: utf-8
import stanza
import pandas as pd

nlp = stanza.Pipeline("en", processors="tokenize,mwt,pos,lemma,depparse")
doc = nlp(
    "Two dimensionless fundamental physical constants, the fine structure constant X."
)

for s in doc.sentences:
    l = []
    for x in s.dependencies:
        l.append(x)

    df = pd.DataFrame(l)
    # print(df)
    X = df.itertuples()
    while True:
        try:
            resp = next(X)[1:]
            src = resp[0].to_dict()
            dst = resp[2].to_dict()
            edge = resp[1]
            # print(edge)
            # print('edge {}'.format(resp[1])
            src_ID = src["id"]
            src_TXT = src["text"]
            dst_ID = dst["id"]
            dst_TXT = dst["text"]

            print(f"MERGE (t0:{src_TXT} {{id:{src_ID},txt:'{src_TXT}'}})")
            print(f"MERGE (t1:{dst_TXT} {{id:{dst_ID},txt:'{dst_TXT}'}})")
            print(f"CREATE (t0)-[r:{edge}]->(t1);")
        except:
            break
    # print(df.tail())
