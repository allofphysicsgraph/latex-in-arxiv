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


class RagelSimple:
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

    def exposed_get_affiliation(
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
        for affiliation_match in re.findall(r"\\affiliation{.{,1000}", data):
            s = c_char_p(str.encode(affiliation_match))
            affiliation = CDLL("./affiliation.so")
            affiliation.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                affiliation.init()
                for match in affiliation.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_affiliation"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into affiliation (filename,affiliation,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_author(
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
        for author_match in re.findall(r"\\author{.{,1000}", data):
            s = c_char_p(str.encode(author_match))
            author = CDLL("./author.so")
            author.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                author.init()
                for match in author.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_author"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into author (filename,author,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_section(
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
        for section_match in re.findall(r"\\section{.{,1000}", data):
            s = c_char_p(str.encode(section_match))
            section = CDLL("./section.so")
            section.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                section.init()
                for match in section.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_section"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into section (filename,section,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_scalebox(
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
        for scalebox_match in re.findall(r"\\scalebox{.{,1000}", data):
            s = c_char_p(str.encode(scalebox_match))
            scalebox = CDLL("./scalebox.so")
            scalebox.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                scalebox.init()
                for match in scalebox.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_scalebox"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into scalebox (filename,scalebox,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_caption(
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
        for caption_match in re.findall(r"\\caption{.{,1000}", data):
            s = c_char_p(str.encode(caption_match))
            caption = CDLL("./caption.so")
            caption.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                caption.init()
                for match in caption.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_caption"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into caption (filename,caption,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_bibitem(
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
        for bibitem_match in re.findall(r"\\bibitem{.{,1000}", data):
            s = c_char_p(str.encode(bibitem_match))
            bibitem = CDLL("./bibitem.so")
            bibitem.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                bibitem.init()
                for match in bibitem.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_bibitem"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into bibitem (filename,bibitem,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_usepackage(
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
        for usepackage_match in re.findall(r"\\usepackage{.{,1000}", data):
            s = c_char_p(str.encode(usepackage_match))
            usepackage = CDLL("./usepackage.so")
            usepackage.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                usepackage.init()
                for match in usepackage.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_usepackage"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into usepackage (filename,usepackage,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_author(
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
        for author_match in re.findall(r"\\author{.{,1000}", data):
            s = c_char_p(str.encode(author_match))
            author = CDLL("./author.so")
            author.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                author.init()
                for match in author.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_author"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into author (filename,author,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

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

    def exposed_get_ref(
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
        for ref_match in re.findall(r"\\ref{.{,1000}", data):
            s = c_char_p(str.encode(ref_match))
            ref = CDLL("./ref.so")
            ref.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                ref.init()
                for match in ref.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_ref"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into ref (filename,ref,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_author(
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
        for author_match in re.findall(r"\\author{.{,1000}", data):
            s = c_char_p(str.encode(author_match))
            author = CDLL("./author.so")
            author.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                author.init()
                for match in author.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_author"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into author (filename,author,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_title(
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
        for title_match in re.findall(r"\\title{.{,1000}", data):
            s = c_char_p(str.encode(title_match))
            title = CDLL("./title.so")
            title.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                title.init()
                for match in title.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_title"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into title (filename,title,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_emph(
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
        for emph_match in re.findall(r"\\emph{.{,1000}", data):
            s = c_char_p(str.encode(emph_match))
            emph = CDLL("./emph.so")
            emph.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                emph.init()
                for match in emph.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_emph"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into emph (filename,emph,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_label(
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
        for label_match in re.findall(r"\\label{.{,1000}", data):
            s = c_char_p(str.encode(label_match))
            label = CDLL("./label.so")
            label.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                label.init()
                for match in label.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_label"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into label (filename,label,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()

    def exposed_get_affiliation(
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
        for affiliation_match in re.findall(r"\\affiliation{.{,1000}", data):
            s = c_char_p(str.encode(affiliation_match))
            affiliation = CDLL("./affiliation.so")
            affiliation.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                affiliation.init()
                for match in affiliation.test(s).decode().splitlines():
                    print(match)
                    if not save:
                        self.results[f"{current_file}_affiliation"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into affiliation (filename,affiliation,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
