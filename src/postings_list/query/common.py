def get_sentences(data):
    from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
    import nltk
    from sys import argv
    import re

    # depends on nltk 3.8 which has a CVE
    # also depends on 285M file punkt_html_trainer.
    # send an email or post an issue if you want a copy of the pickled punkt model.
    # I find that it is performs better than the default sentence punkt english model.

    punkt_trainer = nltk.data.load("punkt_html_trainer", format="pickle")
    tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
    from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer

    tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
    with open(argv[1], "r") as f:
        data = f.read()
        match = re.findall(
            r"\\begin{thebibliography}.*?\\end{thebibliography}", data, re.DOTALL
        )
        if match:
            match = match[0]
            data = data.replace(match, "")
        print(data)

    tok_cls.sentences_from_text(data)
    sentences = tok_cls.sentences_from_text(data)
    return sentences


def word_tokenizer(data):
    from time import sleep
    from nltk import mwe
    from sys import argv
    import re

    with open("vocab.rl", "r") as f:
        data = f.read()
        english_vocab = re.findall(r'"(.*?)"', data)

    english_word_tokenizer = mwe.MWETokenizer(separator="")
    word_list = sorted(english_vocab, key=lambda x: -len(x))
    for word in word_list:
        # print(word)
        english_word_tokenizer.add_mwe(word)

    for ix in range(len(sentences)):
        sent = sentences[ix]
        print(sent)
        resp = english_word_tokenizer.tokenize(sent)
        print([x for x in resp if x.strip()])


def get_paragraphs(file_data):
    from nltk.tokenize import texttiling

    txttlng_tokenizer = texttiling.TextTilingTokenizer(
        w=20, k=6, smoothing_width=2, smoothing_rounds=5
    )
    paragraphs = txttlng_tokenizer.tokenize(file_data)
    return paragraphs


def symbol_concordance(sentences):
    concordance_dict = defaultdict(list)
    for sentence in sentences:
        maybe_definition = re.findall("\$.*?\$", sentence)
        if maybe_definition:
            for match in maybe_definition:
                concordance_dict[match].append(sentence)
    return concordance_dict


def get_symbol_definition(concordance_dict):
    import nltk

    symbol_definitions = defaultdict(set)
    labels = [f"DEF{x}" for x in range(100)]
    grammar = r"""
        DEF0: {<DT><JJ><NN><JJ><NN>}
        DEF1: {<DT><JJ><NN><NN><NN>}
        DEF2: {<WRB><NN><VBZ><DT><NN><.*>*}
        DEF3: {<WRB><NN><CC><NN><VBP><JJ><NN><CC><NN>}
        DEF4: {<WRB><NN><VBZ><DT><JJ><NN>}
        DEF5: {<PRP$><NN><VBZ><VBN><IN><DT><NN><NN><NNP>}
        DEF6: {<WRB><NN><VBZ><DT><NN><IN><DT><NN>}
        DEF7: {<CC><NN><VBZ><DT><NN><NN>}
        DEF8: {<NN><VBZ><DT><JJ><NN>}
        DEF9: {<NN><VBZ><DT><NN><NN>}
        DEF10: {<CC><NN><VBZ><DT><NN>}
        DEF11: {<CC><NNP><JJ><NN>}
        DEF12: {<NN><VBZ><DT><NN><NN>}
        DEF13: {<WRB><NN><VBZ><DT><JJ><NN>}
        DEF14: {<WRB><NN><VBZ><DT><JJ><NN><IN><NN>}
        DEF15: {<DT><NN><NN><IN><NNP><CC><NNP><IN><DT><NN><IN><IN><JJ>}
        DEF16: {<JJ><NNP><VBZ><VBN><IN><JJ><NNS>}
        DEF17: {<JJ><NN><IN><DT><NN><IN><NN><IN><JJ><NN><NN>}
        DEF18: {<NN><VBZ><VBN><IN><DT><NN><NN><NNP>}
        DEF19: {<IN><NNS><IN><NN><NN><NNP>}
        DEF20: {<PRP><RB><VBD><NNP>}
        DEF21: {<NN><NN><NNP><WRB><NNS><NN><TO><VB>}
        DEF22: {<DT><NN><NN><NNP>}
        DEF23: {<PRP><RB><VBD><NNP>}
        DEF24: {<RB><TO><DT><NN>}
        DEF25: {<IN><JJ><NN><NNP><NNP>}
        DEF26: {<WRB><NNP><NNP><CC><NNP><NNP><VBP><NNP><NN><CC><NN><NN>}
        DEF27: {<PRP><RB><VBD><NNP><CC><NNP>}
        DEF28: {<CC><RB><PRP><VBP><NNS><IN><DT><NN><NN><NN>}
        DEF29: {<CC><DT><JJ><NN><IN><NNP><IN><NNP>}
        DEF30: {<DT><JJ><NN><VBZ><RB><VBN><IN><DT><NN><NNP><NN>}
        DEF31: {<PRP><RB><VBD><NNP><CC><NNP><IN><NNP><TO><VB><IN><DT><JJ><NN><IN><NN><IN><JJ>}
        DEF32: {<VBG><JJ><NNP><IN><NNP><IN><NNP><VBZ>}
        DEF33: {<WRB><NNP><NNP><VBZ><DT><NNP><NN><NNP>}
        DEF34: {<DT><NN><NN><NNP>}
        DEF35: {<DT><JJ><NN><IN><NN><VBZ><JJ>}
        DEF36: {<JJ><NN><NNP><RB><VBZ><IN><DT><NN><IN><NN><TO><VBG><NN>}
        DEF37: {<VBG><NN><CC><JJ><VBZ><VBP>}
        DEF38: {<NNP><NN><WDT><VBZ><DT><NN><NN><IN><DT><NNP><NN>}
        DEF39: {<DT><NN><NN><NNP><NNP><MD><VB><VBN><IN><NN>}
        DEF40: {<DT><NN><NN><VBZ><IN><JJ><CC><MD><VB><VBN><IN><DT><JJ><NN><IN><NN>}
        DEF41: {<JJ><NN><IN><NNS><VBZ><RB><VB><IN><DT><JJ><NN><VBN><IN><DT><NN><IN><NN><CC><DT><JJ><NN><SYM>}
        DEF42: {<JJ><VBZ><DT><NN><JJ><NN><IN><DT><NN><IN><NN><IN><NN>}
        DEF43: {<DT><NNS><IN><DT><NNP><NN><NNP><NNP>}
        DEF44: {<DT><JJ><NNP><NN><NN><VBD><IN><DT><JJ><NN><NNP><NNP><NNP><NN><VBZ><JJ>}
        DEF45: {<DT><NN><NN><NNP><NNP>}
        DEF46: {<VBG><IN><NNP><IN><NNP><CC><NNP><VBP><NNP>}
        DEF47: {<NNP><DT><JJS><NN><VBZ><VBN><IN><JJ>}
    """
    cp = nltk.chunk.RegexpParser(grammar)
    for symbol, sentences in concordance.items():
        for sent in sentences:
            [add_new_token(x) for x in re.findall("\$.*?\$", sent)]
            resp = tokenizer.tokenize(sent)
            resp = [x for x in resp if x.strip()]
            test = [x for x in resp if "$" in x]
            if test:
                output = cp.parse(pos_tag(resp))
                for subtree in output.subtrees(filter=lambda t: t.label() in labels):
                    # print(subtree)
                    DEF = " ".join([x[0] for x in subtree])
                    if re.findall("\$.*?\$", DEF):
                        if symbol in DEF:
                            symbol_definitions[symbol].add(DEF)
    return symbol_definitions
