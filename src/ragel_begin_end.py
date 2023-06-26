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

"""
>>> from ragel_simple import RagelSimple
>>> x = RagelSimple()
>>> with open('/home/user/latex-in-arxiv/sound1.tex','r') as f:
>>>    data = f.read()
>>> x.exposed_get_author(data=data)
>>> x.exposed_get_cite(data=data)
"""


with open("config.yaml", "r") as f:
    config = yaml.safe_load(f)


class RagelBeginEnd:
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

    def exposed_get_abstract(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{abstract}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{abstract}.{,7500}\\end{abstract}",
                            data,
                            re.DOTALL,
                        )
                        for match_abstract in data:
                            s = c_char_p(str.encode(match_abstract))
                            abstract = CDLL("./abstract.so")
                            abstract.test.restype = c_char_p
                            abstract.init()
                            for match in abstract.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into abstract (filename,abstract,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_algorithm(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{algorithm}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{algorithm}.{,7500}\\end{algorithm}",
                            data,
                            re.DOTALL,
                        )
                        for match_algorithm in data:
                            s = c_char_p(str.encode(match_algorithm))
                            algorithm = CDLL("./algorithm.so")
                            algorithm.test.restype = c_char_p
                            algorithm.init()
                            for match in algorithm.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into algorithm (filename,algorithm,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_align(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{align}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{align}.{,7500}\\end{align}",
                            data,
                            re.DOTALL,
                        )
                        for match_align in data:
                            s = c_char_p(str.encode(match_align))
                            align = CDLL("./align.so")
                            align.test.restype = c_char_p
                            align.init()
                            for match in align.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into align (filename,align,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_aligned(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{aligned}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{aligned}.{,7500}\\end{aligned}",
                            data,
                            re.DOTALL,
                        )
                        for match_aligned in data:
                            s = c_char_p(str.encode(match_aligned))
                            aligned = CDLL("./aligned.so")
                            aligned.test.restype = c_char_p
                            aligned.init()
                            for match in aligned.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into aligned (filename,aligned,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_cases(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{cases}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{cases}.{,7500}\\end{cases}",
                            data,
                            re.DOTALL,
                        )
                        for match_cases in data:
                            s = c_char_p(str.encode(match_cases))
                            cases = CDLL("./cases.so")
                            cases.test.restype = c_char_p
                            cases.init()
                            for match in cases.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into cases (filename,cases,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_cite(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{cite}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{cite}.{,7500}\\end{cite}",
                            data,
                            re.DOTALL,
                        )
                        for match_cite in data:
                            s = c_char_p(str.encode(match_cite))
                            cite = CDLL("./cite.so")
                            cite.test.restype = c_char_p
                            cite.init()
                            for match in cite.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into cite (filename,cite,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_comments(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{comments}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{comments}.{,7500}\\end{comments}",
                            data,
                            re.DOTALL,
                        )
                        for match_comments in data:
                            s = c_char_p(str.encode(match_comments))
                            comments = CDLL("./comments.so")
                            comments.test.restype = c_char_p
                            comments.init()
                            for match in comments.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into comments (filename,comments,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_description(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
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
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into description (filename,description,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_displaymath(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
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
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into displaymath (filename,displaymath,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_emph(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{emph}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{emph}.{,7500}\\end{emph}",
                            data,
                            re.DOTALL,
                        )
                        for match_emph in data:
                            s = c_char_p(str.encode(match_emph))
                            emph = CDLL("./emph.so")
                            emph.test.restype = c_char_p
                            emph.init()
                            for match in emph.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into emph (filename,emph,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_enumerate(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{enumerate}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{enumerate}.{,7500}\\end{enumerate}",
                            data,
                            re.DOTALL,
                        )
                        for match_enumerate in data:
                            s = c_char_p(str.encode(match_enumerate))
                            enumerate = CDLL("./enumerate.so")
                            enumerate.test.restype = c_char_p
                            enumerate.init()
                            for match in enumerate.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into enumerate (filename,enumerate,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_equation(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{equation}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{equation}.{,7500}\\end{equation}",
                            data,
                            re.DOTALL,
                        )
                        for match_equation in data:
                            s = c_char_p(str.encode(match_equation))
                            equation = CDLL("./equation.so")
                            equation.test.restype = c_char_p
                            equation.init()
                            for match in equation.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into equation (filename,equation,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_figure(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{figure}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{figure}.{,7500}\\end{figure}",
                            data,
                            re.DOTALL,
                        )
                        for match_figure in data:
                            s = c_char_p(str.encode(match_figure))
                            figure = CDLL("./figure.so")
                            figure.test.restype = c_char_p
                            figure.init()
                            for match in figure.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into figure (filename,figure,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_flushleft(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{flushleft}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{flushleft}.{,7500}\\end{flushleft}",
                            data,
                            re.DOTALL,
                        )
                        for match_flushleft in data:
                            s = c_char_p(str.encode(match_flushleft))
                            flushleft = CDLL("./flushleft.so")
                            flushleft.test.restype = c_char_p
                            flushleft.init()
                            for match in flushleft.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into flushleft (filename,flushleft,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_flushright(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{flushright}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{flushright}.{,7500}\\end{flushright}",
                            data,
                            re.DOTALL,
                        )
                        for match_flushright in data:
                            s = c_char_p(str.encode(match_flushright))
                            flushright = CDLL("./flushright.so")
                            flushright.test.restype = c_char_p
                            flushright.init()
                            for match in flushright.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into flushright (filename,flushright,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_fmfgraph(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{fmfgraph}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{fmfgraph}.{,7500}\\end{fmfgraph}",
                            data,
                            re.DOTALL,
                        )
                        for match_fmfgraph in data:
                            s = c_char_p(str.encode(match_fmfgraph))
                            fmfgraph = CDLL("./fmfgraph.so")
                            fmfgraph.test.restype = c_char_p
                            fmfgraph.init()
                            for match in fmfgraph.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into fmfgraph (filename,fmfgraph,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_gather(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{gather}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{gather}.{,7500}\\end{gather}",
                            data,
                            re.DOTALL,
                        )
                        for match_gather in data:
                            s = c_char_p(str.encode(match_gather))
                            gather = CDLL("./gather.so")
                            gather.test.restype = c_char_p
                            gather.init()
                            for match in gather.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into gather (filename,gather,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_label(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{label}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{label}.{,7500}\\end{label}",
                            data,
                            re.DOTALL,
                        )
                        for match_label in data:
                            s = c_char_p(str.encode(match_label))
                            label = CDLL("./label.so")
                            label.test.restype = c_char_p
                            label.init()
                            for match in label.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into label (filename,label,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_lemma(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{lemma}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{lemma}.{,7500}\\end{lemma}",
                            data,
                            re.DOTALL,
                        )
                        for match_lemma in data:
                            s = c_char_p(str.encode(match_lemma))
                            lemma = CDLL("./lemma.so")
                            lemma.test.restype = c_char_p
                            lemma.init()
                            for match in lemma.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into lemma (filename,lemma,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_list(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{list}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{list}.{,7500}\\end{list}",
                            data,
                            re.DOTALL,
                        )
                        for match_list in data:
                            s = c_char_p(str.encode(match_list))
                            list = CDLL("./list.so")
                            list.test.restype = c_char_p
                            list.init()
                            for match in list.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into list (filename,list,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_lstcode(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{lstcode}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{lstcode}.{,7500}\\end{lstcode}",
                            data,
                            re.DOTALL,
                        )
                        for match_lstcode in data:
                            s = c_char_p(str.encode(match_lstcode))
                            lstcode = CDLL("./lstcode.so")
                            lstcode.test.restype = c_char_p
                            lstcode.init()
                            for match in lstcode.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into lstcode (filename,lstcode,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_lstlisting(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{lstlisting}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{lstlisting}.{,7500}\\end{lstlisting}",
                            data,
                            re.DOTALL,
                        )
                        for match_lstlisting in data:
                            s = c_char_p(str.encode(match_lstlisting))
                            lstlisting = CDLL("./lstlisting.so")
                            lstlisting.test.restype = c_char_p
                            lstlisting.init()
                            for match in lstlisting.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into lstlisting (filename,lstlisting,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_mathletters(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
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
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into mathletters (filename,mathletters,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_matrix(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{matrix}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{matrix}.{,7500}\\end{matrix}",
                            data,
                            re.DOTALL,
                        )
                        for match_matrix in data:
                            s = c_char_p(str.encode(match_matrix))
                            matrix = CDLL("./matrix.so")
                            matrix.test.restype = c_char_p
                            matrix.init()
                            for match in matrix.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into matrix (filename,matrix,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_minipage(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{minipage}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{minipage}.{,7500}\\end{minipage}",
                            data,
                            re.DOTALL,
                        )
                        for match_minipage in data:
                            s = c_char_p(str.encode(match_minipage))
                            minipage = CDLL("./minipage.so")
                            minipage.test.restype = c_char_p
                            minipage.init()
                            for match in minipage.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into minipage (filename,minipage,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_minted(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{minted}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{minted}.{,7500}\\end{minted}",
                            data,
                            re.DOTALL,
                        )
                        for match_minted in data:
                            s = c_char_p(str.encode(match_minted))
                            minted = CDLL("./minted.so")
                            minted.test.restype = c_char_p
                            minted.init()
                            for match in minted.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into minted (filename,minted,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_multline(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{multline}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{multline}.{,7500}\\end{multline}",
                            data,
                            re.DOTALL,
                        )
                        for match_multline in data:
                            s = c_char_p(str.encode(match_multline))
                            multline = CDLL("./multline.so")
                            multline.test.restype = c_char_p
                            multline.init()
                            for match in multline.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into multline (filename,multline,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_picture(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{picture}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{picture}.{,7500}\\end{picture}",
                            data,
                            re.DOTALL,
                        )
                        for match_picture in data:
                            s = c_char_p(str.encode(match_picture))
                            picture = CDLL("./picture.so")
                            picture.test.restype = c_char_p
                            picture.init()
                            for match in picture.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into picture (filename,picture,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_pmatrix(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{pmatrix}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{pmatrix}.{,7500}\\end{pmatrix}",
                            data,
                            re.DOTALL,
                        )
                        for match_pmatrix in data:
                            s = c_char_p(str.encode(match_pmatrix))
                            pmatrix = CDLL("./pmatrix.so")
                            pmatrix.test.restype = c_char_p
                            pmatrix.init()
                            for match in pmatrix.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into pmatrix (filename,pmatrix,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_proof(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{proof}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{proof}.{,7500}\\end{proof}",
                            data,
                            re.DOTALL,
                        )
                        for match_proof in data:
                            s = c_char_p(str.encode(match_proof))
                            proof = CDLL("./proof.so")
                            proof.test.restype = c_char_p
                            proof.init()
                            for match in proof.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into proof (filename,proof,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_prop(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{prop}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{prop}.{,7500}\\end{prop}",
                            data,
                            re.DOTALL,
                        )
                        for match_prop in data:
                            s = c_char_p(str.encode(match_prop))
                            prop = CDLL("./prop.so")
                            prop.test.restype = c_char_p
                            prop.init()
                            for match in prop.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into prop (filename,prop,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_proposition(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
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
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into proposition (filename,proposition,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_quotation(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{quotation}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{quotation}.{,7500}\\end{quotation}",
                            data,
                            re.DOTALL,
                        )
                        for match_quotation in data:
                            s = c_char_p(str.encode(match_quotation))
                            quotation = CDLL("./quotation.so")
                            quotation.test.restype = c_char_p
                            quotation.init()
                            for match in quotation.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into quotation (filename,quotation,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_quote(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{quote}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{quote}.{,7500}\\end{quote}",
                            data,
                            re.DOTALL,
                        )
                        for match_quote in data:
                            s = c_char_p(str.encode(match_quote))
                            quote = CDLL("./quote.so")
                            quote.test.restype = c_char_p
                            quote.init()
                            for match in quote.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into quote (filename,quote,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_ref(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{ref}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{ref}.{,7500}\\end{ref}",
                            data,
                            re.DOTALL,
                        )
                        for match_ref in data:
                            s = c_char_p(str.encode(match_ref))
                            ref = CDLL("./ref.so")
                            ref.test.restype = c_char_p
                            ref.init()
                            for match in ref.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into ref (filename,ref,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_references(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{references}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{references}.{,7500}\\end{references}",
                            data,
                            re.DOTALL,
                        )
                        for match_references in data:
                            s = c_char_p(str.encode(match_references))
                            references = CDLL("./references.so")
                            references.test.restype = c_char_p
                            references.init()
                            for match in references.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into references (filename,references,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_scope(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{scope}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{scope}.{,7500}\\end{scope}",
                            data,
                            re.DOTALL,
                        )
                        for match_scope in data:
                            s = c_char_p(str.encode(match_scope))
                            scope = CDLL("./scope.so")
                            scope.test.restype = c_char_p
                            scope.init()
                            for match in scope.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into scope (filename,scope,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_split(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{split}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{split}.{,7500}\\end{split}",
                            data,
                            re.DOTALL,
                        )
                        for match_split in data:
                            s = c_char_p(str.encode(match_split))
                            split = CDLL("./split.so")
                            split.test.restype = c_char_p
                            split.init()
                            for match in split.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into split (filename,split,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_subequations(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
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
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into subequations (filename,subequations,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_table(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{table}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{table}.{,7500}\\end{table}",
                            data,
                            re.DOTALL,
                        )
                        for match_table in data:
                            s = c_char_p(str.encode(match_table))
                            table = CDLL("./table.so")
                            table.test.restype = c_char_p
                            table.init()
                            for match in table.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into table (filename,table,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_tabular(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{tabular}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{tabular}.{,7500}\\end{tabular}",
                            data,
                            re.DOTALL,
                        )
                        for match_tabular in data:
                            s = c_char_p(str.encode(match_tabular))
                            tabular = CDLL("./tabular.so")
                            tabular.test.restype = c_char_p
                            tabular.init()
                            for match in tabular.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into tabular (filename,tabular,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_theorem(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{theorem}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{theorem}.{,7500}\\end{theorem}",
                            data,
                            re.DOTALL,
                        )
                        for match_theorem in data:
                            s = c_char_p(str.encode(match_theorem))
                            theorem = CDLL("./theorem.so")
                            theorem.test.restype = c_char_p
                            theorem.init()
                            for match in theorem.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into theorem (filename,theorem,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_titlepage(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{titlepage}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{titlepage}.{,7500}\\end{titlepage}",
                            data,
                            re.DOTALL,
                        )
                        for match_titlepage in data:
                            s = c_char_p(str.encode(match_titlepage))
                            titlepage = CDLL("./titlepage.so")
                            titlepage.test.restype = c_char_p
                            titlepage.init()
                            for match in titlepage.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into titlepage (filename,titlepage,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_url(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{url}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{url}.{,7500}\\end{url}",
                            data,
                            re.DOTALL,
                        )
                        for match_url in data:
                            s = c_char_p(str.encode(match_url))
                            url = CDLL("./url.so")
                            url.test.restype = c_char_p
                            url.init()
                            for match in url.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into url (filename,url,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)

    def exposed_get_verbatim(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        if self.postgres:
            conn, cursor = self.db_cursor()
            if re.findall(r"\\begin{verbatim}", data):
                if save or print_results:
                    try:
                        data = re.findall(
                            r"\\begin{verbatim}.{,7500}\\end{verbatim}",
                            data,
                            re.DOTALL,
                        )
                        for match_verbatim in data:
                            s = c_char_p(str.encode(match_verbatim))
                            verbatim = CDLL("./verbatim.so")
                            verbatim.test.restype = c_char_p
                            verbatim.init()
                            for match in verbatim.test(s).decode().splitlines():
                                # print(match)
                                if self.postgres:
                                    if not current_file:
                                        current_file = self.current_file
                                    length = len(match)
                                    match = match.replace("'", "''")
                                    cursor.execute(
                                        f"insert into verbatim (filename,verbatim,len) values ('{current_file}','{match}',{length});"
                                    )
                                    conn.commit()
                    except Exception as e:
                        print(e)
