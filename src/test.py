from ragel_begin_end import RagelBeginEnd
from ragel_simple import RagelSimple
from sys import argv

x = RagelBeginEnd()
y = RagelSimple()

with open(argv[1], "r") as f:
    data = f.read()
current_file = argv[1]

x.exposed_get_abstract(data=data, current_file=current_file)
x.exposed_get_equation(data=data, current_file=current_file)
x.exposed_get_figure(data=data, current_file=current_file)
x.exposed_get_algorithm(data=data, current_file=current_file)

y.exposed_get_caption(data=data, current_file=current_file)
y.exposed_get_bibitem(data=data, current_file=current_file)
y.exposed_get_usepackage(data=data, current_file=current_file)
y.exposed_get_affiliation(data=data, current_file=current_file)
y.exposed_get_author(data=data, current_file=current_file)
y.exposed_get_title(data=data, current_file=current_file)
y.exposed_get_section(data=data, current_file=current_file)
y.exposed_get_label(data=data, current_file=current_file)
y.exposed_get_cite(data=data, current_file=current_file)
y.exposed_get_ref(data=data, current_file=current_file)
y.exposed_get_texttt(data=data, current_file=current_file)
y.exposed_get_emph(data=data, current_file=current_file)
y.exposed_get_url(data=data, current_file=current_file)
y.exposed_get_subsection(data=data, current_file=current_file)
y.exposed_get_caption(data=data, current_file=current_file)
