import re

def read_file(path, f_name):
    with open(f"{path}/{f_name}", "r", encoding="ISO-8859-1") as f:
        data = f.read()
    clean = [x for x in data.splitlines() if not re.findall(r"^\\def|^\\newcommand", x)]
    data = "\n".join(clean)
    return data

