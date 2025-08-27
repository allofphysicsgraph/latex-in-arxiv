import subprocess
import vowpalwabbit
import re
from random import shuffle
from os import listdir
import xxhash
from sys import argv
from tqdm import tqdm

MODEL_NAME = "compiled_equation.model"
header = """\\documentclass[]{article}
\\usepackage{amsmath}
\\begin{document}
"""
# vw = vowpalwabbit.Workspace(f"-i {MODEL_NAME} --ngram 2 --skips 4 -b 24 -l 0.25",quiet=True)

vw = vowpalwabbit.Workspace(f"--ngram 2 --skips 4 -b 24 -l 0.25", quiet=True)

with open(argv[1], "r") as f:
    data = f.read().split("*" * 50)
    shuffle(data)


def compile_test(data):
    h3_64 = xxhash.xxh3_64(data).digest().hex()
    # hash of the expression
    with open(f"{h3_64}.tex", "w") as f:
        f.write(header)
        f.write(data)
        f.write("\n")
        f.write("\\end{document}")

    filename = f"{h3_64}.tex"
    print(f"FILENAME {filename}")
    try:
        resp = subprocess.check_output(["pdflatex", "--halt-on-error", filename])
    except:
        resp = False
    if resp:
        subprocess.call(
            [
                "rsync",
                "-axr",
                filename,
                "compiled/",
                "--progress",
                "--remove-source-files",
            ]
        )
        print("sync compile")
        return True
    else:
        subprocess.call(
            [
                "rsync",
                "-axr",
                filename,
                "failed/",
                "--progress",
                "--remove-source-files",
            ]
        )
        print("sync fail")
        return False


def update_model(compiled, data):
    if compiled:
        q = "1 | " + data
        try:
            score = vw.predict("| " + data)
        except Exception as e:
            print(str(e))
        print("PREDICTION", score)
        ex = vw.example(q)
        vw.learn(ex)
    else:
        # weigth the failures to account for fewer examples
        q = "-1 2| " + data
        try:
            score = vw.predict("| " + data)
        except Exception as e:
            print(str(e))
        print("PREDICTION", score)
        ex = vw.example(q)
        vw.learn(ex)


for ix, equation in enumerate(tqdm(data)):
    resp = compile_test(equation)
    eq = " ".join(equation.splitlines())
    update_model(resp, eq)
    if ix % 100:
        vw.save(MODEL_NAME)
