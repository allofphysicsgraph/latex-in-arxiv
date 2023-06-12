import rpyc
from os import remove 
from redis import Redis
client = Redis(decode_responses=True)

ignore =['0301052.tex','0301053.tex','0301055.tex','0301056.tex','0301066.tex','0301071.tex','0301078.tex','0301077_cleaned.tex','0301062.tex','0301037.tex','0301042.tex','0301043.tex','0301046.tex','0301050.tex','0301050.tex',
         '0301082.tex',
'0301083.tex','0301088.tex','0301093.tex','0301094.tex','0301097.tex',
"0301067_cleaned.tex",
"0301069_cleaned.tex",
         ]
#for f_name in client.lrange('wont_import',0,-1):
#    ignore.append(f_name)
for entry in ignore:
    try:
        pass
        #remove(f'../2003/{entry}')
    except:
        pass
c = rpyc.connect("127.0.0.1", 18861)
c.root.exposed_process_data_set()
# c.root.paragraphs()
# c.root.sentences()
# c.root.get_abstract(print_results=True)


exit(0)
c.root.read_file("sound1.tex", "file_data")
c.root.symbol_concordance()
# c.root.resolved_symbols()
# c.root.get_results()
# c.root.bag_of_words()
# c.root.preprocessing()
c.root.build_word_tokenizers()
c.root.print_tokenized_sentences()

c.root.get_affiliation(print_results=True)
c.root.get_algorithm(print_results=True)
c.root.get_author(print_results=True)
# c.root.get_bibitem(print_results=True)
# c.root.get_bibliography(print_results=True)
# c.root.get_center(print_results=True)
c.root.get_cite(print_results=True)
# c.root.get_definition(print_results=True)
c.root.get_emph(print_results=True)
# c.root.get_eqnarray(print_results=True)
# c.root.get_figure(print_results=True)
# c.root.get_itemize(print_results=True)
# c.root.get_keywords(print_results=True)
c.root.get_label(print_results=True)
c.root.get_ref(print_results=True)
c.root.get_section(print_results=True)
c.root.get_slm(print_results=True)
c.root.get_title(print_results=True)
c.root.get_url(print_results=True)


# depends on english_word_tokenizer
# depends on sentences
c.root.rank_bm25()
c.root.query_rank_bm25("fundamental constants")
"0301079.tex",
