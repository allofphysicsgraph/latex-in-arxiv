def offsets_dataframe():
    from common import read_file
    import pandas as pd
    import re

    data = read_file("offsets")
    data = data.splitlines()
    data = [re.split("\t|\s+", x) for x in data]
    df = pd.DataFrame(data)
    df.columns = ["filename", "xxh", "offset", "length", "token_type"]
    df.dropna(subset="xxh", inplace=True)
    return df
