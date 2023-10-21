from ctypes import *
import sys
from pygments.lexer import RegexLexer
from pygments.token import *
from pygments import highlight
from pygments.formatters import Terminal256Formatter
from pygments.style import Style
from random import shuffle
import inspect
from psycopg2 import connect
import yaml
from redis import Redis
from collections import defaultdict
import re

with open("config.yaml", "r") as f:
    config = yaml.safe_load(f)


class Ragel:
    def __init__(self):
        self.results = defaultdict(list)
        self.current_file = ""
        self.redis_client = Redis(decode_responses=True)
        self.data_set_path = "test/"
        self.return_length = []
        self.debug = True
        self.postgres = True

    def db_cursor(self):
        conn = connect(
            dbname=config["dbname"],
            user=config["user"],
            password=config["password"],
            host=config["host"],
            port=config["port"],
        )
        cursor = conn.cursor()
        return conn, cursor

    def exposed_get_cite(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for cite_match in re.findall(r"\\cite{.{,1000}", data):
            s = c_char_p(str.encode(cite_match))
            cite = CDLL("./cite.so")
            cite.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                cite.init()
                for match in cite.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_cite"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into cite (filename,cite,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_ref(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for ref_match in re.findall(r"\\ref{.{,1000}", data):
            s = c_char_p(str.encode(ref_match))
            ref = CDLL("./ref.so")
            ref.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                ref.init()
                for match in ref.test(s).decode().splitlines():
                    if not save:
                        self.results[f"{current_file}_ref"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into ref (filename,ref,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_author(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for author_match in re.findall(r"\\author{.{,1000}", data):
            s = c_char_p(str.encode(author_match))
            author = CDLL("./author.so")
            author.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                author.init()
                for match in author.test(s).decode().splitlines():
                    if not save:
                        self.results[f"{current_file}_author"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into author (filename,author,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_title(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for title_match in re.findall(r"\\title{.{,1000}", data):
            s = c_char_p(str.encode(title_match))
            title = CDLL("./title.so")
            title.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                title.init()
                for match in title.test(s).decode().splitlines():
                    if not save:
                        self.results[f"{current_file}_title"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into title (filename,title,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_emph(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for emph_match in re.findall(r"\\emph{.{,1000}", data):
            s = c_char_p(str.encode(emph_match))
            emph = CDLL("./emph.so")
            emph.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                emph.init()
                for match in emph.test(s).decode().splitlines():
                    if not save:
                        self.results[f"{current_file}_emph"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into emph (filename,emph,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_label(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for label_match in re.findall(r"\\label{.{,1000}", data):
            s = c_char_p(str.encode(label_match))
            label = CDLL("./label.so")
            label.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                label.init()
                for match in label.test(s).decode().splitlines():
                    if not save:
                        self.results[f"{current_file}_label"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into label (filename,label,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_abstract(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{abstract}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{abstract}.{,7500}\\end{abstract}", data, re.DOTALL
                    )
                    for match_abstract in data:
                        s = c_char_p(str.encode(match_abstract))
                        abstract = CDLL("./abstract.so")
                        abstract.test.restype = c_char_p
                        abstract.init()
                        for match in abstract.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_abstract"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_align(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{align}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{align}.{,7500}\\end{align}", data, re.DOTALL
                    )
                    for match_align in data:
                        s = c_char_p(str.encode(match_align))
                        align = CDLL("./align.so")
                        align.test.restype = c_char_p
                        align.init()
                        for match in align.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_align"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_aligned(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{aligned}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{aligned}.{,7500}\\end{aligned}", data, re.DOTALL
                    )
                    for match_aligned in data:
                        s = c_char_p(str.encode(match_aligned))
                        aligned = CDLL("./aligned.so")
                        aligned.test.restype = c_char_p
                        aligned.init()
                        for match in aligned.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_aligned"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_cases(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{cases}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{cases}.{,7500}\\end{cases}", data, re.DOTALL
                    )
                    for match_cases in data:
                        s = c_char_p(str.encode(match_cases))
                        cases = CDLL("./cases.so")
                        cases.test.restype = c_char_p
                        cases.init()
                        for match in cases.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_cases"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_description(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{description}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{description}.{,7500}\\end{description}",
                        data,
                        re.DOTALL,
                    )
                    for match_description in data:
                        s = c_char_p(str.encode(match_description))
                        description = CDLL("./description.so")
                        description.test.restype = c_char_p
                        description.init()
                        for match in description.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_description"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_displaymath(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{displaymath}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{displaymath}.{,7500}\\end{displaymath}",
                        data,
                        re.DOTALL,
                    )
                    for match_displaymath in data:
                        s = c_char_p(str.encode(match_displaymath))
                        displaymath = CDLL("./displaymath.so")
                        displaymath.test.restype = c_char_p
                        displaymath.init()
                        for match in displaymath.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_displaymath"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_enumerate(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{enumerate}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{enumerate}.{,7500}\\end{enumerate}", data, re.DOTALL
                    )
                    for match_enumerate in data:
                        s = c_char_p(str.encode(match_enumerate))
                        enumerate = CDLL("./enumerate.so")
                        enumerate.test.restype = c_char_p
                        enumerate.init()
                        for match in enumerate.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_enumerate"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_flushleft(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{flushleft}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{flushleft}.{,7500}\\end{flushleft}", data, re.DOTALL
                    )
                    for match_flushleft in data:
                        s = c_char_p(str.encode(match_flushleft))
                        flushleft = CDLL("./flushleft.so")
                        flushleft.test.restype = c_char_p
                        flushleft.init()
                        for match in flushleft.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_flushleft"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_flushright(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{flushright}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{flushright}.{,7500}\\end{flushright}", data, re.DOTALL
                    )
                    for match_flushright in data:
                        s = c_char_p(str.encode(match_flushright))
                        flushright = CDLL("./flushright.so")
                        flushright.test.restype = c_char_p
                        flushright.init()
                        for match in flushright.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_flushright"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_fmfgraph(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{fmfgraph}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{fmfgraph}.{,7500}\\end{fmfgraph}", data, re.DOTALL
                    )
                    for match_fmfgraph in data:
                        s = c_char_p(str.encode(match_fmfgraph))
                        fmfgraph = CDLL("./fmfgraph.so")
                        fmfgraph.test.restype = c_char_p
                        fmfgraph.init()
                        for match in fmfgraph.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_fmfgraph"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_gather(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{gather}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{gather}.{,7500}\\end{gather}", data, re.DOTALL
                    )
                    for match_gather in data:
                        s = c_char_p(str.encode(match_gather))
                        gather = CDLL("./gather.so")
                        gather.test.restype = c_char_p
                        gather.init()
                        for match in gather.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_gather"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_lemma(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{lemma}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{lemma}.{,7500}\\end{lemma}", data, re.DOTALL
                    )
                    for match_lemma in data:
                        s = c_char_p(str.encode(match_lemma))
                        lemma = CDLL("./lemma.so")
                        lemma.test.restype = c_char_p
                        lemma.init()
                        for match in lemma.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_lemma"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_list(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{list}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{list}.{,7500}\\end{list}", data, re.DOTALL
                    )
                    for match_list in data:
                        s = c_char_p(str.encode(match_list))
                        list = CDLL("./list.so")
                        list.test.restype = c_char_p
                        list.init()
                        for match in list.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_list"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_lstcode(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{lstcode}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{lstcode}.{,7500}\\end{lstcode}", data, re.DOTALL
                    )
                    for match_lstcode in data:
                        s = c_char_p(str.encode(match_lstcode))
                        lstcode = CDLL("./lstcode.so")
                        lstcode.test.restype = c_char_p
                        lstcode.init()
                        for match in lstcode.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_lstcode"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_lstlisting(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{lstlisting}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{lstlisting}.{,7500}\\end{lstlisting}", data, re.DOTALL
                    )
                    for match_lstlisting in data:
                        s = c_char_p(str.encode(match_lstlisting))
                        lstlisting = CDLL("./lstlisting.so")
                        lstlisting.test.restype = c_char_p
                        lstlisting.init()
                        for match in lstlisting.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_lstlisting"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_mathletters(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{mathletters}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{mathletters}.{,7500}\\end{mathletters}",
                        data,
                        re.DOTALL,
                    )
                    for match_mathletters in data:
                        s = c_char_p(str.encode(match_mathletters))
                        mathletters = CDLL("./mathletters.so")
                        mathletters.test.restype = c_char_p
                        mathletters.init()
                        for match in mathletters.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_mathletters"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_matrix(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{matrix}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{matrix}.{,7500}\\end{matrix}", data, re.DOTALL
                    )
                    for match_matrix in data:
                        s = c_char_p(str.encode(match_matrix))
                        matrix = CDLL("./matrix.so")
                        matrix.test.restype = c_char_p
                        matrix.init()
                        for match in matrix.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_matrix"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_minipage(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{minipage}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{minipage}.{,7500}\\end{minipage}", data, re.DOTALL
                    )
                    for match_minipage in data:
                        s = c_char_p(str.encode(match_minipage))
                        minipage = CDLL("./minipage.so")
                        minipage.test.restype = c_char_p
                        minipage.init()
                        for match in minipage.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_minipage"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_minted(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{minted}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{minted}.{,7500}\\end{minted}", data, re.DOTALL
                    )
                    for match_minted in data:
                        s = c_char_p(str.encode(match_minted))
                        minted = CDLL("./minted.so")
                        minted.test.restype = c_char_p
                        minted.init()
                        for match in minted.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_minted"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_multline(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{multline}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{multline}.{,7500}\\end{multline}", data, re.DOTALL
                    )
                    for match_multline in data:
                        s = c_char_p(str.encode(match_multline))
                        multline = CDLL("./multline.so")
                        multline.test.restype = c_char_p
                        multline.init()
                        for match in multline.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_multline"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_picture(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{picture}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{picture}.{,7500}\\end{picture}", data, re.DOTALL
                    )
                    for match_picture in data:
                        s = c_char_p(str.encode(match_picture))
                        picture = CDLL("./picture.so")
                        picture.test.restype = c_char_p
                        picture.init()
                        for match in picture.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_picture"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_pmatrix(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{pmatrix}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{pmatrix}.{,7500}\\end{pmatrix}", data, re.DOTALL
                    )
                    for match_pmatrix in data:
                        s = c_char_p(str.encode(match_pmatrix))
                        pmatrix = CDLL("./pmatrix.so")
                        pmatrix.test.restype = c_char_p
                        pmatrix.init()
                        for match in pmatrix.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_pmatrix"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_proof(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{proof}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{proof}.{,7500}\\end{proof}", data, re.DOTALL
                    )
                    for match_proof in data:
                        s = c_char_p(str.encode(match_proof))
                        proof = CDLL("./proof.so")
                        proof.test.restype = c_char_p
                        proof.init()
                        for match in proof.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_proof"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_prop(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{prop}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{prop}.{,7500}\\end{prop}", data, re.DOTALL
                    )
                    for match_prop in data:
                        s = c_char_p(str.encode(match_prop))
                        prop = CDLL("./prop.so")
                        prop.test.restype = c_char_p
                        prop.init()
                        for match in prop.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_prop"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_proposition(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{proposition}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{proposition}.{,7500}\\end{proposition}",
                        data,
                        re.DOTALL,
                    )
                    for match_proposition in data:
                        s = c_char_p(str.encode(match_proposition))
                        proposition = CDLL("./proposition.so")
                        proposition.test.restype = c_char_p
                        proposition.init()
                        for match in proposition.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_proposition"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_quotation(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{quotation}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{quotation}.{,7500}\\end{quotation}", data, re.DOTALL
                    )
                    for match_quotation in data:
                        s = c_char_p(str.encode(match_quotation))
                        quotation = CDLL("./quotation.so")
                        quotation.test.restype = c_char_p
                        quotation.init()
                        for match in quotation.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_quotation"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_quote(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{quote}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{quote}.{,7500}\\end{quote}", data, re.DOTALL
                    )
                    for match_quote in data:
                        s = c_char_p(str.encode(match_quote))
                        quote = CDLL("./quote.so")
                        quote.test.restype = c_char_p
                        quote.init()
                        for match in quote.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_quote"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_references(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{references}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{references}.{,7500}\\end{references}", data, re.DOTALL
                    )
                    for match_references in data:
                        s = c_char_p(str.encode(match_references))
                        references = CDLL("./references.so")
                        references.test.restype = c_char_p
                        references.init()
                        for match in references.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_references"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_scope(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{scope}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{scope}.{,7500}\\end{scope}", data, re.DOTALL
                    )
                    for match_scope in data:
                        s = c_char_p(str.encode(match_scope))
                        scope = CDLL("./scope.so")
                        scope.test.restype = c_char_p
                        scope.init()
                        for match in scope.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_scope"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_split(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{split}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{split}.{,7500}\\end{split}", data, re.DOTALL
                    )
                    for match_split in data:
                        s = c_char_p(str.encode(match_split))
                        split = CDLL("./split.so")
                        split.test.restype = c_char_p
                        split.init()
                        for match in split.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_split"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_subequations(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{subequations}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{subequations}.{,7500}\\end{subequations}",
                        data,
                        re.DOTALL,
                    )
                    for match_subequations in data:
                        s = c_char_p(str.encode(match_subequations))
                        subequations = CDLL("./subequations.so")
                        subequations.test.restype = c_char_p
                        subequations.init()
                        for match in subequations.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_subequations"].append(
                                    match
                                )
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_table(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{table}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{table}.{,7500}\\end{table}", data, re.DOTALL
                    )
                    for match_table in data:
                        s = c_char_p(str.encode(match_table))
                        table = CDLL("./table.so")
                        table.test.restype = c_char_p
                        table.init()
                        for match in table.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_table"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_tabular(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{tabular}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{tabular}.{,7500}\\end{tabular}", data, re.DOTALL
                    )
                    for match_tabular in data:
                        s = c_char_p(str.encode(match_tabular))
                        tabular = CDLL("./tabular.so")
                        tabular.test.restype = c_char_p
                        tabular.init()
                        for match in tabular.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_tabular"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_theorem(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{theorem}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{theorem}.{,7500}\\end{theorem}", data, re.DOTALL
                    )
                    for match_theorem in data:
                        s = c_char_p(str.encode(match_theorem))
                        theorem = CDLL("./theorem.so")
                        theorem.test.restype = c_char_p
                        theorem.init()
                        for match in theorem.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_theorem"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_titlepage(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{titlepage}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{titlepage}.{,7500}\\end{titlepage}", data, re.DOTALL
                    )
                    for match_titlepage in data:
                        s = c_char_p(str.encode(match_titlepage))
                        titlepage = CDLL("./titlepage.so")
                        titlepage.test.restype = c_char_p
                        titlepage.init()
                        for match in titlepage.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_titlepage"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))

    def exposed_get_verbatim(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if re.findall(r"\\begin{verbatim}", data):
            if save or print_results:
                try:
                    data = re.findall(
                        r"\\begin{verbatim}.{,7500}\\end{verbatim}", data, re.DOTALL
                    )
                    for match_verbatim in data:
                        s = c_char_p(str.encode(match_verbatim))
                        verbatim = CDLL("./verbatim.so")
                        verbatim.test.restype = c_char_p
                        verbatim.init()
                        for match in verbatim.test(s).decode().splitlines():
                            if not save:
                                # print(match)
                                self.results[f"{current_file}_verbatim"].append(match)
                            if print_results:
                                self.return_length.append(len(match))
                                print(
                                    max(self.return_length),
                                    sum(self.return_length)
                                    / (1.0 * len(self.return_length)),
                                )
                except:
                    print("error on {)".format(self.current_file))


    def exposed_get_url(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        s = c_char_p(str.encode(data))
        url = CDLL("./url.so")
        url.test.restype = c_char_p
        if save or print_results:
            url.init()
            for match in url.test(s).decode().splitlines():
                if not save:
                    self.results[f"{current_file}_url"].append(match)
                if print_results:
                    print(match)

    def exposed_get_affiliation(self, data=False, save=True, print_results=False):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        for affiliation_match in re.findall(r"\\affiliation{.{,1000}", data):
            s = c_char_p(str.encode(affiliation_match))
            affiliation = CDLL("./affiliation.so")
            affiliation.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                affiliation.init()
                for match in affiliation.test(s).decode().splitlines():
                    if not save:
                        self.results[f"{current_file}_affiliation"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into affiliation (filename,affiliation,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
