from sys import argv


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
    print(left_symbol)
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


if __name__ == "__main__":
    from collections import defaultdict
    from pudb import set_trace

    dct = defaultdict(list)
    file_data = read_file(".", argv[1])
    #TODO auto enumerate ctrl sequences other than begin,frac and the like something like '(\\[a-z]+){' might work
    dct["cite"].extend(balanced(r"\\cite", file_data))
    dct["packages"].extend(balanced(r"\\usepackage", file_data))
    dct["title"].extend(balanced(r"\\title", file_data))
    dct["authors"].extend(balanced(r"\\author", file_data))
    dct["affiliations"].extend(balanced(r"\\affiliation", file_data))
    dct["abstract"].extend(balanced(r"\\begin{abstract}", file_data))
    dct["equations"].extend(balanced(r"\\begin{equation}", file_data))
    dct["math_ctrl_seq"].extend(math_ctrl_seq(file_data))
    # print(dct['math_ctrl_seq'])
    print(word_lst(file_data))
