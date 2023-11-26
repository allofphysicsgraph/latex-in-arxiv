from os import listdir
files = listdir('.')
import lzma
import hashlib

model_files = [x for x in files if x.endswith(".xz")]
decompressed_model_files = ["Punkt_LaTeX_SENT_Tokenizer.pickle"]
verify_hash = {
    "Punkt_LaTeX_SENT_Tokenizer.pickle": "a436f489188951661aa0d958ff44946389c0b545ec69fa06377123ad3aa5ceaa",
}
for model in decompressed_model_files:
    if model not in files:
        print("###Extracting Models")
        with lzma.open(f"{model}.xz") as f:
            file_content = f.read()
            h = hashlib.new("sha256")
            h.update(file_content)
            assert h.hexdigest() == verify_hash[model]

        with open(f"{model}", "wb") as f:
            f.write(file_content)

