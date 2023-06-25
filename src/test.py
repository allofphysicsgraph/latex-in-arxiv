from ragel_begin_end import RagelBeginEnd

x = RagelBeginEnd()

with open("/home/user/latex-in-arxiv/sound1.tex", "r") as f:
    data = f.read()


x.exposed_get_abstract(data=data)
x.exposed_get_equation(data=data)
