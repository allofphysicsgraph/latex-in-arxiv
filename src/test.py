from ragel_begin_end import RagelBeginEnd
from ragel_simple import RagelSimple

x = RagelBeginEnd()
y = RagelSimple()
with open("/home/user/latex-in-arxiv/sound1.tex", "r") as f:
    data = f.read()


x.exposed_get_abstract(data=data)
x.exposed_get_equation(data=data)
x.exposed_get_figure(data=data)
y.exposed_get_caption(data=data)
y.exposed_get_bibitem(data=data)
y.exposed_get_usepackage(data=data)
exit(0)
y.exposed_get_affiliation(data=data)
y.exposed_get_author(data=data)
y.exposed_get_title(data=data)
y.exposed_get_section(data=data)
y.exposed_get_label(data=data)
y.exposed_get_cite(data=data)
y.exposed_get_ref(data=data)
