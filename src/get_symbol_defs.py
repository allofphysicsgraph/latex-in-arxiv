from collections import defaultdict
from nltk.tokenize import texttiling
from nltk.tokenize.punkt import PunktTrainer, PunktSentenceTokenizer
import nltk
from os import listdir
from read_file import read_file
import re
from time import sleep
from nltk.tokenize import mwe
from nltk import pos_tag

tokenizer = mwe.MWETokenizer(separator="")


def add_new_token(string):
    tokenizer.add_mwe("{}".format(string))


def get_paragraphs(file_data):
    paragraphs = txttlng_tokenizer.tokenize(file_data)
    return paragraphs


def sentences_from_file(file_data):
    sentences = tok_cls.sentences_from_text(file_data)
    return sentences


def sentences_from_paragraphs(paragraphs):
    output = []
    for paragraph in paragraphs:
        sentences = tok_cls.sentences_from_text(paragraph)
        for sentence in sentences:
            output.append(sentence)
    return output


def symbol_concordance(sentences):
    concordance_dict = defaultdict(list)
    for sentence in sentences:
        maybe_definition = re.findall("\$.*?\$", sentence)
        if maybe_definition:
            for match in maybe_definition:
                concordance_dict[match].append(sentence)
    return concordance_dict


def get_symbol_definition(concordance_dict):
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


if __name__ == "__main__":
    txttlng_tokenizer = texttiling.TextTilingTokenizer(
        w=20, k=6, smoothing_width=2, smoothing_rounds=5
    )
    punkt_trainer = nltk.data.load("Punkt_LaTeX_SENT_Tokenizer.pickle")
    tok_cls = PunktSentenceTokenizer(punkt_trainer.get_params())
    results = defaultdict(list)
    file_data = read_file("..", "sound1.tex")
    for paragraph in get_paragraphs(file_data):
        results["paragraphs"].append(paragraph)

    for sentence in sentences_from_paragraphs(results["paragraphs"]):
        results["sentences_from_paragraphs"].append(sentence)

    # there are cases where extracting the paragraphs fail is too slow
    # or may not be of interest

    for sentence in sentences_from_file(file_data):
        results["sentences_file"].append(sentence)

    sentences = results["sentences_from_paragraphs"]
    concordance = symbol_concordance(sentences)
    # using mwe tokenizer for now
    latex = read_file("../postings_list", "latex.rl")
    latex = [x for x in re.split('"\s+[a-z]+\s+\||\n|\s+\|', latex) if x.strip()]
    latex = [x for x in latex if "\\" in x and not re.findall(":>|n--|n++|\[", x)]
    latex = set(latex)
    latex = sorted(latex, key=lambda x: -len(x))
    latex = [x.replace("\\\\", "\\") for x in latex]

    vocab = read_file("../postings_list", "vocab.rl")
    vocab = [x for x in re.split('"|\n|\|', vocab) if x.strip()]
    vocab = set(vocab)
    vocab = sorted(vocab, key=lambda x: -len(x))

    for value in latex:
        add_new_token(value)

    for value in vocab:
        add_new_token(value)

    file_data = read_file("..", "sound1.tex")
    tokens = tokenizer.tokenize(file_data)
    # print(concordance)
    symbol_defs = get_symbol_definition(concordance)
    for k, v in symbol_defs.items():
        print(k, v)
