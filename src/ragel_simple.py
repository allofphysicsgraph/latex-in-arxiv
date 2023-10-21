from ctypes import CDLL
from ctypes import c_char_p
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
import rpyc

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


class RagelSimple(rpyc.Service):
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
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get affiliation_max_len if it exists in config.yaml else default to
        # 1000 chars
        affiliation_max_len = config.get("affiliation_max_len", 1000)
        q = r"\\affiliation.{{0,{}}}".format(affiliation_max_len)
        for affiliation_match in re.findall(q, data):
            s = c_char_p(str.encode(affiliation_match))
            affiliation = CDLL("./affiliation.so")
            affiliation.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                affiliation.init()
                for match in affiliation.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_author(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get author_max_len if it exists in config.yaml else default to 1000
        # chars
        author_max_len = config.get("author_max_len", 1000)
        q = r"\\author.{{0,{}}}".format(author_max_len)
        for author_match in re.findall(q, data):
            s = c_char_p(str.encode(author_match))
            author = CDLL("./author.so")
            author.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                author.init()
                for match in author.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_bibitem(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get bibitem_max_len if it exists in config.yaml else default to 1000
        # chars
        bibitem_max_len = config.get("bibitem_max_len", 1000)
        q = r"\\bibitem.{{0,{}}}".format(bibitem_max_len)
        for bibitem_match in re.findall(q, data):
            s = c_char_p(str.encode(bibitem_match))
            bibitem = CDLL("./bibitem.so")
            bibitem.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                bibitem.init()
                for match in bibitem.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_caption(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get caption_max_len if it exists in config.yaml else default to 1000
        # chars
        caption_max_len = config.get("caption_max_len", 1000)
        q = r"\\caption.{{0,{}}}".format(caption_max_len)
        for caption_match in re.findall(q, data):
            s = c_char_p(str.encode(caption_match))
            caption = CDLL("./caption.so")
            caption.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                caption.init()
                for match in caption.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_cite(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get cite_max_len if it exists in config.yaml else default to 1000
        # chars
        cite_max_len = config.get("cite_max_len", 1000)
        q = r"\\cite.{{0,{}}}".format(cite_max_len)
        for cite_match in re.findall(q, data):
            s = c_char_p(str.encode(cite_match))
            cite = CDLL("./cite.so")
            cite.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                cite.init()
                for match in cite.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_date(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get date_max_len if it exists in config.yaml else default to 1000
        # chars
        date_max_len = config.get("date_max_len", 1000)
        q = r"\\date.{{0,{}}}".format(date_max_len)
        for date_match in re.findall(q, data):
            s = c_char_p(str.encode(date_match))
            date = CDLL("./date.so")
            date.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                date.init()
                for match in date.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_date"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into date (filename,date,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()

    def exposed_get_emph(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get emph_max_len if it exists in config.yaml else default to 1000
        # chars
        emph_max_len = config.get("emph_max_len", 1000)
        q = r"\\emph.{{0,{}}}".format(emph_max_len)
        for emph_match in re.findall(q, data):
            s = c_char_p(str.encode(emph_match))
            emph = CDLL("./emph.so")
            emph.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                emph.init()
                for match in emph.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_label(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get label_max_len if it exists in config.yaml else default to 1000
        # chars
        label_max_len = config.get("label_max_len", 1000)
        q = r"\\label.{{0,{}}}".format(label_max_len)
        for label_match in re.findall(q, data):
            s = c_char_p(str.encode(label_match))
            label = CDLL("./label.so")
            label.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                label.init()
                for match in label.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_pageref(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get pageref_max_len if it exists in config.yaml else default to 1000
        # chars
        pageref_max_len = config.get("pageref_max_len", 1000)
        q = r"\\pageref.{{0,{}}}".format(pageref_max_len)
        for pageref_match in re.findall(q, data):
            s = c_char_p(str.encode(pageref_match))
            pageref = CDLL("./pageref.so")
            pageref.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                pageref.init()
                for match in pageref.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_pageref"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into pageref (filename,pageref,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()

    def exposed_get_ref(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get ref_max_len if it exists in config.yaml else default to 1000
        # chars
        ref_max_len = config.get("ref_max_len", 1000)
        q = r"\\ref.{{0,{}}}".format(ref_max_len)
        for ref_match in re.findall(q, data):
            s = c_char_p(str.encode(ref_match))
            ref = CDLL("./ref.so")
            ref.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                ref.init()
                for match in ref.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_scalebox(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get scalebox_max_len if it exists in config.yaml else default to 1000
        # chars
        scalebox_max_len = config.get("scalebox_max_len", 1000)
        q = r"\\scalebox.{{0,{}}}".format(scalebox_max_len)
        for scalebox_match in re.findall(q, data):
            s = c_char_p(str.encode(scalebox_match))
            scalebox = CDLL("./scalebox.so")
            scalebox.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                scalebox.init()
                for match in scalebox.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_section(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get section_max_len if it exists in config.yaml else default to 1000
        # chars
        section_max_len = config.get("section_max_len", 1000)
        q = r"\\section.{{0,{}}}".format(section_max_len)
        for section_match in re.findall(q, data):
            s = c_char_p(str.encode(section_match))
            section = CDLL("./section.so")
            section.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                section.init()
                for match in section.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_subsection(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get subsection_max_len if it exists in config.yaml else default to
        # 1000 chars
        subsection_max_len = config.get("subsection_max_len", 1000)
        q = r"\\subsection.{{0,{}}}".format(subsection_max_len)
        for subsection_match in re.findall(q, data):
            s = c_char_p(str.encode(subsection_match))
            subsection = CDLL("./subsection.so")
            subsection.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                subsection.init()
                for match in subsection.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_subsection"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into subsection (filename,subsection,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()

    def exposed_get_textit(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get textit_max_len if it exists in config.yaml else default to 1000
        # chars
        textit_max_len = config.get("textit_max_len", 1000)
        q = r"\\textit.{{0,{}}}".format(textit_max_len)
        for textit_match in re.findall(q, data):
            s = c_char_p(str.encode(textit_match))
            textit = CDLL("./textit.so")
            textit.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                textit.init()
                for match in textit.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_textit"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into textit (filename,textit,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()

    def exposed_get_texttt(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get texttt_max_len if it exists in config.yaml else default to 1000
        # chars
        texttt_max_len = config.get("texttt_max_len", 1000)
        q = r"\\texttt.{{0,{}}}".format(texttt_max_len)
        for texttt_match in re.findall(q, data):
            s = c_char_p(str.encode(texttt_match))
            texttt = CDLL("./texttt.so")
            texttt.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                texttt.init()
                for match in texttt.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_texttt"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into texttt (filename,texttt,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()

    def exposed_get_title(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get title_max_len if it exists in config.yaml else default to 1000
        # chars
        title_max_len = config.get("title_max_len", 1000)
        q = r"\\title.{{0,{}}}".format(title_max_len)
        for title_match in re.findall(q, data):
            s = c_char_p(str.encode(title_match))
            title = CDLL("./title.so")
            title.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                title.init()
                for match in title.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()

    def exposed_get_url(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get url_max_len if it exists in config.yaml else default to 1000
        # chars
        url_max_len = config.get("url_max_len", 1000)
        q = r"\\url.{{0,{}}}".format(url_max_len)
        for url_match in re.findall(q, data):
            s = c_char_p(str.encode(url_match))
            url = CDLL("./url.so")
            url.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                url.init()
                for match in url.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_url"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into url (filename,url,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()
    
    def exposed_get_slm(self, data=False, current_file=False, save=True, print_results=False):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get url_max_len if it exists in config.yaml else default to 1000
        # chars
        slm_max_len = config.get("slm_max_len", 1000)
        print(slm_max_len)
        q = r"\$.{{1,{}}}\$".format(slm_max_len)
        for slm_match in re.findall(q, data):
            print(slm_match)
            s = c_char_p(str.encode(slm_match))
            slm = CDLL("./slm.so")
            slm.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                slm.init()
                for match in slm.test(s).decode().splitlines():
                    # print(match)
                    if not save:
                        self.results[f"{current_file}_slm"].append(match)
                    if print_results:
                        print(match)
                    if self.postgres:
                        if not current_file:
                            current_file = self.current_file
                        length = len(match)
                        match = match.replace("'", "''")
                        cursor.execute(
                            f"insert into slm (filename,slm,len) values ('{current_file}','{match}',{length});"
                        )
                        conn.commit()
        if conn:
            conn.close()



    def exposed_get_usepackage(
        self, data=False, current_file=False, save=True, print_results=False
    ):
        conn = False
        if self.debug:
            frame = inspect.currentframe()
            print(inspect.getframeinfo(frame).function)
        if not data:
            current_file = self.current_file
            file_data = self.results[current_file][0]
            if len(self.results[f"{current_file}"]) == 1:
                data = self.results[f"{current_file}"][0]
        # get usepackage_max_len if it exists in config.yaml else default to
        # 1000 chars
        usepackage_max_len = config.get("usepackage_max_len", 1000)
        q = r"\\usepackage.{{0,{}}}".format(usepackage_max_len)
        for usepackage_match in re.findall(q, data):
            s = c_char_p(str.encode(usepackage_match))
            usepackage = CDLL("./usepackage.so")
            usepackage.test.restype = c_char_p
            if self.postgres:
                conn, cursor = self.db_cursor()
            if save or print_results:
                usepackage.init()
                for match in usepackage.test(s).decode().splitlines():
                    # print(match)
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
        if conn:
            conn.close()


if __name__ == "__main__":
    from rpyc.utils.server import ThreadedServer

    if len(sys.argv) == 2:
        port = int(sys.argv[1])
    else:
        port = 18861

    t = ThreadedServer(
        RagelSimple,
        port=port,
        protocol_config={"allow_pickle": True, "allow_all_attrs": True},
    )
    print("Ready for rpyc clients \n")
    t.start()

