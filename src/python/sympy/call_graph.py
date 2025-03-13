#!/usr/bin/env python3
# https://greentreesnakes.readthedocs.io/en/latest/manipulating.html
from os import chdir
from file_utils import listfiles
import re
import ast


def count_directory_depth(file_name):
    return file_name.count("/")


project_path = "PATH_TO_SYMPY"
print_func = True


def print_func_name(func):
    def print_func_name_(*func_args, **func_kwargs):
        import inspect
        import re

        current_function_name = func.__name__
        if current_function_name:
            current_function_name_cleaned = re.split("_", current_function_name)[-1]
            if current_function_name_cleaned:
                print(current_function_name_cleaned)
        return func(*func_args, **func_kwargs)

    return print_func_name_


class FuncLister(ast.NodeVisitor):
    def __init__(self):
        import inspect
        import re

        self.inspect = inspect
        self.re = re
        self.lst = []

    def node_information(self, node, node_type, node_name):
        response = (node.lineno, node.col_offset, node_type, node_name)
        return response

    def visit_arg(self, node):
        if node.annotation is None:
            node_type = "arg"
            resp = self.node_information(node, node_type, node.arg)
            self.lst.append(resp)
        else:
            print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_arguments(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Assert(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_Assign(self, node):
        import inspect
        import re

        current_function_name = inspect.currentframe().f_code.co_name
        if current_function_name:
            current_function_name_cleaned = re.split("_", current_function_name)[-1]
            if current_function_name_cleaned:
                node_type = str(current_function_name_cleaned)
                resp = self.node_information(
                    node, node_type, (node.targets, node.value)
                )
                self.lst.append(resp)
                self.generic_visit(node)

    @print_func_name
    def visit_AsyncFor(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_AsyncFunctionDef(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_AsyncWith(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_AugAssign(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Await(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_BinOp(self, node):
        current_function_name = self.inspect.currentframe().f_code.co_name
        current_function_name_cleaned = self.re.split("_", current_function_name)[-1]
        node_type = current_function_name_cleaned
        resp = self.node_information(node, node_type, (node.left, node.op, node.right))
        self.lst.append(resp)
        self.generic_visit(node)

    @print_func_name
    def visit_BoolOp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Bytes(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Compare(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_comprehension(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Delete(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_DictComp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Dict(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_ExceptHandler(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Exec(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Expression(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_Expr(self, node):
        current_function_name = self.inspect.currentframe().f_code.co_name
        current_function_name_cleaned = self.re.split("_", current_function_name)[-1]
        node_type = current_function_name_cleaned
        resp = self.node_information(node, node_type, type(node.value))
        self.lst.append(resp)
        self.generic_visit(node)

    @print_func_name
    def visit_ExtSlice(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_For(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_GeneratorExp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Global(self, node):
        print("*" * 50)
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_IfExp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Index(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Interactive(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_keyword(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Lambda(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_ListComp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_List(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Module(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_NameConstant(self, node):
        current_function_name = self.inspect.currentframe().f_code.co_name
        current_function_name_cleaned = self.re.split("_", current_function_name)[-1]
        node_type = current_function_name_cleaned
        resp = self.node_information(node, node_type, node.value)
        self.lst.append(resp)
        self.generic_visit(node)

    @print_func_name
    def visit_Nonlocal(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_Num(self, node):
        current_function_name = self.inspect.currentframe().f_code.co_name
        current_function_name_cleaned = self.re.split("_", current_function_name)[-1]
        node_type = current_function_name_cleaned
        resp = self.node_information(node, node_type, node.n)
        self.lst.append(resp)
        self.generic_visit(node)

    @print_func_name
    def visit_Print(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Raise(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Repr(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_Return(self, node):
        current_function_name = self.inspect.currentframe().f_code.co_name
        current_function_name_cleaned = self.re.split("_", current_function_name)[-1]
        node_type = current_function_name_cleaned
        resp = self.node_information(node, node_type, type(node.value))
        self.lst.append(resp)
        self.generic_visit(node)

    @print_func_name
    def visit_SetComp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_Set(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Slice(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Starred(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_Str(self, node):
        current_function_name = self.inspect.currentframe().f_code.co_name
        current_function_name_cleaned = self.re.split("_", current_function_name)[-1]
        node_type = current_function_name_cleaned
        resp = self.node_information(node, node_type, node.s)
        self.lst.append(resp)
        self.generic_visit(node)

    @print_func_name
    def visit_Subscript(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Suite(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_TryExcept(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_TryFinally(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Tuple(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_UnaryOp(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_While(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_With(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_YieldFrom(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    @print_func_name
    def visit_Yield(self, node):
        print("\t", node.__dict__)
        self.generic_visit(node)

    def visit_ImportFrom(self, node):
        resp = (
            node.lineno,
            node.col_offset,
            "importFrom",
            (node.module, node.names[0].name),
        )
        self.lst.append(resp)
        self.generic_visit(node)

    def visit_Import(self, node):
        # print(node.names[0].__dict__)
        if node.names[0].asname:
            resp = (
                node.lineno,
                node.col_offset,
                "import",
                node.names[0].name + " as " + node.names[0].asname,
            )
        else:
            resp = (node.lineno, node.col_offset, "import", node.names[0].name)
        self.lst.append(resp)
        self.generic_visit(node)

    def visit_ClassDef(self, node):
        resp = (
            node.lineno,
            node.col_offset,
            "ClassDef",
            node.name,
        )
        self.lst.append(resp)
        docstring = self.get_docstring(node)
        if docstring:
            self.lst.append(docstring)
        self.generic_visit(node)

    def visit_FunctionDef(self, node):
        resp = (
            node.lineno,
            node.col_offset,
            "FunctionDef",
            node.name,
        )
        self.lst.append(resp)
        docstring = self.get_docstring(node)
        if docstring:
            self.lst.append(docstring)
        self.generic_visit(node)

    def visit_Call(self, node):
        dct = node.__dict__["func"].__dict__
        if "id" in dct.keys():
            resp = (dct["lineno"], dct["col_offset"], "call", dct["id"])
            self.lst.append(resp)
        elif "value" in dct.keys():
            dct_v1 = dct["value"].__dict__
            if "id" in dct_v1.keys():
                if "attr" in dct.keys():
                    resp = (
                        dct_v1["lineno"],
                        dct_v1["col_offset"],
                        "call",
                        dct_v1["id"] + "." + dct["attr"],
                    )
                else:
                    resp = (
                        dct_v1["lineno"],
                        dct_v1["col_offset"],
                        "call",
                        dct_v1["id"],
                    )
                self.lst.append(resp)
        self.generic_visit(node)

    def get_docstring(self, node):
        "get the docstrings"
        if (
            isinstance(
                node, (ast.FunctionDef, ast.ClassDef, ast.Module, ast.AsyncFunctionDef)
            )
            and node.body
            and isinstance(node.body[0], ast.Expr)
            and isinstance(node.body[0].value, ast.Str)
        ):
            return (
                node.lineno,
                node.col_offset,
                "docstring",
                node.body[0].value.s,
            )

    def filters(self, df, column, pattern):
        import pandas as pd
        import re

        df.loc[:, column] = df.loc[:, column][
            df.loc[:, column].apply(
                lambda x: True if not self.re.findall(pattern, str(x)) else False
            )
        ]
        df.dropna(subset=[column], inplace=True)
        return df

    def output_DataFrame(self):
        import pandas as pd

        df = pd.DataFrame(self.lst)
        df.columns = ["line_no", "col_offset", "type", "name"]
        return df


def df_query(query_string, df):
    import re

    df[
        df.apply(
            lambda row: (
                True
                if re.findall(query_string, str(row.astype(str)), re.IGNORECASE)
                else False
            ),
            axis=1,
        )
    ]
    return df


if __name__ == "__main__":
    from file_utils import read_file
    from file_utils import listfiles
    from file_utils import process_file
    import re
    import time
    import os
    import shutil

    to_be_processed = []
    # sort on depth of directories in ascending order
    file_lst = sorted(
        list(listfiles(project_path)), key=lambda x: count_directory_depth(x)
    )

    for file_name in file_lst:
        # if output_file_name previously exists
        output_file_name = file_name.replace(".py", ".csv")
        if os.path.isfile(output_file_name):
            shutil.copy(
                "{}".format(output_file_name),
                "{}_{}.csv".format(output_file_name, time.time()),
            )
            os.unlink(output_file_name)
        try:
            process_file(file_name, output_file_name)
        except Exception as err:
            print(err)
