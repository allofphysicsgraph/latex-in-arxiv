import rpyc 
c = rpyc.connect('127.0.0.1',18861)
c.root.read_file('sound1.tex')
c.root.paragraphs()
c.root.sentences()
c.root.symbol_concordance()
c.root.resolved_symbols()
c.root.get_results()
