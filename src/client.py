import rpyc

c = rpyc.connect("127.0.0.1", 18861)
c.root.read_file("sound1.tex", "file_data")
c.root.paragraphs()
c.root.sentences()
c.root.symbol_concordance()
# c.root.resolved_symbols()
# c.root.get_results()
# c.root.bag_of_words()
# c.root.preprocessing()
c.root.build_word_tokenizers()
c.root.print_tokenized_sentences()
