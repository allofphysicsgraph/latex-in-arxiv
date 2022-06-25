from sys import argv
from nltk.tokenize import mwe
from time import sleep
import re
import nltk


def add_new_token(string):
    tokenizer.add_mwe(r"{}".format(string))


def read_file(path, f_name):
    with open("{}/{}".format(path, f_name), "r", encoding="ISO-8859-1") as f:
        data = f.read()
    return data


def balanced(start, s, left_symbol=r"{", right_symbol=r"}"):
    import re

    matched = []
    # bad code, but essentially works
    # the pattern should include one instance of the left symbol so that balanced=-1
    # if left == right then +- counting fails
    # begin syntax handled automatically, so there is no need to include left_right symbols
    s = re.sub(r"\\newcommand.*", "", file_data)
    if "\\begin" in start:
        match = re.findall(r"\\begin{(.*?)}", start)
        if match:
            match = match[0]
            # print(match)
            left_symbol = f"""\\begin{{{match}}}"""
            right_symbol = f"""\\end{{{match}}}"""
    # print(left_symbol)
    if left_symbol != right_symbol:
        current_offset = 0
        balanced = 0
        match = re.finditer(r"{}".format(start), s)
        # print(match)
        for m in match:
            if m:
                # print(m)
                start_offset = m.start()
                current_offset = m.end() + 1
                balanced = -1
                while balanced != 0:
                    if (
                        s[current_offset : current_offset + len(right_symbol)]
                        == right_symbol
                    ):
                        balanced += 1
                    if (
                        s[current_offset : current_offset + len(left_symbol)]
                        == left_symbol
                    ):
                        print("-1")
                        balanced -= 1
                    current_offset += 1
                matched.append(s[start_offset:current_offset])
                start_offset = current_offset
    return matched


def math_ctrl_seq(data):
    # multiline is not matched,    #\[.*?\] is also not matched
    # likely to be other issues.
    import re
    from time import sleep

    lst_errors = [x for x in re.findall(r"\$.*?\$", data) if x.count("$") % 2 != 0]
    print("error count:{}\n".format(len(lst_errors)))
    lst = [x for x in re.findall(r"\$(.*?)\$", data) if x.count("$") % 2 == 0]
    return lst


def word_lst(data):
    import nltk

    words = nltk.word_tokenize(data)
    eng_vocab = [x.strip() for x in read_file(".", "english_vocab").splitlines()]
    matched_words = set(words).intersection(set(eng_vocab))
    unmatched_words = set(words).difference(set(eng_vocab))
    unmatched_words = [x for x in unmatched_words if x not in dct["math_ctrl_seq"]]
    # print(unmatched_words)
    return matched_words, unmatched_words


def comments(data):
    import re

    lst = re.findall("%.*", data)
    return lst


def symbol_definitions(sentence):
    lst = []
    match = re.findall(r"where \$[a-zA-Z]\$ is.*?(?:\$|$)", sentence, re.DOTALL)
    if match:
        lst.extend(match[0])
    match = re.findall(r"and \$[a-zA-Z]\$ is.*?(?:\$|$)", sentence, re.DOTALL)
    if match:
        # if matched here, the sentence should be split and checked for a previous definition of another symbol.
        lst.extend(match)

    match = re.findall(r"\$[a-zA-Z]\$-function", sentence)
    if match:
        # if matched here, the sentence should be split and checked for a previous definition of another symbol.
        lst.extend(match)
    return lst


if __name__ == "__main__":
    from collections import defaultdict
    from pudb import set_trace

    tokenizer = mwe.MWETokenizer(separator="")
    latex_tokens = [x.strip() for x in read_file(".", "latex_vocab").splitlines()]
    for token in latex_tokens:
        add_new_token(token)
    dct = defaultdict(list)
    file_data = read_file(".", argv[1])
    dct["cite"].extend(balanced(r"\\cite", file_data))
    dct["date"].extend(balanced(r"\\date", file_data))
    dct["packages"].extend(balanced(r"\\usepackage", file_data))
    dct["title"].extend(balanced(r"\\title", file_data))
    dct["authors"].extend(balanced(r"\\author", file_data))
    dct["affiliations"].extend(balanced(r"\\affiliation", file_data))
    dct["abstract"].extend(balanced(r"\\begin{abstract}", file_data))
    dct["subequations"].extend(balanced(r"\\begin{subequations}", file_data))
    dct["equations"].extend(balanced(r"\\begin{equation}", file_data))
    dct["equationarray"].extend(balanced(r"\\begin{eqnarray}", file_data))
    dct["ref"].extend(balanced(r"\\ref", file_data))
    dct["pacs"].extend(balanced(r"\\pacs", file_data))
    dct["keywords"].extend(balanced(r"\\keywords", file_data))
    dct["label"].extend(balanced(r"\\label", file_data))
    dct["section"].extend(balanced(r"\\section", file_data))
    dct["math_ctrl_seq"].extend(math_ctrl_seq(file_data))
    dct["comments"].extend(comments(file_data))
    # print(word_lst(file_data))
    # print(dct['ref'])
    # set_trace()
    for token in dct["math_ctrl_seq"]:
        if len(token) == 1:
            if re.findall("[a-zA-z]", token):
                if token.strip() not in dct["user_defined_symbols"]:
                    dct["user_defined_symbols"].append(token.strip())
                    # print(token)
        # print(token,tokenizer.tokenize(r'{}'.format(token)))
        # sleep(1)

    dct["sentences"] = nltk.sent_tokenize(file_data)
    for ix, sent in enumerate(dct["sentences"]):
        print("sent:", ix, sent)
        # set_trace()
        dct["user_defined_symbols_definition"].extend(symbol_definitions(sent))
        # sleep(2)
        print("\n")
    # set_trace()
