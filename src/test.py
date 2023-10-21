from ragel_begin_end import RagelBeginEnd
from ragel_ import Ragel
#from ragel_simple import RagelSimple
from sys import argv
import rpyc 
from time import time
x = RagelBeginEnd()
#y = RagelSimple()

with open(argv[1], "r") as f:
    data = f.read()
current_file = argv[1]




simple = rpyc.connect('127.0.0.1',18861)

start = time()
simple.root.exposed_get_slm(data=data, current_file=current_file)
print('get_slm',time()-start)

start = time()
simple.root.exposed_get_usepackage(data=data, current_file=current_file)
print('get_usepackage',time()-start)

start = time()
simple.root.exposed_get_title(data=data, current_file=current_file)
print('get_title',time()-start)


start = time()
simple.root.exposed_get_affiliation(data=data, current_file=current_file)
print('get_affiliation',time()-start)

start = time()
simple.root.exposed_get_author(data=data, current_file=current_file)
print('get_author',time()-start)

start = time()
simple.root.exposed_get_section(data=data, current_file=current_file)
print('get_section',time()-start)

start = time()
simple.root.exposed_get_label(data=data, current_file=current_file)
print('get_label',time()-start)


start = time()
simple.root.exposed_get_cite(data=data, current_file=current_file)
print('get_cite',time()-start)

start = time()
simple.root.exposed_get_emph(data=data, current_file=current_file)
print('get_emph',time()-start)

start = time()
simple.root.exposed_get_url(data=data, current_file=current_file)
print('get_url',time()-start)


start = time()
simple.root.exposed_get_texttt(data=data, current_file=current_file)
print('get_texttt',time()-start)


start = time()
simple.root.exposed_get_subsection(data=data, current_file=current_file)
print('get_subsection',time()-start)


start = time()
simple.root.exposed_get_textit(data=data, current_file=current_file)
print('get_textit',time()-start)


start = time()
simple.root.exposed_get_date(data=data, current_file=current_file)
print('get_date',time()-start)


start = time()
simple.root.exposed_get_ref(data=data, current_file=current_file)
print('get_ref',time()-start)

x.exposed_get_abstract(data=data, current_file=current_file)
x.exposed_get_equation(data=data, current_file=current_file)
x.exposed_get_figure(data=data, current_file=current_file)
x.exposed_get_algorithm(data=data, current_file=current_file)
x.exposed_get_definition(data=data, current_file=current_file)
x.exposed_get_eqnarray(data=data, current_file=current_file)

